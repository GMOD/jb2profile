#!/bin/bash

echo -e "program\twindow\tcoverage\tread_type\tfile_type\ttime\texit_code"
ls results/* | grep -v fps|grep -v multi | while read p; do node tablify_results.js $p; done
