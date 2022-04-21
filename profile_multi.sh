#!/bin/bash

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


for f in bam cram; do
  for l in longread shortread; do
    for j in 02 05 10 15; do
      k=0.$j;
      cov=$(echo  "1000*$k/1"|bc );
      cmds=multi1."$cov"x.$l.$f;
      for i in {2..5}; do
        cmds+=",multi$i"."$cov"x.longread.$f;
        profile "chr22_mask:125,000-144,000" $cmds "results/multi-$cov-$i-19kb-$l-$f" "hg19mod" 
      done;
    done;
  done;
done;
