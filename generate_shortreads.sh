#!/bin/bash

./easy_align_short.sh chr22.mask.fa.gz 5000x.1.fq 5000x.2.fq 5000x.shortread.cram;
echo "done align"


for i in 02 10 20 30 40 50 60 70 80 90; do
  k=0.$i
  a=$(echo  "5000*$k/1"|bc );
  samtools view -T chr22.mask.fa.gz 5000x.shortread.cram -s 50.$i -o $a.shortread.cram
done;

 


