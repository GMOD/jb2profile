#!/bin/bash
samtools faidx https://jbrowse.org/genomes/hg19/fasta/hg19.fa.gz 22:25000000-25500000|sed "s/^>.*/>chr22_mask/" > chr22.mask.fa
bgzip -i chr22.mask.fa
samtools faidx chr22.mask.fa.gz
