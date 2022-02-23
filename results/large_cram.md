| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000..21,000&assembly=volvox&tracks=volvox-wgsim.cram"` | 29.808 ± 1.031 | 28.443 | 31.231 | 2.60 ± 0.11 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000..21,000&assembly=volvox&tracks=volvox-wgsim.cram"` | 17.060 ± 0.557 | 16.081 | 17.646 | 1.49 ± 0.06 |
| `node profile_igvjs.js "http://localhost:8000/?largeCram=true&loc=ctgA:19,000-21,000"` | 11.457 ± 0.259 | 10.987 | 11.704 | 1.00 |
