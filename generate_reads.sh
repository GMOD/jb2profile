#!/bin/bash


./generate_mask_chr22.sh
./simulate_shortreads.sh
./simulate_longreads.sh
./generate_longreads.sh
./generate_shortreads.sh
./generate_bams.sh
