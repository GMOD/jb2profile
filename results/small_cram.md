| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.cram"` | 4.483 ± 0.161 | 4.285 | 4.666 | 1.55 ± 0.08 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.cram"` | 4.196 ± 0.106 | 4.081 | 4.413 | 1.45 ± 0.07 |
| `node profile_igvjs.js "http://localhost:8000/?smallCram=true&loc=ctgA:19,000-29,000"` | 2.889 ± 0.114 | 2.734 | 3.111 | 1.00 |
