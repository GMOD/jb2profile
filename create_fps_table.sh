#!/bin/bash

for i in results/*fps*; do
  echo -n `basename $i .json`;
  node -e "let r=JSON.parse(require('fs').readFileSync(\"$i\",'utf8'));process.stdout.write('\t'+r.reduce((a,b)=>a+b,0)/r.length+'\n')"; 
done
