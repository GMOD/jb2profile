#!/bin/bash
## 1000x coverage calcualted by formula N*(2*150bp)/len(chr22.mask)=coverage
## based on 150bp paired end illumina type reads
## w/ the mask being a 250,000bp region of chr22
wgsim -1 150 -2 150 -N 1000000 hg19mod.fa 1000x.1.fq 1000x.2.fq;
