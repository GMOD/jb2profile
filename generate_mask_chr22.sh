#!/bin/bash
samtools faidx https://jbrowse.org/genomes/hg19/fasta/hg19.fa.gz 22:25000000-25250000|sed "s/^>.*/>chr22_mask/" > chr22.mask.fa
bgzip -i -c chr22.mask.fa > chr22.mask.fa.gz
samtools faidx chr22.mask.fa.gz
