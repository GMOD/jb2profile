#!/bin/bash

rm -rf results
mkdir results

## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT

## start servers on different ports
node express_cross_origin_isolated/index.js igvjs/build 8000 &
node express_cross_origin_isolated/index.js jb2_174 8001 &
node express_cross_origin_isolated/index.js jb2_noserialize 8002 &
node express_cross_origin_isolated/index.js jb2lgv/build 8003 &

sleep 1

profile () {
  echo $0 $1 $2 $3 $4
  hyperfine -i --export-json $3.json --runs 1  \
    "node profile_igvjs.js \"http://localhost:8000/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8000.json\" \"$3_mem_8000.json\"" \
    "node profile_jb2web.js \"http://localhost:8001/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8001.json\" \"$3_mem_8001.json\"" \
    "node profile_jb2web.js \"http://localhost:8002/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8002.json\" \"$3_mem_8002.json\"" \
    "node profile_jb2web.js \"http://localhost:8003/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8003.json\" \"$3_mem_8003.json\""
  echo -e "\n\n\n\n\n\n\n"
}


for k in longread shortread; do
  for i in 0.02 0.20 0.40 0.60 0.80 1; do
    a=$(echo  "1000*$i/1"|bc )x;
    for j in bam cram; do
      echo $i $j $a
      profile "chr22_mask:125,000-144,000" "$a.$k.$j"  "results/$a-19kb-$k-$j" "hg19mod"
    done;
  done;
done;

# profile "chr22_mask:19,000-20,000" "28x.shortread.bam,28x.shortread.cram,40x.longread.bam,40x.longread.cram"  "results/multi-lowcov-1kb" "hg19mod" 
# profile "chr22_mask:19,000-29,000" "28x.shortread.bam,28x.shortread.cram,40x.longread.bam,40x.longread.cram"  "results/multi-lowcov-10kb" "hg19mod"
# profile "chr22_mask:15,000-34,000" "28x.shortread.bam,28x.shortread.cram,40x.longread.bam,40x.longread.cram"  "results/multi-lowcov-20kb" "hg19mod"



# profile "chr22_mask:19,000-20,000" "448x.shortread.bam,448x.shortread.cram,160x.longread.bam,160x.longread.cram"  "results/multi-highcov-1kb" "hg19mod"
# profile "chr22_mask:19,000-29,000" "448x.shortread.bam,448x.shortread.cram,160x.longread.bam,160x.longread.cram"  "results/multi-highcov-10kb" "hg19mod"
# profile "chr22_mask:15,000-34,000" "448x.shortread.bam,448x.shortread.cram,160x.longread.bam,160x.longread.cram"  "results/multi-highcov-19kb" "hg19mod"



