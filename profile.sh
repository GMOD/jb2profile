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
  echo $0 $1 $2 $3 $4
  hyperfine  --export-json $3 --runs 4  \
    "node profile_igvjs.js \"http://localhost:8000/?loc=$1&assembly=$4&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8001/?loc=$1&assembly=$4&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8002/?loc=$1&assembly=$4&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8003/?loc=$1&assembly=$4&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8004/?loc=$1&assembly=$4&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8005/?loc=$1&assembly=$4&tracks=$2\"" \
    "jb2export --assembly $4 --loc $1 --configtracks $2 --config jb2_165/config.json"
  echo -e "\n\n\n\n\n\n\n"
}

profile "ctgA:19,000-29,000" "volvox-sorted.bam"  "results/volvox-20x-shortread-bam-10kb.md"
profile "ctgA:19,000-29,000" "volvox-sorted.cram"  "results/volvox-20x-shortread-cram-10kb.md"
profile "ctgA:19,000-21,000" "volvox-wgsim.cram"  "results/volvox-2400x-shortread-cram-2kb.md"
profile "ctgA:19,000-21,000" "volvox-wgsim.bam"  "results/volvox-2400x-shortread-bam-2kb.md"
profile "ctgA:100-150" "volvox-wgsim.bam"  "results/volvox-2400x-shortread-bam-100bp.md"
profile "ctgA:19,000-21,000" "badread.1000x.cram"  "results/volvox-1000x-longread-cram.md"
profile "ctgA:19,000-21,000" "badread.1000x.bam"  "results/volvox-1000x-longread-bam.md"
profile "ctgA:19,000-29,000" "badread.50x.cram"  "results/volvox-50x-longread-cram.md"
profile "ctgA:19,000-29,000" "badread.50x.cram,volvox-sorted.cram,badread.50x.bam,volvox-sorted.bam"  "results/volvox-multi-lowcov.md"
profile "ctgA:19,000-21,000" "badread.1000x.cram,volvox-wgsim.cram,badread.1000x.bam,volvox-wgsim.bam"  "results/volvox-multi-highcov.md"


profile "22:21,999,999..22,000,100" "ultra-long-ont_hs37d5_phased.cram"  "results/hg19_ultralong_cram_100b.md" "hg19"
profile "22:21,999,999..22,001,999" "ultra-long-ont_hs37d5_phased.cram"  "results/hg19_ultralong_cram_2kb.md" "hg19"
profile "22:21,999,999..22,020,999" "ultra-long-ont_hs37d5_phased.cram"  "results/hg19_ultralong_cram_20kb.md" "hg19"
profile "22:21,999,999..22,050,999" "ultra-long-ont_hs37d5_phased.cram"  "results/hg19_ultralong_cram_50kb.md" "hg19"

profile "22:21,999,999..22,000,100" "ultra-long-ont_hs37d5_phased.bam"  "results/hg19_ultralong_bam_100b.md" "hg19"
profile "22:21,999,999..22,001,999" "ultra-long-ont_hs37d5_phased.bam"  "results/hg19_ultralong_bam_2kb.md" "hg19"
profile "22:21,999,999..22,020,999" "ultra-long-ont_hs37d5_phased.bam"  "results/hg19_ultralong_bam_20kb.md" "hg19"
profile "22:21,999,999..22,050,999" "ultra-long-ont_hs37d5_phased.bam"  "results/hg19_ultralong_bam_50kb.md" "hg19"



./write_readme.sh
