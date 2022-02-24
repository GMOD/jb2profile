#!/bin/bash

## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT

## start servers on different ports
npx http-server igvjs/build -s -p 8000 &
npx http-server jb2web -s -p 8001 &
npx http-server jb2web_optim -s -p 8002 &
npx http-server jb2lgv/build -s -p 8003 &

profile () {
  echo $0 $1 $2 $3
  hyperfine --export-markdown $3 --warmup 1 \
    "node profile_jb2web.js \"http://localhost:8001/?loc=$1&assembly=volvox&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8002/?loc=$1&assembly=volvox&tracks=$2\"" \
    "node profile_igvjs.js \"http://localhost:8000/?loc=$1&trackId=$2\"" \
    "node profile_jb2web.js \"http://localhost:8003/?loc=$1&trackId=$2\""
  echo -e "\n\n\n\n\n\n\n"
}

profile "ctgA:19,000-21,000" "volvox-sorted.bam"  "results/small_shortread_bam.md"
profile "ctgA:19,000-21,000" "volvox-sorted.cram"  "results/small_shortread_cram.md"
profile "ctgA:19,000-21,000" "volvox-wgsim.cram"  "results/large_shortread_cram.md"
profile "ctgA:19,000-21,000" "volvox-wgsim.bam"  "results/large_shortread_bam.md"
profile "ctgA:19,000-21,000" "badread.1000x.cram"  "results/large_longread_cram.md"
profile "ctgA:19,000-21,000" "badread.50x.cram"  "results/small_longread_cram.md"



for i in results/*.md; do echo $i; echo -e "\n"; cat $i; echo -e "\n"; done >> README.md
