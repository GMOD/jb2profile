| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_igvjs.js "http://localhost:8000/?loc=ctgA:19,000-29,000&tracks=badread.50x.cram,badread.50x.bam,volvox-sorted.bam,volvox-sorted.cram"` | 7.100 ± 0.293 | 6.898 | 7.435 | 1.25 ± 0.05 |
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000-29,000&assembly=volvox&tracks=badread.50x.cram,badread.50x.bam,volvox-sorted.bam,volvox-sorted.cram"` | 7.217 ± 0.073 | 7.146 | 7.292 | 1.27 ± 0.02 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000-29,000&assembly=volvox&tracks=badread.50x.cram,badread.50x.bam,volvox-sorted.bam,volvox-sorted.cram"` | 5.667 ± 0.069 | 5.620 | 5.746 | 1.00 |
| `node profile_jb2web.js "http://localhost:8003/?loc=ctgA:19,000-29,000&tracks=badread.50x.cram,badread.50x.bam,volvox-sorted.bam,volvox-sorted.cram"` | 9.906 ± 0.167 | 9.766 | 10.091 | 1.75 ± 0.04 |
