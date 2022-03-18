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
| `igvjs` | 18.3113 | 18.267 | 18.355 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 41.1707 | 41.158 | 41.182 | 2.25 |
| `jbrowse-web-1.6.7` | 39.6305 | 39.534 | 39.726 | 2.16 |
| `jbrowse-web-1.6.7_small_opt` | 37.4129 | 37.342 | 37.482 | 2.04 |
| `jbrowse-web-1.6.7_aggro_opt` | 20.2697 | 20.257 | 20.282 | 1.11 |
| `jbrowse-react-lgv` | 33.8301 | 33.610 | 34.050 | 1.85 |
| `main_with_bam_update` | 35.4899 | 35.263 | 35.714 | 1.94 |
| `main_with_more_workers` | 34.9839 | 34.949 | 35.017 | 1.91 |


results/large_longread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 24.6972 | 24.526 | 24.868 | 1.02 |
| `jbrowse-web-1.6.5` | 32.1118 | 31.731 | 32.492 | 1.32 |
| `jbrowse-web-1.6.7` | 31.5516 | 31.434 | 31.668 | 1.30 |
| `jbrowse-web-1.6.7_small_opt` | 31.0489 | 30.872 | 31.225 | 1.28 |
| `jbrowse-web-1.6.7_aggro_opt` | 24.2811 | 24.005 | 24.558 | 1.00 🍏|
| `jbrowse-react-lgv` | 26.9825 | 26.859 | 27.106 | 1.11 |
| `main_with_bam_update` | 31.4599 | 31.368 | 31.550 | 1.30 |
| `main_with_more_workers` | 32.0676 | 31.617 | 32.517 | 1.32 |


results/large_multi_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 29.3330 | 29.291 | 29.376 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 115.6667 | 114.636 | 116.696 | 3.94 |
| `jbrowse-web-1.6.7` | 110.7876 | 110.536 | 111.039 | 3.78 |
| `jbrowse-web-1.6.7_small_opt` | 110.5546 | 110.217 | 110.890 | 3.77 |
| `jbrowse-web-1.6.7_aggro_opt` | 48.6121 | 48.322 | 48.903 | 1.66 |
| `jbrowse-react-lgv` | 88.8345 | 88.512 | 89.156 | 3.03 |
| `main_with_bam_update` | 95.5416 | 95.481 | 95.602 | 3.26 |
| `main_with_more_workers` | 67.9403 | 66.934 | 68.946 | 2.32 |


results/large_multi_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 39.7150 | 39.369 | 40.062 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 85.1803 | 85.136 | 85.224 | 2.14 |
| `jbrowse-web-1.6.7` | 86.0732 | 85.662 | 86.484 | 2.17 |
| `jbrowse-web-1.6.7_small_opt` | 85.0422 | 85.005 | 85.079 | 2.14 |
| `jbrowse-web-1.6.7_aggro_opt` | 50.8820 | 50.762 | 51.002 | 1.28 |
| `jbrowse-react-lgv` | 62.7743 | 62.312 | 63.236 | 1.58 |
| `main_with_bam_update` | 85.0926 | 84.996 | 85.188 | 2.14 |
| `main_with_more_workers` | 58.7562 | 58.239 | 59.274 | 1.48 |


results/large_multi.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 39.8592 | 39.476 | 40.058 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 84.3160 | 83.743 | 84.663 | 2.12 |
| `jbrowse-web-1.6.7` | 85.3336 | 85.042 | 85.809 | 2.14 |
| `jbrowse-web-1.6.7_small_opt` | 84.2947 | 83.839 | 84.709 | 2.11 |
| `jbrowse-web-1.6.7_aggro_opt` | 49.4341 | 48.637 | 49.848 | 1.24 |
| `jbrowse-react-lgv` | 63.6141 | 63.109 | 64.011 | 1.60 |


results/large_shortread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 11.8997 | 11.816 | 11.982 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 75.5440 | 75.240 | 75.848 | 6.35 |
| `jbrowse-web-1.6.7` | 72.9103 | 72.738 | 73.081 | 6.13 |
| `jbrowse-web-1.6.7_small_opt` | 72.6388 | 71.685 | 73.591 | 6.10 |
| `jbrowse-web-1.6.7_aggro_opt` | 30.4228 | 30.353 | 30.491 | 2.56 |
| `jbrowse-react-lgv` | 52.1204 | 51.784 | 52.455 | 4.38 |
| `main_with_bam_update` | 62.8802 | 62.129 | 63.631 | 5.28 |
| `main_with_more_workers` | 63.1699 | 63.134 | 63.204 | 5.31 |


results/large_shortread_bam_small_region.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.7725 | 2.769 | 2.775 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 20.5435 | 20.448 | 20.639 | 7.41 |
| `jbrowse-web-1.6.7` | 20.1386 | 20.133 | 20.142 | 7.26 |
| `jbrowse-web-1.6.7_small_opt` | 20.1942 | 20.136 | 20.252 | 7.29 |
| `jbrowse-web-1.6.7_aggro_opt` | 9.6329 | 9.597 | 9.667 | 3.48 |
| `jbrowse-react-lgv` | 19.2681 | 19.254 | 19.283 | 6.95 |
| `main_with_bam_update` | 10.1228 | 10.117 | 10.128 | 3.65 |
| `main_with_more_workers` | 10.1756 | 10.150 | 10.201 | 3.67 |


results/large_shortread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 16.0463 | 15.839 | 16.253 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 56.5316 | 56.237 | 56.826 | 3.52 |
| `jbrowse-web-1.6.7` | 55.8222 | 55.622 | 56.021 | 3.48 |
| `jbrowse-web-1.6.7_small_opt` | 55.9662 | 55.957 | 55.974 | 3.49 |
| `jbrowse-web-1.6.7_aggro_opt` | 29.8249 | 29.747 | 29.901 | 1.86 |
| `jbrowse-react-lgv` | 38.5499 | 38.331 | 38.767 | 2.40 |
| `main_with_bam_update` | 56.5159 | 56.473 | 56.556 | 3.52 |
| `main_with_more_workers` | 57.3646 | 56.773 | 57.955 | 3.57 |


results/small_longread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 3.6484 | 3.646 | 3.651 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 8.7314 | 8.707 | 8.755 | 2.39 |
| `jbrowse-web-1.6.7` | 8.4390 | 8.432 | 8.445 | 2.31 |
| `jbrowse-web-1.6.7_small_opt` | 8.3469 | 8.340 | 8.352 | 2.29 |
| `jbrowse-web-1.6.7_aggro_opt` | 5.3454 | 5.335 | 5.355 | 1.47 |
| `jbrowse-react-lgv` | 6.4631 | 6.455 | 6.471 | 1.77 |
| `main_with_bam_update` | 7.8476 | 7.843 | 7.852 | 2.15 |
| `main_with_more_workers` | 7.8506 | 7.803 | 7.897 | 2.15 |


results/small_longread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 4.2726 | 4.261 | 4.283 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 7.8141 | 7.785 | 7.843 | 1.83 |
| `jbrowse-web-1.6.7` | 7.9390 | 7.932 | 7.946 | 1.86 |
| `jbrowse-web-1.6.7_small_opt` | 7.9932 | 7.984 | 8.002 | 1.87 |
| `jbrowse-web-1.6.7_aggro_opt` | 6.2168 | 6.196 | 6.236 | 1.45 |
| `jbrowse-react-lgv` | 6.3498 | 6.308 | 6.391 | 1.49 |
| `main_with_bam_update` | 7.8980 | 7.891 | 7.906 | 1.85 |
| `main_with_more_workers` | 7.9524 | 7.928 | 7.976 | 1.86 |


results/small_multi_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 4.8073 | 4.756 | 4.915 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 11.6837 | 11.638 | 11.723 | 2.43 |
| `jbrowse-web-1.6.7` | 11.4064 | 11.329 | 11.450 | 2.37 |
| `jbrowse-web-1.6.7_small_opt` | 11.3108 | 11.253 | 11.332 | 2.35 |
| `jbrowse-web-1.6.7_aggro_opt` | 6.5503 | 6.504 | 6.579 | 1.36 |
| `jbrowse-react-lgv` | 8.3822 | 8.335 | 8.451 | 1.74 |


results/small_multi_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 5.5481 | 5.473 | 5.614 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 10.1503 | 10.023 | 10.222 | 1.83 |
| `jbrowse-web-1.6.7` | 10.4006 | 10.383 | 10.419 | 1.87 |
| `jbrowse-web-1.6.7_small_opt` | 10.3827 | 10.283 | 10.491 | 1.87 |
| `jbrowse-web-1.6.7_aggro_opt` | 7.4583 | 7.431 | 7.484 | 1.34 |
| `jbrowse-react-lgv` | 7.8218 | 7.797 | 7.835 | 1.41 |


results/small_multi.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 9.2338 | 9.206 | 9.260 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 18.3186 | 18.300 | 18.336 | 1.98 |
| `jbrowse-web-1.6.7` | 19.3381 | 19.238 | 19.438 | 2.09 |
| `jbrowse-web-1.6.7_small_opt` | 18.7626 | 18.482 | 19.042 | 2.03 |
| `jbrowse-web-1.6.7_aggro_opt` | 11.6230 | 11.348 | 11.899 | 1.26 |
| `jbrowse-react-lgv` | 13.8822 | 13.852 | 13.911 | 1.50 |
| `main_with_bam_update` | 18.4283 | 18.009 | 18.847 | 2.00 |
| `main_with_more_workers` | 13.1540 | 13.119 | 13.189 | 1.42 |


results/small_shortread_bam.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.1879 | 2.018 | 2.356 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 6.3975 | 6.344 | 6.450 | 2.92 |
| `jbrowse-web-1.6.7` | 6.2439 | 6.230 | 6.256 | 2.85 |
| `jbrowse-web-1.6.7_small_opt` | 6.3212 | 6.319 | 6.322 | 2.89 |
| `jbrowse-web-1.6.7_aggro_opt` | 4.4228 | 4.403 | 4.442 | 2.02 |
| `jbrowse-react-lgv` | 4.3203 | 4.254 | 4.386 | 1.98 |
| `main_with_bam_update` | 6.1391 | 6.117 | 6.161 | 2.81 |
| `main_with_more_workers` | 6.1218 | 6.088 | 6.155 | 2.80 |


results/small_shortread_cram.md


| Command | Mean [s] | Min [s] | Max [s] | Relative |
|:---|---:|---:|---:|---:|
| `igvjs` | 2.2607 | 2.248 | 2.271 | 1.00 🍏|
| `jbrowse-web-1.6.5` | 5.9219 | 5.915 | 5.928 | 2.62 |
| `jbrowse-web-1.6.7` | 5.9632 | 5.962 | 5.965 | 2.64 |
| `jbrowse-web-1.6.7_small_opt` | 5.9398 | 5.919 | 5.959 | 2.63 |
| `jbrowse-web-1.6.7_aggro_opt` | 4.7133 | 4.704 | 4.723 | 2.09 |
| `jbrowse-react-lgv` | 4.3730 | 4.373 | 4.374 | 1.94 |
| `main_with_bam_update` | 5.9381 | 5.916 | 5.960 | 2.63 |
| `main_with_more_workers` | 5.9495 | 5.938 | 5.959 | 2.63 |


