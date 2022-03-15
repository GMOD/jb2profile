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
| `igvjs` | 29.927 ± 1.279 | 28.450 | 30.681 | 1.10 ± 0.05 |
| `jbrowse-web-1.6.5` | 34.127 ± 2.210 | 31.592 | 35.653 | 1.25 ± 0.08 |
| `jbrowse-web-1.6.5+cigar_optim` | 31.964 ± 1.008 | 31.309 | 33.125 | 1.17 ± 0.04 |
| `jbrowse-web-1.6.5+no_serialize_optim` | 28.353 ± 2.346 | 26.318 | 30.920 | 1.04 ± 0.09 |
| `jbrowse-react-lgv` | 27.292 ± 0.483 | 26.909 | 27.835 | 1.00 🍏|


results/large_multi.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 45.982 ± 5.432 | 41.754 | 52.109 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 94.424 ± 8.647 | 85.758 | 103.053 | 2.05 ± 0.31 |
| `jbrowse-web-1.6.5+cigar_optim` | 92.862 ± 4.664 | 87.573 | 96.385 | 2.02 ± 0.26 |
| `jbrowse-web-1.6.5+no_serialize_optim` | 53.691 ± 2.872 | 51.533 | 56.952 | 1.17 ± 0.15 |
| `jbrowse-react-lgv` | 71.098 ± 4.074 | 66.653 | 74.653 | 1.55 ± 0.20 |


results/large_shortread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 18.395 ± 3.212 | 15.381 | 21.774 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 100.342 ± 15.209 | 85.267 | 115.682 | 5.46 ± 1.26 |


results/large_shortread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 18.370 ± 0.905 | 17.344 | 19.055 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 63.447 ± 0.377 | 63.022 | 63.743 | 3.45 ± 0.17 |
| `jbrowse-web-1.6.5+cigar_optim` | 66.475 ± 6.884 | 60.319 | 73.907 | 3.62 ± 0.41 |
| `jbrowse-web-1.6.5+no_serialize_optim` | 34.195 ± 5.266 | 28.292 | 38.411 | 1.86 ± 0.30 |
| `jbrowse-react-lgv` | 53.294 ± 7.593 | 47.689 | 61.935 | 2.90 ± 0.44 |


results/small_longread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 5.209 ± 0.326 | 4.895 | 5.546 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 8.702 ± 0.846 | 7.962 | 9.623 | 1.67 ± 0.19 |
| `jbrowse-web-1.6.5+cigar_optim` | 7.907 ± 0.074 | 7.821 | 7.951 | 1.52 ± 0.10 |
| `jbrowse-web-1.6.5+no_serialize_optim` | 7.668 ± 0.440 | 7.334 | 8.167 | 1.47 ± 0.13 |
| `jbrowse-react-lgv` | 6.703 ± 0.703 | 6.288 | 7.515 | 1.29 ± 0.16 |


results/small_multi.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 13.670 ± 6.049 | 9.507 | 20.609 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 23.964 ± 6.760 | 19.947 | 31.768 | 1.75 ± 0.92 |
| `jbrowse-web-1.6.5+cigar_optim` | 20.106 ± 0.823 | 19.196 | 20.797 | 1.47 ± 0.65 |
| `jbrowse-web-1.6.5+no_serialize_optim` | 14.071 ± 1.147 | 12.993 | 15.277 | 1.03 ± 0.46 |
| `jbrowse-react-lgv` | 13.989 ± 0.166 | 13.799 | 14.111 | 1.02 ± 0.45 |


results/small_shortread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.045 ± 0.095 | 1.988 | 2.155 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 6.598 ± 0.110 | 6.507 | 6.720 | 3.23 ± 0.16 |
| `jbrowse-web-1.6.5+cigar_optim` | 6.339 ± 0.050 | 6.305 | 6.396 | 3.10 ± 0.15 |
| `jbrowse-web-1.6.5+no_serialize_optim` | 5.664 ± 1.244 | 4.501 | 6.976 | 2.77 ± 0.62 |
| `jbrowse-react-lgv` | 5.459 ± 1.131 | 4.361 | 6.620 | 2.67 ± 0.57 |


results/small_shortread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.259 ± 0.056 | 2.220 | 2.323 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 8.075 ± 1.996 | 5.859 | 9.733 | 3.57 ± 0.89 |
| `jbrowse-web-1.6.5+cigar_optim` | 6.923 ± 0.890 | 5.931 | 7.650 | 3.06 ± 0.40 |
| `jbrowse-web-1.6.5+no_serialize_optim` | 4.861 ± 0.498 | 4.567 | 5.436 | 2.15 ± 0.23 |
| `jbrowse-react-lgv` | 6.084 ± 1.554 | 4.361 | 7.377 | 2.69 ± 0.69 |


