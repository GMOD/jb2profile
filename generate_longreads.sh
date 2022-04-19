#!/bin/bash

for i in 20x 420x 820x 1220x 1620x 2020x 2420x 2820x; do
  badread simulate --reference volvox.fa --quantity $i --length 40000,100 > $i.fastq;
  ./easy_align_long.sh volvox.fa $i.fastq $i.longread.cram;
  samtools view -T volvox.fa -@3 $i.longread.cram -o $i.longread.bam
  samtools index -@3 $i.longread.bam
done;
 
