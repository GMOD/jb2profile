#!/bin/bash


samtools faidx https://jbrowse.org/genomes/hg19/fasta/hg19.fa.gz 22 > chr22.fa
bgzip -i chr22.fa
samtools faidx chr22.fa.gz

./generate_longreads.sh
./generate_shortreads.sh
