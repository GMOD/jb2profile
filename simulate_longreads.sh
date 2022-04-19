#!/bin/bash
pbsim hg19mod.fa --depth 5000 --hmm_model data/R103.model --length-mean 50000 --prefix 5000x
rm *.ref
rm *.maf
