#!/bin/bash

## downloads instances
./build.sh

## generates data
./generate_reads.sh


## loads data
./load.sh

## does profiling
./profile.sh

