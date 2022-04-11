#!/bin/bash
minimap2 -t 8 -a -x sr "$1" "$2" "$3"  | \
samtools fixmate -u -m - - | \
samtools sort -u -@2 - | \
samtools markdup -@8 --reference "$1" - --write-index "$4"
