| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `node profile_igvjs.js "http://localhost:8000/?loc=ctgA:19,000-29,000&tracks=badread.50x.cram"` | 4.071 ± 0.056 | 4.008 | 4.115 | 1.00 |
| `node profile_jb2web.js "http://localhost:8001/?loc=ctgA:19,000-29,000&assembly=volvox&tracks=badread.50x.cram"` | 6.371 ± 0.046 | 6.318 | 6.406 | 1.56 ± 0.02 |
| `node profile_jb2web.js "http://localhost:8002/?loc=ctgA:19,000-29,000&assembly=volvox&tracks=badread.50x.cram"` | 5.520 ± 0.056 | 5.465 | 5.577 | 1.36 ± 0.02 |
| `node profile_jb2web.js "http://localhost:8003/?loc=ctgA:19,000-29,000&tracks=badread.50x.cram"` | 5.500 ± 0.028 | 5.468 | 5.520 | 1.35 ± 0.02 |
