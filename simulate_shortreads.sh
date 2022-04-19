#!/bin/bash
## 5000x coverage calcualted by formula N*(2*150bp)/len(chr22.mask)=coverage
## based on 150bp paired end illumina type reads
## w/ the mask being a 250,000bp region of chr22
wgsim -1 150 -2 150 -N 4166666 chr22.mask.fa.gz 5000x.1.fq 5000x.2.fq;
