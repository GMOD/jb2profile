#!/bin/bash


## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT

## start servers on different ports
node express_cross_origin_isolated/index.js igvjs/build 8000 &
node express_cross_origin_isolated/index.js jb2_175 8001 &
node express_cross_origin_isolated/index.js jb2lgv/build 8002 &
node express_cross_origin_isolated/index.js jbrowse 8003 &

sleep 1

profile () {
  echo $0 $1 $2 $3 $4
  hyperfine -i --export-json $3.json --runs 6  \
    "node profile_igvjs.js \"http://localhost:8000/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8000.json\" \"$3_mem_8000.json\"" \
    "node profile_jb2web.js \"http://localhost:8001/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8001.json\" \"$3_mem_8001.json\"" \
    "node profile_jb2web.js \"http://localhost:8002/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8002.json\" \"$3_mem_8002.json\"" \
    "node profile_jb1web.js \"http://localhost:8003/?loc=$1&assembly=$4&tracks=$2 aln,$2 snp\" \"$3_fps_8003.json\" \"$3_mem_8003.json\""
  echo -e "\n\n\n\n\n\n\n"
}


for k in longread shortread; do
  for i in 0.02 0.20 0.40 0.60 0.80 1; do
    a=$(echo  "1000*$i/1"|bc )x;
    for j in bam cram; do
      echo $i $j $a
      profile "chr22_mask:124,000-129,000" "$a.$k.$j"  "results/$a-$k-$j" "hg19mod"
    done;
  done;
done;

