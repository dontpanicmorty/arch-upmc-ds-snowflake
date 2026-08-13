del FullExtractLoad.log
snowsql -a upmchp.east-us-2.azure --authenticator externalbrowser -r BATCHLOAD_ROLE -f ..\..\LoadFullExtract.sql -d IDAP -s DIMDATA -w DS_LOAD_WH -o exit_on_error=true -o log_level=DEBUG -o timing_in_output_file=True -o output_file=FullExtractLoad.log
pause