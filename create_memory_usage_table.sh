#!/bin/bash

ls -1 results/*mem*|grep -v multi|while read p; do
  echo -n `basename $p .json`;
  node -e "process.stdout.write('\t'+JSON.parse(require('fs').readFileSync(\"$p\",'utf8')).mem.usedJSHeapSize+'\n')"; 
done
