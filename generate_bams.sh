#!/bin/bash
for i in *.cram; do
  echo $i
  samtools view -T chr22.mask.fa.gz -@3 $i -o `basename $i .cram`.bam;
  samtools index -@3 `basename $i .cram`.bam;
done;
