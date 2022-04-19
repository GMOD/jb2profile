#!/bin/bash
## 5000x coverage calcualted by formula N*(2*100bp)/len(chr22.mask)=coverage
## w/ mask being a 50,000,000bp region of chr22
wgsim -N 12500000 chr22.mask.fa.gz 5000x.1.fq 5000x.2.fq;
