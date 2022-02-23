| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.bam"` | 4.528 ± 0.071 | 4.419 | 4.623 | 1.60 ± 0.06 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000..29,000&assembly=volvox&tracks=volvox-sorted.bam"` | 3.914 ± 0.082 | 3.732 | 4.043 | 1.39 ± 0.06 |
| `node profile_igvjs.js "http://localhost:8000/?smallBam=true&loc=ctgA:19,000-29,000"` | 2.822 ± 0.105 | 2.685 | 2.949 | 1.00 |
