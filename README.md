# jb2profile

Some profiling on jbrowse 2

## Results

### How to read results

- igvjs is a create-react-app with igv package from npm installed
- jbrowse-web-1.6.5 is the full jbrowse-web package (uses webworkers)
- jbrowse-web-1.6.5+optim is the full jbrowse-web package with some unmerged
  optimizations which disables serializing features across the RPC boundary,
  which will require work to accomplish a merge (uses webworkers)
- jbrowse-lgv is a create-react-app with the @jbrowse/react-linear-genome-view
  package installed (no webworkers)

### Summary

- igv.js is often somewhat faster than both JBrowse Web and
  @jbrowse/react-linaer-genome-view
- high coverage short read BAM and CRAM files stand out as being poor
  performers (~5.4 and ~3x slower respectively)
- potential optimizations to help the high coverage short reads on the optim
  branch lower this gap to ~2.8x slower and ~1.6x slower respectively
- this is all chrome based, firefox will likely be slower on jbrowse-web
- these benchmarks are not comprehensive, and just a taste of some small
  examples on simulated data on volvox

### Platform

Ran tests on a xlarge 4vcpu 16gb memory amazon ec2 on ubuntu 20.04

### Detailed results



results/large_longread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 24.344 ± 0.013 | 24.333 | 24.359 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 32.278 ± 0.940 | 31.431 | 33.290 | 1.33 ± 0.04 |
| `jbrowse-web-1.6.7` | 32.144 ± 0.601 | 31.710 | 32.829 | 1.32 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 31.496 ± 0.583 | 30.991 | 32.135 | 1.29 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 25.184 ± 0.133 | 25.099 | 25.338 | 1.03 ± 0.01 |
| `jbrowse-react-lgv` | 26.843 ± 0.122 | 26.720 | 26.963 | 1.10 ± 0.01 |


results/large_multi.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 39.859 ± 0.332 | 39.476 | 40.058 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 84.316 ± 0.500 | 83.743 | 84.663 | 2.12 ± 0.02 |
| `jbrowse-web-1.6.7` | 85.333 ± 0.416 | 85.042 | 85.809 | 2.14 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 84.294 ± 0.437 | 83.839 | 84.709 | 2.11 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 49.434 ± 0.691 | 48.637 | 49.848 | 1.24 ± 0.02 |
| `jbrowse-react-lgv` | 63.614 ± 0.461 | 63.109 | 64.011 | 1.60 ± 0.02 |


results/large_shortread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 11.995 ± 0.147 | 11.833 | 12.121 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 76.613 ± 0.489 | 76.297 | 77.177 | 6.39 ± 0.09 |
| `jbrowse-web-1.6.7` | 74.251 ± 1.108 | 73.088 | 75.294 | 6.19 ± 0.12 |


results/large_shortread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 16.222 ± 0.183 | 16.020 | 16.375 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 56.535 ± 0.774 | 55.729 | 57.273 | 3.49 ± 0.06 |
| `jbrowse-web-1.6.7` | 56.307 ± 0.628 | 55.676 | 56.931 | 3.47 ± 0.06 |
| `jbrowse-web-1.6.7_small_opt` | 56.801 ± 0.472 | 56.317 | 57.261 | 3.50 ± 0.05 |
| `jbrowse-web-1.6.7_aggro_opt` | 27.802 ± 0.103 | 27.721 | 27.918 | 1.71 ± 0.02 |
| `jbrowse-react-lgv` | 38.812 ± 0.193 | 38.669 | 39.031 | 2.39 ± 0.03 |


results/small_longread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 4.292 ± 0.010 | 4.280 | 4.299 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 7.956 ± 0.047 | 7.911 | 8.004 | 1.85 ± 0.01 |
| `jbrowse-web-1.6.7` | 7.914 ± 0.051 | 7.854 | 7.944 | 1.84 ± 0.01 |
| `jbrowse-web-1.6.7_small_opt` | 7.886 ± 0.091 | 7.781 | 7.947 | 1.84 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 6.330 ± 0.066 | 6.276 | 6.403 | 1.47 ± 0.02 |
| `jbrowse-react-lgv` | 6.311 ± 0.017 | 6.291 | 6.323 | 1.47 ± 0.01 |


results/small_multi.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 9.268 ± 0.070 | 9.200 | 9.339 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 18.262 ± 0.030 | 18.236 | 18.295 | 1.97 ± 0.02 |
| `jbrowse-web-1.6.7` | 19.341 ± 0.097 | 19.283 | 19.453 | 2.09 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 17.981 ± 0.091 | 17.877 | 18.042 | 1.94 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 11.914 ± 0.092 | 11.818 | 12.003 | 1.29 ± 0.01 |
| `jbrowse-react-lgv` | 13.766 ± 0.096 | 13.695 | 13.875 | 1.49 ± 0.02 |


results/small_shortread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.747 ± 1.309 | 1.990 | 4.258 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 6.476 ± 0.158 | 6.379 | 6.658 | 2.36 ± 1.12 |
| `jbrowse-web-1.6.7` | 6.338 ± 0.079 | 6.247 | 6.387 | 2.31 ± 1.10 |
| `jbrowse-web-1.6.7_small_opt` | 6.271 ± 0.034 | 6.239 | 6.307 | 2.28 ± 1.09 |
| `jbrowse-web-1.6.7_aggro_opt` | 4.489 ± 0.013 | 4.473 | 4.498 | 1.63 ± 0.78 |
| `jbrowse-react-lgv` | 4.308 ± 0.094 | 4.227 | 4.411 | 1.57 ± 0.75 |


results/small_shortread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.222 ± 0.021 | 2.199 | 2.239 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 5.945 ± 0.038 | 5.916 | 5.987 | 2.68 ± 0.03 |
| `jbrowse-web-1.6.7` | 5.961 ± 0.018 | 5.940 | 5.974 | 2.68 ± 0.03 |
| `jbrowse-web-1.6.7_small_opt` | 5.924 ± 0.024 | 5.903 | 5.951 | 2.67 ± 0.03 |
| `jbrowse-web-1.6.7_aggro_opt` | 4.547 ± 0.004 | 4.544 | 4.551 | 2.05 ± 0.02 |
| `jbrowse-react-lgv` | 4.367 ± 0.022 | 4.347 | 4.392 | 1.97 ± 0.02 |


