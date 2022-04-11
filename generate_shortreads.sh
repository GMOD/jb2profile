#!/bin/bash

wgsim -N 10000 volvox.fa 28x.1.fq 28x.2.fq;
wgsim -N 20000 volvox.fa 56x.1.fq 56x.2.fq;
wgsim -N 40000 volvox.fa 112x.1.fq 112x.2.fq;
wgsim -N 80000 volvox.fa 224x.1.fq 224x.2.fq;
wgsim -N 160000 volvox.fa 448x.1.fq 448x.2.fq;
wgsim -N 320000 volvox.fa 896x.1.fq 896x.2.fq;
wgsim -N 640000 volvox.fa 1792x.1.fq 1792x.2.fq;

for i in 28x 56x 112x 224x 448x 896x 1792x; do
  ./easy_align_short.sh volvox.fa $i.1.fq $i.2.fq $i.shortread.cram;
  samtools view -T volvox.fa -@3 $i.shortread.cram -o $i.shortread.bam;
  samtools index -@3 $i.shortread.bam;
done;

 


