# jb2profile

Some profiling on jbrowse 2

## Setup

Run ./init.sh

Will compile igv.js CRA app, @jbrowse/react-linear-genome-view based CRA app, and download jbrowse web instance

Will also download BAM/CRAM files for testing

Also you we use a custom igv.js build which has a special "DONE" console.log
that it emits on completion of drawing BAM, which profile_igvjs.js listens for

```
git clone https://github.com/cmdcolin/igv.js
cd igv.js
yarn
yarn build
yarn link
```

## Results

results/large_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000..21,000&assembly=volvox&tracks=volvox-wgsim.bam"` | 35.543 ± 0.855 | 34.379 | 37.258 | 1.87 ± 0.05 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000..21,000&assembly=volvox&tracks=volvox-wgsim.bam"` | 18.968 ± 0.211 | 18.784 | 19.475 | 1.00 |


results/large_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000..21,000&assembly=volvox&tracks=volvox-wgsim.cram"` | 29.808 ± 1.031 | 28.443 | 31.231 | 2.60 ± 0.11 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000..21,000&assembly=volvox&tracks=volvox-wgsim.cram"` | 17.060 ± 0.557 | 16.081 | 17.646 | 1.49 ± 0.06 |
| `node profile_igvjs.js "http://localhost:8000/?largeCram=true&loc=ctgA:19,000-21,000"` | 11.457 ± 0.259 | 10.987 | 11.704 | 1.00 |


results/small_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.bam"` | 4.528 ± 0.071 | 4.419 | 4.623 | 1.60 ± 0.06 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.bam"` | 3.914 ± 0.082 | 3.732 | 4.043 | 1.39 ± 0.06 |
| `node profile_igvjs.js "http://localhost:8000/?smallBam=true&loc=ctgA:19,000-29,000"` | 2.822 ± 0.105 | 2.685 | 2.949 | 1.00 |


results/small_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.cram"` | 4.483 ± 0.161 | 4.285 | 4.666 | 1.55 ± 0.08 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.cram"` | 4.196 ± 0.106 | 4.081 | 4.413 | 1.45 ± 0.07 |
| `node profile_igvjs.js "http://localhost:8000/?smallCram=true&loc=ctgA:19,000-29,000"` | 2.889 ± 0.114 | 2.734 | 3.111 | 1.00 |


