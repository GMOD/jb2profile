#!/bin/bash
samtools faidx https://jbrowse.org/genomes/hg19/fasta/hg19.fa.gz 22:25000000-25250000|sed "s/^>.*/>chr22_mask/" > hg19mod.fa
samtools faidx hg19mod.fa
