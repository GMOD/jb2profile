| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_igvjs.js "http://localhost:8000/?loc=ctgA:19,000-21,000&tracks=badread.1000x.bam,volvox-wgsim.bam"` | 29.636 ± 0.897 | 29.150 | 30.980 | 1.00 |
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000-21,000&assembly=volvox&tracks=badread.1000x.bam,volvox-wgsim.bam"` | 115.827 ± 1.578 | 113.735 | 117.443 | 3.91 ± 0.13 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000-21,000&assembly=volvox&tracks=badread.1000x.bam,volvox-wgsim.bam"` | 110.995 ± 0.762 | 110.042 | 111.635 | 3.75 ± 0.12 |
