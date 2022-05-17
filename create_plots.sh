#!/bin/bash

## single-tracks at once runtime
./create_runtime_table.sh > runtime_table_processed.csv
Rscript plot_runtime.R



## fps
./create_fps_table.sh > fps_table.csv
node process_fps_table.js fps_table.csv > fps_table_processed.csv
node process_fps_table2.js fps_table.csv  > fps_table_processed2.csv
Rscript plot_fps.R



## multi-tracks at once runtime
./create_runtime_multi_table.sh > runtime_multi_table_processed.csv
Rscript plot_multi_runtime.R

