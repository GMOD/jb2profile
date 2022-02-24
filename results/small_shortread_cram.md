| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_igvjs.js "http://localhost:8000/?loc=ctgA:19,000-29,000&tracks=volvox-sorted.cram"` | 3.019 ± 0.090 | 2.940 | 3.118 | 1.00 |
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000-29,000&assembly=volvox&tracks=volvox-sorted.cram"` | 5.056 ± 0.204 | 4.889 | 5.283 | 1.67 ± 0.08 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000-29,000&assembly=volvox&tracks=volvox-sorted.cram"` | 4.213 ± 0.035 | 4.174 | 4.241 | 1.40 ± 0.04 |
| `node profile_jb2web.js "http://localhost:8003/?loc=ctgA:19,000-29,000&tracks=volvox-sorted.cram"` | 4.263 ± 0.087 | 4.168 | 4.338 | 1.41 ± 0.05 |
