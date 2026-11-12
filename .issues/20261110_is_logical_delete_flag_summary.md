# IS_LOGICAL_DELETE_FLAG: Steve's approach

Source: working session of November 10, 2026 (`20261110_working_session.txt`), Maurice's question to Steve.

## The question

While building the fact provider contract, several dimension tables used in its joins have no
`IS_LOGICAL_DELETE_FLAG`. Should the flag be added to those tables' stage data views, or to their load
procedures?

## Short answer

- Only add the flag to tables that keep history (type 2). Never add it to tables that don't (type 1).
- Where a table does keep history, the load procedure sets the flag, not the stage data view.
- For `DIM_PROVIDER_CONTRACT_ATTRIBUTE`, which doesn't keep history, remove the flag check from the join
  logic and from the STTM.

## Two kinds of dimension table

| | Keeps history (type 2) | Keeps only the latest values (type 1) |
|---|---|---|
| What happens when a value changes | The old row is kept and closed off, and a new row is added | The row is overwritten |
| Has effective and expiration date columns | Yes, always | No |
| Has `IS_LOGICAL_DELETE_FLAG` | Yes | No, and joins to it must not check for one |

How to tell which one a table is:

1. **Look at the columns.** A table with no effective and expiration dates can't be type 2. One with
   both dates and the flag is type 2.
2. **Look at what the data means.** Ask whether its history matters for analysis. A contract's termination
   reason code and description don't. Reports only need the current description of each code. So
   `DIM_PROVIDER_CONTRACT_ATTRIBUTE` (attribute key, termination reason code and description, inserted and
   last updated dates) is type 1.

Nothing written down marks which tables are which today. It is inferred from the columns and the data.

## What the flag is for

- The real test of a history-keeping table is its date span: when each version took effect and when it
  expired.
- The flag is a shortcut for queries. Instead of checking that today falls between the two dates, a
  query checks `IS_LOGICAL_DELETE_FLAG = FALSE`.
- For each span there is one row with the flag false (the current version) and possibly many with it
  true (replaced versions).
- "Current" is not the same as "active". The flag says a row is the latest version of the record. It
  does not say whether the business fact is still in effect. For example, an old address span can be
  corrected, such as a zip code fix, without changing when that address applied.
- Steve said his explanation of this point may have gaps.

## Where the flag gets set: the convention

The flag is not part of the stage data view. The procedure that merges stage data into the dimension
sets it. It has to live there because the decision compares two things the view can't see together:
what is arriving from the Data Hub and raw extracts, and what is already in the dimension.

| Incoming record | Already in the dimension? | What the procedure does |
|---|---|---|
| Same values | Yes | Nothing |
| Different values | Yes | Marks the existing row as logically deleted and inserts the new version |
| Any | No | Inserts it |

## Known exceptions and risks

- **Data from Info.** Info runs its own fact and dimension model on SQL Server and sets the flag itself.
  Its records arrive with the flag already set, so those tables may not follow the convention.
- **The provider tables** are already inconsistent, so fitting them to the convention may take some trial
  and error, case by case.
- **Converting old data.** The history behind older records is incomplete, so there is a risk of wrongly
  flagging old rows as deleted.
- **The goal stays the same:** every table follows the convention, with the flag set in the procedure.

## Don't turn a type 1 table into type 2 casually

Converting a table to keep history needs a wider team conversation first, because:

- the history has to be relevant and worth keeping;
- the whole dimension has to be reprocessed;
- everyone who queries it today must change their queries to account for history.

So the fix is to update the mapping and logic of tables that are type 1 today, not to add history to them.

## Next steps

- **Maurice:** take the flag check off the `DIM_PROVIDER_CONTRACT_ATTRIBUTE` join in the fact provider
  contract and rerun it. If nothing else errors, it's done. If something does, check each joined table's
  columns for the date span and the flag, and keep the flag check only where both exist. Check with
  Alyssa, who worked on the fact provider contract STTM, and remove the flag from the STTM wherever it
  doesn't apply.
- **Steve:** look into tagging tables that keep history, so the team doesn't have to infer it.
- **For new stage data fact views, use this convention now:**
  1. Leave the flag out of stage data views.
  2. In joins, check the flag only on type 2 dimensions.
  3. Let the merge procedures set the flag.
