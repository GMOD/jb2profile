#!/bin/bash

## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT

## start servers on different ports
npx http-server igvjs/build -s -p 8000 &
npx http-server jb2web -s -p 8001 &
npx http-server jb2web_optim -s -p 8002 &
npx http-server jb2lgv/build -s -p 8003 &
# cd jb2lgv/
# npx http-server -p 8002  &
# cd -

ROOT="http://localhost:8001/?loc=ctgA:19,000..29,000&assembly=volvox"
ROOT2="http://localhost:8001/?loc=ctgA:19,000..21,000&assembly=volvox"

hyperfine --export-markdown results/small_cram.md --warmup 1 \
  "node profile_jb2web.js \"http://localhost:8001/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.cram\"" \
  "node profile_jb2web.js \"http://localhost:8002/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.cram\"" \
  "node profile_igvjs.js \"http://localhost:8000/?trackId=volvox-sorted.cram&loc=ctgA:19,000-29,000\"" \
  "node profile_jb2web.js \"http://localhost:8003/?trackId=volvox-sorted.cram&loc=ctgA:19,000-29,000\"" 
echo -e "\n\n\n\n\n"

hyperfine --export-markdown results/small_bam.md --warmup 1 \
  "node profile_jb2web.js \"http://localhost:8001/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.bam\"" \
  "node profile_jb2web.js \"http://localhost:8002/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.bam\"" \
  "node profile_igvjs.js \"http://localhost:8000/?trackId=volvox-sorted.bam&loc=ctgA:19,000-29,000\"" \ 
  "node profile_jb2web.js \"http://localhost:8003/?trackId=volvox-sorted.bam&loc=ctgA:19,000-29,000\""
echo -e "\n\n\n\n\n"

# hyperfine --export-markdown results/large_cram.md --warmup 1 \
#   "node profile_jb2web.js \"http://localhost:8001/?loc=ctgA:19,000..21,000&assembly=volvox&tracks=volvox-wgsim.cram\"" \
#   "node profile_jb2web.js \"http://localhost:8002/?loc=ctgA:19,000..21,000&assembly=volvox&tracks=volvox-wgsim.cram\"" \
#   "node profile_igvjs.js \"http://localhost:8000/?trackId=volvox-wgsim.cram&loc=ctgA:19,000-21,000\"" \ 
#   "node profile_jb2web.js \"http://localhost:8003/?trackId=volvox-wgsim.cram&loc=ctgA:19,000-21,000\""
# echo -e "\n\n\n\n\n"

# hyperfine --export-markdown results/large_bam.md --warmup 1 \
#   "node profile_jb2web.js \"http://localhost:8001/?loc=ctgA:19,000..21,000&assembly=volvox&tracks=volvox-wgsim.bam\"" \
#   "node profile_jb2web.js \"http://localhost:8002/?loc=ctgA:19,000..21,000&assembly=volvox&tracks=volvox-wgsim.bam\"" \
#   "node profile_igvjs.js \"http://localhost:8000/?trackId=volvox-wgsim.bam&loc=ctgA:19,000-21,000\"" \ 
#   "node profile_jb2web.js \"http://localhost:8003/?trackId=volvox-wgsim.bam&loc=ctgA:19,000-21,000\""

# echo -e "\n\n\n\n\n"


# for i in results/*.md; do echo $i; echo -e "\n"; cat $i; echo -e "\n"; done >> README.md
