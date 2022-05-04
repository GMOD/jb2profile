#!/bin/bash

echo -e "program\twindow\tcoverage\tread_type\tfile_type\ttime\tsd"
ls results/* | grep -v fps| grep -v multi | grep -v mem | grep -v 19kb| while read p; do
  node process_runtime_table.js $p;
done
