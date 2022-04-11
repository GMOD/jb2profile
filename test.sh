#!/bin/bash

for i in 10000 20000 40000 80000 160000 320000 640000; do
  wgsim -N $i volvox.fa $i.1.fq $i.2.fq;
  ./easy_align_short.sh volvox.fa $i.1.fq $i.2.fq $i.shortread.cram;
done;

for i in 40x 80x 160x 320x 640x 1280x 2560x; do
  badread simulate --reference volvox.fa --quantity $i --length 40000,100 > $i.fastq;
  ./easy_align_long.sh volvox.fa $i.fastq $i.longread.cram;
done;
  


