#!/bin/bash
for i in results/*.json; do node prof.js $i; done >> README.md
 

