| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.bam"` | 4.897 ± 0.390 | 4.480 | 5.493 | 136012.71 ± 102796.94 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.bam"` | 4.073 ± 0.089 | 3.987 | 4.271 | 113115.31 ± 85050.86 |
| `node profile_igvjs.js "http://localhost:8000/?trackId=volvox-sorted.bam&loc=ctgA:19,000-29,000"` | 2.990 ± 0.058 | 2.928 | 3.080 | 83031.10 ± 62424.97 |
| ` ` | 0.000 ± 0.000 | 0.000 | 0.001 | 1.00 |
