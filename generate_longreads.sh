#!/bin/bash

./easy_align_long.sh chr22.mask.fa 5000x_0001.fastq 5000x.longread.cram;
echo "done align"



for i in 02 20 40 60 80; do
  k=0.$i
  a=$(echo  "5000*$k/1"|bc );
  echo Subsampling $k $ax;
  samtools view -T chr22.mask.fa 5000x.longread.cram -s 50.$i -o "$a"x.longread.cram
done;



