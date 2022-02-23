| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.cram"` | 4.524 ± 0.150 | 4.358 | 4.708 | 1.43 ± 0.26 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.cram"` | 4.288 ± 0.244 | 4.099 | 4.965 | 1.36 ± 0.26 |
| `node profile_igvjs.js "http://localhost:8000/?trackId=volvox-sorted.cram&loc=ctgA:19,000-29,000"` | 3.157 ± 0.569 | 2.817 | 4.382 | 1.00 |
| `node profile_jb2web.js "http://localhost:8003/?trackId=volvox-sorted.cram&loc=ctgA:19,000-29,000"` | 3.977 ± 0.110 | 3.826 | 4.129 | 1.26 ± 0.23 |
