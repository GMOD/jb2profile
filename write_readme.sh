#!/bin/bash
for i in results/*.json; do
  echo $i
  node format.js $i;
  echo -e "\n\n\n"
done >> README.md
 

