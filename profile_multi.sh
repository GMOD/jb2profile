#!/bin/bash

## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT


## start servers on different ports
npx http-server igvjs/build -p 8000 -s  &
npx http-server jb2lgv/build -p 8002 -s &
npx http-server jbrowse -p 8003 -s &
npx http-server jb2mod -p 8001 -s &

sleep 1

profile () {
  echo $0 $1 $2 $3 $4
  args=$(node split.js $2)
  hyperfine -i --export-json $3.json --runs 10  \
    "node profile_igvjs.js \"http://localhost:8000/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8000.json\" \"$3_mem_8000.json\"" \
    "node profile_jb2web.js \"http://localhost:8002/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8002.json\" \"$3_mem_8002.json\"" \
    "node profile_jb1web.js \"http://localhost:8003/?loc=$1&assembly=$4&tracks=$args\" \"$3_fps_8003.json\" \"$3_mem_8003.json\"" \
    "node profile_jb2web.js \"http://localhost:8001/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8001.json\" \"$3_mem_8001.json\""
  echo -e "\n\n\n\n\n\n\n"
}


for m in 5 10; do
  for f in bam cram; do
    for l in longread shortread; do
      for j in 0.02 0.05 0.10 0.15; do
        cov=$(echo  "1000*$j/1"|bc );
        cmds=""
        for i in {1..5}; do
          echo $i $j $cov $m
          s=124000
          e=$(echo  "124000+$m*1000"|bc);
          cmds+="multi$i"."$cov"x.$l.$f;
          profile "chr22_mask:$s-$e" $cmds "results/multi-"$m"kb-$cov-$i-$l-$f" "hg19mod"
          cmds+=",";
        done;
      done;
    done;
  done;
done;
