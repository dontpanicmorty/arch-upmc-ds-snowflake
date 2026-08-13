del IncrementalLoad_Full.log
snowsql -a upmchp.east-us-2.azure -u batchload_user --private-key-path ..\..\..\Account\Keys\rsa_key.p8 -f IncrementalLoad_Full.sql -d IDAP -s STAGEDATA -w DS_LOAD_WH -o exit_on_error=true -o log_level=DEBUG -o timing_in_output_file=True -o timing_in_output_file=True -o output_file=IncrementalLoad_Full.log
pause
