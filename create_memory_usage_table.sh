#!/bin/bash

for i in results2/*mem*; do
  echo -n `basename $i .json`;
  node -e "process.stdout.write('\t'+JSON.parse(require('fs').readFileSync(\"$i\",'utf8')).mem.usedJSHeapSize+'\n')"; 
done
