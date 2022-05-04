#!/bin/bash

## single-tracks at once runtime
./create_runtime_table.sh > runtime_table_processed.csv
Rscript plot_runtime.R



## fps
./create_fps_table.sh > fps_table.csv
node process_fps_table.js fps_table.csv > fps_table_processed.csv
Rscript plot_fps.R


## multi-tracks at once runtime
./create_runtime_multi_table.sh > runtime_multi_table_processed.csv
Rscript plot_multi_runtime.R

## figure for paper multi figure
convert -append img/*multi* img/img1.png

## figure for single, with separate panels
montage -mode concatenate -tile 2x  img/bam_sr.png img/bam_lr.png img/cram_sr.png img/cram_lr.png img/img2.png

## figure for fps
convert -append img/*average* img/img3.png
convert -append img/*cumsums* img/img4.png
