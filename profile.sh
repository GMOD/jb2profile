#!/bin/bash

## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT

## start servers on different ports
npx http-server igvjs/build -s -p 8000 &
npx http-server jb2_main -s -p 8004 &
npx http-server jb2_noserialize -s -p 8005 &
npx http-server jb2lgv/build -s -p 8006 &

sleep 1

profile () {
  echo $0 $1 $2 $3 $4
  hyperfine  --export-json $3 --runs 1  \
    "node profile_igvjs.js \"http://localhost:8000/?loc=$1&assembly=$4&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8004/?loc=$1&assembly=$4&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8005/?loc=$1&assembly=$4&tracks=$2\"" \
    "node profile_jb2web.js \"http://localhost:8006/?loc=$1&assembly=$4&tracks=$2\""
  echo -e "\n\n\n\n\n\n\n"
}

for i in 10000 20000 40000 80000 160000 320000 640000; do
  for j in bam cram; do
    echo $i $j
    profile "ctgA:19,000-20,000" "$i.shortread.$j"  "results/$i-1kb-shortread-$j.json" "volvox"
    profile "ctgA:19,000-29,000" "$i.shortread.$j"  "results/$i-10kb-shortread-$j.json" "volvox"
    profile "ctgA:15,000-35,000" "$i.shortread.$j"  "results/$i-20kb-shortread-$j.json" "volvox"
  done;
done;

for i in 40x 80x 160x 320x 640x; do
  for j in bam cram; do
    echo $i $j
    profile "ctgA:19,000-20,000" "$i.longread.$j"  "results/$i-1kb-longread-$j.json" "volvox"
    profile "ctgA:19,000-29,000" "$i.longread.$j"  "results/$i-10kb-longread-$j.json" "volvox"
    profile "ctgA:15,000-35,000" "$i.longread.$j"  "results/$i-20kb-longread-$j.json" "volvox"
  done;
done;

profile "ctgA:19,000-20,000" "10000.shortread.bam,10000.shortread.cram,40x.longread.bam,40x.longread.cram"  "results/multi-lowcov-1kb.json" "volvox"
profile "ctgA:19,000-29,000" "10000.shortread.bam,10000.shortread.cram,40x.longread.bam,40x.longread.cram"  "results/multi-lowcov-10kb.json" "volvox"
profile "ctgA:15,000-35,000" "10000.shortread.bam,10000.shortread.cram,40x.longread.bam,40x.longread.cram"  "results/multi-lowcov-20kb.json" "volvox"



profile "ctgA:19,000-20,000" "160000.shortread.bam,160000.shortread.cram,160x.longread.bam,160x.longread.cram"  "results/multi-highcov-1kb.json" "volvox"
profile "ctgA:19,000-29,000" "160000.shortread.bam,160000.shortread.cram,160x.longread.bam,160x.longread.cram"  "results/multi-highcov-1kb.json" "volvox"
profile "ctgA:15,000-35,000" "160000.shortread.bam,160000.shortread.cram,160x.longread.bam,160x.longread.cram"  "results/multi-highcov-1kb.json" "volvox"


./write_readme.sh
