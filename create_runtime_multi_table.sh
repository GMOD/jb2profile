#!/bin/bash

echo -e "program\twindow\tcoverage\tread_type\tfile_type\ttime\texit_code"
ls results/* | grep -v fps| grep multi | grep -v mem | while read p; do
  node process_runtime_multi_table.js $p;
done
