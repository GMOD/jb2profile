#!/bin/bash
samtools view -T hg19mod.fa 1000x.longread.cram -s 1.02 -o multi1.sm.longread.cram
samtools view -T hg19mod.fa 1000x.longread.cram -s 2.02 -o multi2.sm.longread.cram
samtools view -T hg19mod.fa 1000x.longread.cram -s 3.02 -o multi3.sm.longread.cram
samtools view -T hg19mod.fa 1000x.longread.cram -s 4.02 -o multi4.sm.longread.cram
samtools view -T hg19mod.fa 1000x.longread.cram -s 5.02 -o multi5.sm.longread.cram

samtools view -T hg19mod.fa 1000x.longread.cram -s 1.02 -o multi1.sm.longread.bam
samtools view -T hg19mod.fa 1000x.longread.cram -s 2.02 -o multi2.sm.longread.bam
samtools view -T hg19mod.fa 1000x.longread.cram -s 3.02 -o multi3.sm.longread.bam
samtools view -T hg19mod.fa 1000x.longread.cram -s 4.02 -o multi4.sm.longread.bam
samtools view -T hg19mod.fa 1000x.longread.cram -s 5.02 -o multi5.sm.longread.bam






samtools view -T hg19mod.fa 1000x.longread.cram -s 1.2 -o multi1.md.longread.cram
samtools view -T hg19mod.fa 1000x.longread.cram -s 2.2 -o multi2.md.longread.cram
samtools view -T hg19mod.fa 1000x.longread.cram -s 3.2 -o multi3.md.longread.cram
samtools view -T hg19mod.fa 1000x.longread.cram -s 4.2 -o multi4.md.longread.cram
samtools view -T hg19mod.fa 1000x.longread.cram -s 5.2 -o multi5.md.longread.cram




samtools view -T hg19mod.fa 1000x.longread.cram -s 1.2 -o multi1.md.longread.bam
samtools view -T hg19mod.fa 1000x.longread.cram -s 2.2 -o multi2.md.longread.bam
samtools view -T hg19mod.fa 1000x.longread.cram -s 3.2 -o multi3.md.longread.bam
samtools view -T hg19mod.fa 1000x.longread.cram -s 4.2 -o multi4.md.longread.bam
samtools view -T hg19mod.fa 1000x.longread.cram -s 5.2 -o multi5.md.longread.bam

for i in multi*; do samtools index -@3 $i; done;
