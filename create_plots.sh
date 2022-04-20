#!/bin/bash

## single-tracks at once runtime
./create_runtime_table.sh > runtime_table_processed.csv
Rscript plot_runtime.R

## multi-tracks at once runtime
./create_runtime_multi_table.sh > runtime_multi_table_processed.csv
Rscript plot_multi_runtime.R




## fps
./create_fps_table.sh > fps_table.csv
node process_fps_table.js fps_table.csv > fps_table_processed.csv
Rscript plot_fps.R

## memory
./create_memory_usage_table.sh > memory_usage.csv
node process_memory_usage_table.js memory_usage.csv > memory_usage_processed.csv
Rscript plot_memory_usage.R
