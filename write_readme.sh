#!/bin/bash
for i in results/*.json; do
  echo $i
  node format.js $i;
done >> README.md
 

