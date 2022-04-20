#!/bin/bash

./easy_align_short.sh hg19mod.fa 1000x.1.fq 1000x.2.fq 1000x.shortread.cram;
echo "done align"


for i in 02 03 04 05 20 40 60 80 81 82 83; do
  k=0.$i
  a=$(echo  "1000*$k/1"|bc );
  echo Subsampling $k $ax;
  samtools view -T hg19mod.fa 1000x.shortread.cram -s 50.$i -o "$a"x.shortread.cram
done;
