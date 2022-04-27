#!/bin/bash

ls -1 results/*fps*|grep -v multi | grep -v 8002| while read p; do
  echo -n `basename $p .json`;
  node -e "let r=JSON.parse(require('fs').readFileSync(\"$p\",'utf8'));process.stdout.write('\t'+r.join(',')+'\n')"; 
done
