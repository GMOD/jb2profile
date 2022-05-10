#!/bin/bash

for l in longread shortread; do
  for i in {1..5}; do
    for j in 02 05 10 15; do
      for f in bam cram; do
        k=0.$j;
        a=$(echo  "1000*$k/1"|bc );
        echo $i $a $l $f
        samtools view -T hg19mod.fa 1000x.$l.cram -s $i.$j -o multi$i."$a"x.$l.$f;
      done;
    done;
  done;
done;




for i in multi*.bam multi*.cram; do
  echo $i
  samtools index -@3 $i;
done;
