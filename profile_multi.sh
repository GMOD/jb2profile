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


profile "chr22_mask:125,000-144,000" "multi1.sm.longread.cram,multi2.sm.longread.cram,multi3.sm.longread.cram,multi4.sm.longread.cram,multi5.sm.longread.cram"  "results/multi-lowcov-19kb-longread-cram" "hg19mod" 
profile "chr22_mask:125,000-144,000" "multi1.md.longread.cram,multi2.md.longread.cram,multi3.md.longread.cram,multi4.md.longread.cram,multi5.md.longread.cram"  "results/multi-highcov-19kb-longread-cram" "hg19mod" 



profile "chr22_mask:125,000-144,000" "multi1.sm.longread.bam,multi2.sm.longread.bam,multi3.sm.longread.bam,multi4.sm.longread.bam,multi5.sm.longread.bam"  "results/multi-lowcov-19kb-longread-bam" "hg19mod" 
profile "chr22_mask:125,000-144,000" "multi1.md.longread.bam,multi2.md.longread.bam,multi3.md.longread.bam,multi4.md.longread.bam,multi5.md.longread.bam"  "results/multi-highcov-19kb-longread-bam" "hg19mod" 
