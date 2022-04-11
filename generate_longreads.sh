#!/bin/bash

for i in 40x 80x 160x 320x 640x 1280x 2560x; do
  badread simulate --reference volvox.fa --quantity $i --length 40000,100 > $i.fastq;
  ./easy_align_long.sh volvox.fa $i.fastq $i.longread.cram;
  samtools view -T volvox.fa -@3 $i.longread.cram -o $i.longread.bam
  samtools index -@3 $i.longread.bam
done;
 
