# jb2profile

Some profiling on jbrowse 2

## Results

### How to read results

- igvjs is a create-react-app with igv package from npm installed
- jbrowse-web-1.6.5 - stock
- jbrowse-web-1.6.7 - stock
- jbrowse-web-1.6.7_small_opt - modest optimizations from https://github.com/GMOD/jbrowse-components/pull/2809
- jbrowse-web-1.6.7_aggro_opt - removes serialization across webworker
- main_with_bam_update - adds this PR https://github.com/GMOD/bam-js/pull/89
- main_with_more_workers - the code on main uses a weird formula to determine number of workers, (num_cores-2)/3...this branch hardcodes us to 3 threads

## Notes

- thse tests are all chrome based (using puppeteer library for automation), running same on firefox or safari may be slower (especially on jbrowse-web)
- these benchmarks are not comprehensive, and just a taste of some small examples on simulated data on volvox

### Platform

Ran tests on a xlarge 4vcpu 16gb memory amazon ec2 on ubuntu 20.04


### Detailed results


results/large_longread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 18.311 ± 0.063 | 18.267 | 18.355 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 41.170 ± 0.017 | 41.158 | 41.182 | 2.25 ± 0.01 |
| `jbrowse-web-1.6.7` | 39.630 ± 0.135 | 39.534 | 39.726 | 2.16 ± 0.01 |
| `jbrowse-web-1.6.7_small_opt` | 37.412 ± 0.099 | 37.342 | 37.482 | 2.04 ± 0.01 |
| `jbrowse-web-1.6.7_aggro_opt` | 20.269 ± 0.017 | 20.257 | 20.282 | 1.11 ± 0.00 |
| `jbrowse-react-lgv` | 33.830 ± 0.311 | 33.610 | 34.050 | 1.85 ± 0.02 |
| `main_with_bam_update` | 35.489 ± 0.319 | 35.263 | 35.714 | 1.94 ± 0.02 |
| `main_with_more_workers` | 34.983 ± 0.049 | 34.949 | 35.017 | 1.91 ± 0.01 |


results/large_longread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 24.697 ± 0.242 | 24.526 | 24.868 | 1.02 ± 0.02 |
| `jbrowse-web-1.6.5` | 32.111 ± 0.538 | 31.731 | 32.492 | 1.32 ± 0.03 |
| `jbrowse-web-1.6.7` | 31.551 ± 0.166 | 31.434 | 31.668 | 1.30 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 31.048 ± 0.249 | 30.872 | 31.225 | 1.28 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 24.281 ± 0.391 | 24.005 | 24.558 | 1.00 🍏|
| `jbrowse-react-lgv` | 26.982 ± 0.175 | 26.859 | 27.106 | 1.11 ± 0.02 |
| `main_with_bam_update` | 31.459 ± 0.129 | 31.368 | 31.550 | 1.30 ± 0.02 |
| `main_with_more_workers` | 32.067 ± 0.636 | 31.617 | 32.517 | 1.32 ± 0.03 |


results/large_multi.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 39.859 ± 0.332 | 39.476 | 40.058 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 84.316 ± 0.500 | 83.743 | 84.663 | 2.12 ± 0.02 |
| `jbrowse-web-1.6.7` | 85.333 ± 0.416 | 85.042 | 85.809 | 2.14 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 84.294 ± 0.437 | 83.839 | 84.709 | 2.11 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 49.434 ± 0.691 | 48.637 | 49.848 | 1.24 ± 0.02 |
| `jbrowse-react-lgv` | 63.614 ± 0.461 | 63.109 | 64.011 | 1.60 ± 0.02 |


results/large_multi_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 29.333 ± 0.060 | 29.291 | 29.376 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 115.666 ± 1.457 | 114.636 | 116.696 | 3.94 ± 0.05 |
| `jbrowse-web-1.6.7` | 110.787 ± 0.356 | 110.536 | 111.039 | 3.78 ± 0.01 |
| `jbrowse-web-1.6.7_small_opt` | 110.554 ± 0.476 | 110.217 | 110.890 | 3.77 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 48.612 ± 0.411 | 48.322 | 48.903 | 1.66 ± 0.01 |
| `jbrowse-react-lgv` | 88.834 ± 0.455 | 88.512 | 89.156 | 3.03 ± 0.02 |
| `main_with_bam_update` | 95.541 ± 0.086 | 95.481 | 95.602 | 3.26 ± 0.01 |
| `main_with_more_workers` | 67.940 ± 1.423 | 66.934 | 68.946 | 2.32 ± 0.05 |


results/large_multi_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 39.715 ± 0.490 | 39.369 | 40.062 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 85.180 ± 0.063 | 85.136 | 85.224 | 2.14 ± 0.03 |
| `jbrowse-web-1.6.7` | 86.073 ± 0.582 | 85.662 | 86.484 | 2.17 ± 0.03 |
| `jbrowse-web-1.6.7_small_opt` | 85.042 ± 0.052 | 85.005 | 85.079 | 2.14 ± 0.03 |
| `jbrowse-web-1.6.7_aggro_opt` | 50.882 ± 0.170 | 50.762 | 51.002 | 1.28 ± 0.02 |
| `jbrowse-react-lgv` | 62.774 ± 0.653 | 62.312 | 63.236 | 1.58 ± 0.03 |
| `main_with_bam_update` | 85.092 ± 0.136 | 84.996 | 85.188 | 2.14 ± 0.03 |
| `main_with_more_workers` | 58.756 ± 0.732 | 58.239 | 59.274 | 1.48 ± 0.03 |


results/large_shortread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 11.899 ± 0.117 | 11.816 | 11.982 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 75.544 ± 0.430 | 75.240 | 75.848 | 6.35 ± 0.07 |
| `jbrowse-web-1.6.7` | 72.910 ± 0.243 | 72.738 | 73.081 | 6.13 ± 0.06 |
| `jbrowse-web-1.6.7_small_opt` | 72.638 ± 1.348 | 71.685 | 73.591 | 6.10 ± 0.13 |
| `jbrowse-web-1.6.7_aggro_opt` | 30.422 ± 0.098 | 30.353 | 30.491 | 2.56 ± 0.03 |
| `jbrowse-react-lgv` | 52.120 ± 0.474 | 51.784 | 52.455 | 4.38 ± 0.06 |
| `main_with_bam_update` | 62.880 ± 1.062 | 62.129 | 63.631 | 5.28 ± 0.10 |
| `main_with_more_workers` | 63.169 ± 0.049 | 63.134 | 63.204 | 5.31 ± 0.05 |


results/large_shortread_bam_small_region.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.772 ± 0.005 | 2.769 | 2.775 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 20.543 ± 0.135 | 20.448 | 20.639 | 7.41 ± 0.05 |
| `jbrowse-web-1.6.7` | 20.138 ± 0.006 | 20.133 | 20.142 | 7.26 ± 0.01 |
| `jbrowse-web-1.6.7_small_opt` | 20.194 ± 0.082 | 20.136 | 20.252 | 7.29 ± 0.03 |
| `jbrowse-web-1.6.7_aggro_opt` | 9.632 ± 0.049 | 9.597 | 9.667 | 3.48 ± 0.02 |
| `jbrowse-react-lgv` | 19.268 ± 0.021 | 19.254 | 19.283 | 6.95 ± 0.01 |
| `main_with_bam_update` | 10.122 ± 0.008 | 10.117 | 10.128 | 3.65 ± 0.01 |
| `main_with_more_workers` | 10.175 ± 0.036 | 10.150 | 10.201 | 3.67 ± 0.01 |


results/large_shortread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 16.046 ± 0.293 | 15.839 | 16.253 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 56.531 ± 0.416 | 56.237 | 56.826 | 3.52 ± 0.07 |
| `jbrowse-web-1.6.7` | 55.822 ± 0.282 | 55.622 | 56.021 | 3.48 ± 0.07 |
| `jbrowse-web-1.6.7_small_opt` | 55.966 ± 0.012 | 55.957 | 55.974 | 3.49 ± 0.06 |
| `jbrowse-web-1.6.7_aggro_opt` | 29.824 ± 0.109 | 29.747 | 29.901 | 1.86 ± 0.03 |
| `jbrowse-react-lgv` | 38.549 ± 0.309 | 38.331 | 38.767 | 2.40 ± 0.05 |
| `main_with_bam_update` | 56.515 ± 0.059 | 56.473 | 56.556 | 3.52 ± 0.06 |
| `main_with_more_workers` | 57.364 ± 0.836 | 56.773 | 57.955 | 3.57 ± 0.08 |


results/small_longread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 3.648 ± 0.004 | 3.646 | 3.651 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 8.731 ± 0.034 | 8.707 | 8.755 | 2.39 ± 0.01 |
| `jbrowse-web-1.6.7` | 8.439 ± 0.010 | 8.432 | 8.445 | 2.31 ± 0.00 |
| `jbrowse-web-1.6.7_small_opt` | 8.346 ± 0.009 | 8.340 | 8.352 | 2.29 ± 0.00 |
| `jbrowse-web-1.6.7_aggro_opt` | 5.345 ± 0.014 | 5.335 | 5.355 | 1.47 ± 0.00 |
| `jbrowse-react-lgv` | 6.463 ± 0.011 | 6.455 | 6.471 | 1.77 ± 0.00 |
| `main_with_bam_update` | 7.847 ± 0.006 | 7.843 | 7.852 | 2.15 ± 0.00 |
| `main_with_more_workers` | 7.850 ± 0.066 | 7.803 | 7.897 | 2.15 ± 0.02 |


results/small_longread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 4.272 ± 0.016 | 4.261 | 4.283 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 7.814 ± 0.041 | 7.785 | 7.843 | 1.83 ± 0.01 |
| `jbrowse-web-1.6.7` | 7.939 ± 0.010 | 7.932 | 7.946 | 1.86 ± 0.01 |
| `jbrowse-web-1.6.7_small_opt` | 7.993 ± 0.012 | 7.984 | 8.002 | 1.87 ± 0.01 |
| `jbrowse-web-1.6.7_aggro_opt` | 6.216 ± 0.028 | 6.196 | 6.236 | 1.45 ± 0.01 |
| `jbrowse-react-lgv` | 6.349 ± 0.058 | 6.308 | 6.391 | 1.49 ± 0.01 |
| `main_with_bam_update` | 7.898 ± 0.010 | 7.891 | 7.906 | 1.85 ± 0.01 |
| `main_with_more_workers` | 7.952 ± 0.034 | 7.928 | 7.976 | 1.86 ± 0.01 |


results/small_multi.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 9.233 ± 0.038 | 9.206 | 9.260 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 18.318 ± 0.026 | 18.300 | 18.336 | 1.98 ± 0.01 |
| `jbrowse-web-1.6.7` | 19.338 ± 0.141 | 19.238 | 19.438 | 2.09 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 18.762 ± 0.396 | 18.482 | 19.042 | 2.03 ± 0.04 |
| `jbrowse-web-1.6.7_aggro_opt` | 11.623 ± 0.390 | 11.348 | 11.899 | 1.26 ± 0.04 |
| `jbrowse-react-lgv` | 13.882 ± 0.042 | 13.852 | 13.911 | 1.50 ± 0.01 |
| `main_with_bam_update` | 18.428 ± 0.593 | 18.009 | 18.847 | 2.00 ± 0.06 |
| `main_with_more_workers` | 13.154 ± 0.050 | 13.119 | 13.189 | 1.42 ± 0.01 |


results/small_multi_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 4.807 ± 0.073 | 4.756 | 4.915 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 11.683 ± 0.037 | 11.638 | 11.723 | 2.43 ± 0.04 |
| `jbrowse-web-1.6.7` | 11.406 ± 0.054 | 11.329 | 11.450 | 2.37 ± 0.04 |
| `jbrowse-web-1.6.7_small_opt` | 11.310 ± 0.038 | 11.253 | 11.332 | 2.35 ± 0.04 |
| `jbrowse-web-1.6.7_aggro_opt` | 6.550 ± 0.033 | 6.504 | 6.579 | 1.36 ± 0.02 |
| `jbrowse-react-lgv` | 8.382 ± 0.052 | 8.335 | 8.451 | 1.74 ± 0.03 |


results/small_multi_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 5.548 ± 0.061 | 5.473 | 5.614 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 10.150 ± 0.093 | 10.023 | 10.222 | 1.83 ± 0.03 |
| `jbrowse-web-1.6.7` | 10.400 ± 0.016 | 10.383 | 10.419 | 1.87 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 10.382 ± 0.087 | 10.283 | 10.491 | 1.87 ± 0.03 |
| `jbrowse-web-1.6.7_aggro_opt` | 7.458 ± 0.023 | 7.431 | 7.484 | 1.34 ± 0.02 |
| `jbrowse-react-lgv` | 7.821 ± 0.018 | 7.797 | 7.835 | 1.41 ± 0.02 |


results/small_shortread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.187 ± 0.239 | 2.018 | 2.356 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 6.397 ± 0.075 | 6.344 | 6.450 | 2.92 ± 0.32 |
| `jbrowse-web-1.6.7` | 6.243 ± 0.019 | 6.230 | 6.256 | 2.85 ± 0.31 |
| `jbrowse-web-1.6.7_small_opt` | 6.321 ± 0.002 | 6.319 | 6.322 | 2.89 ± 0.32 |
| `jbrowse-web-1.6.7_aggro_opt` | 4.422 ± 0.028 | 4.403 | 4.442 | 2.02 ± 0.22 |
| `jbrowse-react-lgv` | 4.320 ± 0.093 | 4.254 | 4.386 | 1.98 ± 0.22 |
| `main_with_bam_update` | 6.139 ± 0.031 | 6.117 | 6.161 | 2.81 ± 0.31 |
| `main_with_more_workers` | 6.121 ± 0.048 | 6.088 | 6.155 | 2.80 ± 0.31 |


results/small_shortread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.260 ± 0.017 | 2.248 | 2.271 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 5.921 ± 0.009 | 5.915 | 5.928 | 2.62 ± 0.02 |
| `jbrowse-web-1.6.7` | 5.963 ± 0.002 | 5.962 | 5.965 | 2.64 ± 0.02 |
| `jbrowse-web-1.6.7_small_opt` | 5.939 ± 0.028 | 5.919 | 5.959 | 2.63 ± 0.02 |
| `jbrowse-web-1.6.7_aggro_opt` | 4.713 ± 0.013 | 4.704 | 4.723 | 2.09 ± 0.02 |
| `jbrowse-react-lgv` | 4.373 ± 0.000 | 4.373 | 4.374 | 1.94 ± 0.01 |
| `main_with_bam_update` | 5.938 ± 0.031 | 5.916 | 5.960 | 2.63 ± 0.02 |
| `main_with_more_workers` | 5.949 ± 0.015 | 5.938 | 5.959 | 2.63 ± 0.02 |


