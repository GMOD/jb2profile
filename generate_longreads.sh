#!/bin/bash

./easy_align_long.sh chr22.mask.fa.gz 5000x.fq 5000x.longread.cram;
echo "done align"



for i in 02 10 20 30 40 50 60 70 80 90; do
  k=0.$i
  a=$(echo  "5000*$k/1"|bc );
  echo Subsampling $k $ax;
  samtools view -T chr22.mask.fa.gz 5000x.longread.cram -s 50.$i -o "$a"x.longread.cram
done;



