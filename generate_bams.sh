#!/bin/bash
for i in *.cram; do
  echo $i
  samtools index -@3 $i;
  samtools view -T hg19mod.fa -@3 $i -o `basename $i .cram`.tmp.bam;
  samtools calmd -@3 `basename $i .cram`.tmp.bam hg19mod.fa --output-fmt BAM > `basename $i .cram`.bam;
  samtools index -@3 `basename $i .cram`.bam;
done;
