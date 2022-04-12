#!/bin/bash

rm -rf results
mkdir results

## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT

## start servers on different ports
npx http-server igvjs/build -s -p 8000 &
npx http-server jb2_165 -s -p 8001 &
npx http-server jb2_167 -s -p 8002 &
npx http-server jb2_169 -s -p 8003 &
npx http-server jb2_main -s -p 8004 &
npx http-server jb2_noserialize -s -p 8005 &
npx http-server jb2lgv/build -s -p 8006 &

sleep 1

profile () {
  echo $0 $1 $2 $3 $4
  hyperfine -i --export-json $3.json --runs 1  \
    "node profile_igvjs.js \"http://localhost:8000/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8000.json\" \"$3_mem_8000.json\"" \
    "node profile_jb2web.js \"http://localhost:8001/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8001.json\" \"$3_mem_8001.json\"" \
    "node profile_jb2web.js \"http://localhost:8002/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8002.json\" \"$3_mem_8002.json\"" \
    "node profile_jb2web.js \"http://localhost:8003/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8003.json\" \"$3_mem_8003.json\"" \
    "node profile_jb2web.js \"http://localhost:8004/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8004.json\" \"$3_mem_8004.json\"" \
    "node profile_jb2web.js \"http://localhost:8005/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8005.json\" \"$3_mem_8005.json\"" \
    "node profile_jb2web.js \"http://localhost:8006/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8006.json\" \"$3_mem_8006.json\""
  echo -e "\n\n\n\n\n\n\n"
}

for i in 28x 56x 112x 224x 448x 896x 1792x; do
  for j in bam cram; do
    echo $i $j
    profile "ctgA:19,000-20,000" "$i.shortread.$j"  "results/$i-1kb-shortread-$j" "volvox" 
    profile "ctgA:19,000-29,000" "$i.shortread.$j"  "results/$i-10kb-shortread-$j" "volvox"
    profile "ctgA:15,000-34,000" "$i.shortread.$j"  "results/$i-19kb-shortread-$j" "volvox"

  done;
done;

for i in 40x 80x 160x 320x 640x; do
  for j in bam cram; do
    echo $i $j
    profile "ctgA:19,000-20,000" "$i.longread.$j"  "results/$i-1kb-longread-$j" "volvox"
    profile "ctgA:19,000-29,000" "$i.longread.$j"  "results/$i-10kb-longread-$j" "volvox"
    profile "ctgA:15,000-34,000" "$i.longread.$j"  "results/$i-19kb-longread-$j" "volvox"
  done;
done;

profile "ctgA:19,000-20,000" "28x.shortread.bam,28x.shortread.cram,40x.longread.bam,40x.longread.cram"  "results/multi-lowcov-1kb" "volvox" 
profile "ctgA:19,000-29,000" "28x.shortread.bam,28x.shortread.cram,40x.longread.bam,40x.longread.cram"  "results/multi-lowcov-10kb" "volvox"
profile "ctgA:15,000-34,000" "28x.shortread.bam,28x.shortread.cram,40x.longread.bam,40x.longread.cram"  "results/multi-lowcov-20kb" "volvox"



profile "ctgA:19,000-20,000" "448x.shortread.bam,448x.shortread.cram,160x.longread.bam,160x.longread.cram"  "results/multi-highcov-1kb" "volvox"
profile "ctgA:19,000-29,000" "448x.shortread.bam,448x.shortread.cram,160x.longread.bam,160x.longread.cram"  "results/multi-highcov-10kb" "volvox"
profile "ctgA:15,000-34,000" "448x.shortread.bam,448x.shortread.cram,160x.longread.bam,160x.longread.cram"  "results/multi-highcov-19kb" "volvox"



