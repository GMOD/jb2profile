#!/bin/bash

## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT

## start servers on different ports
npx http-server igvjs/build -s -p 8000 &
npx http-server jb2_165 -s -p 8001 &
npx http-server jb2_167 -s -p 8002 &
npx http-server jb2optim1 -s -p 8003 &
npx http-server jb2optim2 -s -p 8004 &
npx http-server jb2lgv/build -s -p 8005 &

profile () {
  echo $0 $1 $2 $3
  hyperfine  --export-markdown $3 --runs 4 --show-output  \
    "node profile_igvjs.js \"http://localhost:8000/?loc=$1&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8001/?loc=$1&assembly=volvox&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8002/?loc=$1&assembly=volvox&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8003/?loc=$1&assembly=volvox&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8004/?loc=$1&assembly=volvox&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8005/?loc=$1&tracks=$2\""
  echo -e "\n\n\n\n\n\n\n"
}

profile "ctgA:19,000-29,000" "volvox-sorted.bam"  "results/small_shortread_bam.md"
profile "ctgA:19,000-29,000" "volvox-sorted.cram"  "results/small_shortread_cram.md"
profile "ctgA:19,000-21,000" "volvox-wgsim.cram"  "results/large_shortread_cram.md"
profile "ctgA:19,000-21,000" "volvox-wgsim.bam"  "results/large_shortread_bam.md"
profile "ctgA:100-150" "volvox-wgsim.bam"  "results/large_shortread_bam_small_region.md"
profile "ctgA:19,000-21,000" "badread.1000x.cram"  "results/large_longread_cram.md"
profile "ctgA:19,000-21,000" "badread.1000x.bam"  "results/large_longread_bam.md"
profile "ctgA:19,000-29,000" "badread.50x.cram"  "results/small_longread_cram.md"
profile "ctgA:19,000-29,000" "badread.50x.cram,volvox-sorted.cram"  "results/small_multi_cram.md"
profile "ctgA:19,000-29,000" "badread.50x.bam,volvox-sorted.bam"  "results/small_multi_bam.md"
profile "ctgA:19,000-21,000" "badread.1000x.cram,volvox-wgsim.cram"  "results/large_multi_cram.md"
profile "ctgA:19,000-21,000" "badread.1000x.bam,volvox-wgsim.bam"  "results/large_multi_bam.md"




./write_readme.sh
