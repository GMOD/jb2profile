| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_igvjs.js "http://localhost:8000/?loc=ctgA:19,000-21,000&tracks=badread.1000x.cram,volvox-wgsim.cram"` | 25.879 ± 1.105 | 24.718 | 26.919 | 1.42 ± 0.06 |
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000-21,000&assembly=volvox&tracks=badread.1000x.cram,volvox-wgsim.cram"` | 35.067 ± 0.199 | 34.935 | 35.296 | 1.93 ± 0.02 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000-21,000&assembly=volvox&tracks=badread.1000x.cram,volvox-wgsim.cram"` | 18.171 ± 0.191 | 18.047 | 18.391 | 1.00 |
| `node profile_jb2web.js "http://localhost:8003/?loc=ctgA:19,000-21,000&tracks=badread.1000x.cram,volvox-wgsim.cram"` | 37.318 ± 0.260 | 37.107 | 37.608 | 2.05 ± 0.03 |
