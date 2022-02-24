| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_igvjs.js "http://localhost:8000/?loc=ctgA:19,000-29,000&tracks=volvox-sorted.bam"` | 2.741 ± 0.134 | 2.645 | 2.894 | 1.00 |
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000-29,000&assembly=volvox&tracks=volvox-sorted.bam"` | 5.410 ± 0.019 | 5.388 | 5.421 | 1.97 ± 0.10 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000-29,000&assembly=volvox&tracks=volvox-sorted.bam"` | 4.270 ± 0.156 | 4.153 | 4.448 | 1.56 ± 0.10 |
| `node profile_jb2web.js "http://localhost:8003/?loc=ctgA:19,000-29,000&tracks=volvox-sorted.bam"` | 4.199 ± 0.042 | 4.159 | 4.242 | 1.53 ± 0.08 |
