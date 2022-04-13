#!/bin/bash

ls -1 results/*mem*|grep -v multi|while read p; do
  echo -n `basename $p .json` $'\t';
  cat $p | grep 'Maximum resident'|sed -e 's/.*Maximum resident set size (kbytes): //';
done
