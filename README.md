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
| `igvjs` | 24.521 ± 0.279 | 24.278 | 24.923 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 31.842 ± 0.304 | 31.548 | 32.265 | 1.30 ± 0.02 |
| `jbrowse-web-1.6.7` | 31.778 ± 0.110 | 31.663 | 31.925 | 1.30 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 31.572 ± 0.176 | 31.420 | 31.825 | 1.29 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 24.885 ± 0.165 | 24.667 | 25.058 | 1.01 ± 0.01 |
| `jbrowse-react-lgv` | 26.790 ± 0.117 | 26.718 | 26.964 | 1.09 ± 0.01 |


results/large_multi.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 39.859 ± 0.332 | 39.476 | 40.058 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 84.316 ± 0.500 | 83.743 | 84.663 | 2.12 ± 0.02 |
| `jbrowse-web-1.6.7` | 85.333 ± 0.416 | 85.042 | 85.809 | 2.14 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 84.294 ± 0.437 | 83.839 | 84.709 | 2.11 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 49.434 ± 0.691 | 48.637 | 49.848 | 1.24 ± 0.02 |
| `jbrowse-react-lgv` | 63.614 ± 0.461 | 63.109 | 64.011 | 1.60 ± 0.02 |


results/large_multi_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 29.636 ± 0.897 | 29.150 | 30.980 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 115.827 ± 1.578 | 113.735 | 117.443 | 3.91 ± 0.13 |
| `jbrowse-web-1.6.7` | 110.995 ± 0.762 | 110.042 | 111.635 | 3.75 ± 0.12 |


results/large_shortread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 11.929 ± 0.056 | 11.874 | 11.999 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 76.443 ± 0.493 | 75.927 | 77.060 | 6.41 ± 0.05 |
| `jbrowse-web-1.6.7` | 73.737 ± 0.366 | 73.475 | 74.278 | 6.18 ± 0.04 |


results/large_shortread_bam_small_region.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 4.445 ± 0.069 | 4.408 | 4.549 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 29.427 ± 0.193 | 29.271 | 29.708 | 6.62 ± 0.11 |
| `jbrowse-web-1.6.7` | 28.824 ± 0.096 | 28.694 | 28.909 | 6.48 ± 0.10 |


results/large_shortread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 16.057 ± 0.157 | 15.910 | 16.275 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 55.988 ± 0.151 | 55.867 | 56.209 | 3.49 ± 0.04 |
| `jbrowse-web-1.6.7` | 56.340 ± 0.376 | 55.831 | 56.649 | 3.51 ± 0.04 |
| `jbrowse-web-1.6.7_small_opt` | 56.550 ± 0.514 | 55.859 | 57.053 | 3.52 ± 0.05 |
| `jbrowse-web-1.6.7_aggro_opt` | 27.860 ± 0.354 | 27.446 | 28.233 | 1.74 ± 0.03 |
| `jbrowse-react-lgv` | 38.463 ± 0.463 | 38.006 | 39.093 | 2.40 ± 0.04 |


results/small_longread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 4.313 ± 0.070 | 4.244 | 4.409 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 7.874 ± 0.041 | 7.822 | 7.908 | 1.83 ± 0.03 |
| `jbrowse-web-1.6.7` | 7.907 ± 0.026 | 7.868 | 7.924 | 1.83 ± 0.03 |
| `jbrowse-web-1.6.7_small_opt` | 7.883 ± 0.042 | 7.848 | 7.935 | 1.83 ± 0.03 |
| `jbrowse-web-1.6.7_aggro_opt` | 6.374 ± 0.059 | 6.311 | 6.439 | 1.48 ± 0.03 |
| `jbrowse-react-lgv` | 6.328 ± 0.020 | 6.311 | 6.347 | 1.47 ± 0.02 |


results/small_multi.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 9.268 ± 0.070 | 9.200 | 9.339 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 18.262 ± 0.030 | 18.236 | 18.295 | 1.97 ± 0.02 |
| `jbrowse-web-1.6.7` | 19.341 ± 0.097 | 19.283 | 19.453 | 2.09 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 17.981 ± 0.091 | 17.877 | 18.042 | 1.94 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 11.914 ± 0.092 | 11.818 | 12.003 | 1.29 ± 0.01 |
| `jbrowse-react-lgv` | 13.766 ± 0.096 | 13.695 | 13.875 | 1.49 ± 0.02 |


results/small_multi_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 4.765 ± 0.027 | 4.739 | 4.803 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 11.647 ± 0.051 | 11.595 | 11.717 | 2.44 ± 0.02 |
| `jbrowse-web-1.6.7` | 11.433 ± 0.111 | 11.332 | 11.550 | 2.40 ± 0.03 |
| `jbrowse-web-1.6.7_small_opt` | 11.097 ± 0.068 | 11.052 | 11.197 | 2.33 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 7.744 ± 0.024 | 7.717 | 7.766 | 1.63 ± 0.01 |
| `jbrowse-react-lgv` | 8.342 ± 0.040 | 8.311 | 8.401 | 1.75 ± 0.01 |


results/small_multi_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 5.504 ± 0.052 | 5.443 | 5.571 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 10.199 ± 0.081 | 10.085 | 10.267 | 1.85 ± 0.02 |
| `jbrowse-web-1.6.7` | 10.401 ± 0.062 | 10.324 | 10.458 | 1.89 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 10.160 ± 0.050 | 10.121 | 10.233 | 1.85 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 7.359 ± 0.119 | 7.214 | 7.501 | 1.34 ± 0.03 |
| `jbrowse-react-lgv` | 7.814 ± 0.024 | 7.784 | 7.835 | 1.42 ± 0.01 |


results/small_shortread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.089 ± 0.154 | 2.003 | 2.319 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 6.468 ± 0.012 | 6.452 | 6.479 | 3.10 ± 0.23 |
| `jbrowse-web-1.6.7` | 6.290 ± 0.039 | 6.261 | 6.346 | 3.01 ± 0.22 |
| `jbrowse-web-1.6.7_small_opt` | 6.217 ± 0.023 | 6.197 | 6.248 | 2.98 ± 0.22 |
| `jbrowse-web-1.6.7_aggro_opt` | 4.451 ± 0.032 | 4.419 | 4.494 | 2.13 ± 0.16 |
| `jbrowse-react-lgv` | 4.306 ± 0.046 | 4.268 | 4.370 | 2.06 ± 0.15 |


results/small_shortread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.253 ± 0.038 | 2.215 | 2.306 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 5.900 ± 0.043 | 5.856 | 5.957 | 2.62 ± 0.05 |
| `jbrowse-web-1.6.7` | 5.981 ± 0.021 | 5.952 | 6.003 | 2.66 ± 0.05 |
| `jbrowse-web-1.6.7_small_opt` | 5.921 ± 0.031 | 5.887 | 5.957 | 2.63 ± 0.05 |
| `jbrowse-web-1.6.7_aggro_opt` | 4.552 ± 0.014 | 4.535 | 4.567 | 2.02 ± 0.03 |
| `jbrowse-react-lgv` | 4.372 ± 0.015 | 4.355 | 4.391 | 1.94 ± 0.03 |


