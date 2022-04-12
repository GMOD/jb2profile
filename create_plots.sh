#!/bin/bash

./create_fps_table.sh > fps_table.csv
node process_fps_table.js > fps_table_processed.csv
Rscript fps_plots.R

./create_memory_usage_table.sh > memory_usage.csv
node process_memory_usage_table.js > memory_usage_processed.csv
Rscript memory_usage_plots.R
