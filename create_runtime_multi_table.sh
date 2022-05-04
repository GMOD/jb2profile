#!/bin/bash

echo -e "program\twindow\tcoverage\tnum_tracks\tread_type\tfile_type\ttime\tsd"
ls results/* | grep -v fps| grep multi | grep -v mem | while read p; do
  node process_runtime_multi_table.js $p;
done
