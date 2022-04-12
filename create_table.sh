#!/bin/bash

echo -e "program\twindow\tcoverage\ttime\texit_code"
ls results/* | grep -v fps | while read p; do node tablify_results.js $p; done
