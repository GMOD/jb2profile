#!/bin/bash

./easy_align_long.sh hg19mod.fa 1000x_0001.fastq 1000x.longread.cram;
echo "done align"



for i in 02 20 40 60 80; do
  k=0.$i
  a=$(echo  "1000*$k/1"|bc );
  echo Subsampling $k $ax;
  samtools view -T hg19mod.fa 1000x.longread.cram -s 50.$i -o "$a"x.longread.cram
done;


