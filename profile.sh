#!/bin/bash

export NODE_OPTIONS=--max-old-space-size=8192


## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT

## start servers on different ports
npx http-server igvjs/build -p 8000 -s  &
npx http-server jb2_175 -p 8001 -s &
npx http-server jb2lgv/build -p 8002 -s &
npx http-server jbrowse -p 8003 -s &
npx http-server jb2mod -p 8004 -s &

sleep 1

profile () {
  echo $0 $1 $2 $3 $4
  ## remove these first because they are appended to by the multiple runs
  rm -f "$3_fps_8000.json"
  rm -f "$3_fps_8001.json"
  rm -f "$3_fps_8002.json"
  rm -f "$3_fps_8003.json"
  hyperfine -i --export-json $3.json --runs 10  \
    "node profile_igvjs.js \"http://localhost:8000/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8000.json\" \"$3_mem_8000.json\"" \
    "node profile_jb2web.js \"http://localhost:8001/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8001.json\" \"$3_mem_8001.json\"" \
    "node profile_jb2web.js \"http://localhost:8002/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8002.json\" \"$3_mem_8002.json\"" \
    "node profile_jb1web.js \"http://localhost:8003/?loc=$1&assembly=$4&tracks=$2 snp,$2 aln\" \"$3_fps_8003.json\" \"$3_mem_8003.json\"" \
    "node profile_jb2web.js \"http://localhost:8004/?loc=$1&assembly=$4&tracks=$2\" \"$3_fps_8004.json\" \"$3_mem_8004.json\""
  echo -e "\n\n\n\n\n\n\n"
}



for k in longread shortread; do
  for i in 0.02 0.20 0.40 0.60 0.80 1; do
    cov=$(echo  "1000*$i/1"|bc )x;
    for m in 1 10 19; do
      for j in bam cram; do
        echo $i $j $cov $m
        s=124000
        e=$(echo  "124000+$m*1000"|bc);
        profile "chr22_mask:$s-$e" "$cov.$k.$j"  "results/$cov-"$m"kb-$k-$j" "hg19mod"
      done;
    done;
  done;
done;

