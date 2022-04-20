#!/bin/bash
pbsim hg19mod.fa --depth 1000 --hmm_model data/R103.model --length-mean 50000 --prefix 1000x
rm *.ref
rm *.maf
