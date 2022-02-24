| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_igvjs.js "http://localhost:8000/?loc=ctgA:19,000-21,000&tracks=badread.1000x.cram"` | 16.221 ± 0.313 | 15.983 | 16.575 | 1.00 |
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000-21,000&assembly=volvox&tracks=badread.1000x.cram"` | 19.928 ± 0.341 | 19.586 | 20.267 | 1.23 ± 0.03 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000-21,000&assembly=volvox&tracks=badread.1000x.cram"` | 16.291 ± 0.530 | 15.756 | 16.816 | 1.00 ± 0.04 |
| `node profile_jb2web.js "http://localhost:8003/?loc=ctgA:19,000-21,000&tracks=badread.1000x.cram"` | 17.566 ± 0.333 | 17.184 | 17.795 | 1.08 ± 0.03 |
