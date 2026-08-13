del IncrementalLoad_Member.log
snowsql -a upmchp.east-us-2.azure -u batchload_user --private-key-path ..\..\..\Account\Keys\rsa_key.p8 -f IncrementalLoad_Member.sql -d IDAP_DEV -s INFA -w DS_LOAD_WH -o exit_on_error=true -o log_level=debug -o timing_in_output_file=True -o output_file=IncrementalLoad_Member.log
pause