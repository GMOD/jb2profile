#!/bin/bash

./easy_align_short.sh hg19mod.fa 5000x.1.fq 5000x.2.fq 5000x.shortread.cram;
echo "done align"


for i in 002 02 20 40 60 80; do
  k=0.$i
  a=$(echo  "5000*$k/1"|bc );
  echo Subsampling $k $ax;
  samtools view -T hg19mod.fa 5000x.shortread.cram -s 50.$i -o "$a"x.shortread.cram
done;
