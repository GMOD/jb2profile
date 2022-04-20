#!/bin/bash

ls -1 results/*mem*|grep -v multi|while read p; do
  echo -n `basename $p .json` $'\t';
  node -e "console.log(JSON.parse(require('fs').readFileSync(\"$p\")).JSHeapUsedSize)"
done
