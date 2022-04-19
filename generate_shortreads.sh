#!/bin/bash

## 5000x coverage calcualted by formula N*(2*100bp)/len(chr22)=coverage
wgsim -N 1282614150 chr22.fa.gz 5000x.1.fq 5000x.2.fq;
echo "done sim"
./easy_align_short.sh chr22.fa.gz 5000x.1.fq 5000x.2.fq 5000x.shortread.cram;
echo "done align"


for i in 02 10 20 30 40 50 60 70 80 90; do
  k=0.$i
  a=$(( 5000*k ));
  echo $i;
  samtools view -T volvox.fa 5000x.shortread.cram -s 50.$i -o $a.shortread.cram
done;

 


for i in *.cram; do
  echo $i
  samtools view -T volvox.fa -@3 $i -o `basename $i .cram`.bam;
  samtools index -@3 `basename $i .cram`.bam;
done;
