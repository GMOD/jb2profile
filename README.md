# jb2profile

Some profiling on jbrowse 2

## Results

### How to read results

- igvjs - a create-react-app with igv package from npm installed
- jbrowse-web-1.6.5 - stock
- jbrowse-web-1.6.7 - stock
- jb2 v1.6.7+optim - modest optimizations from https://github.com/GMOD/jbrowse-components/pull/2809
- jb2 v1.6.7+noserial - removes serialization across webworker which removes ability to click on features, and is just here to demonstrate the overhead of serialization
- jb2 embedded lgv - a create-react-app with @jbrowse/react-linear-genome-view

## Notes

- thse tests are all chrome based (using puppeteer library for automation), running same on firefox or safari may be slower (especially on jbrowse-web)
- these benchmarks are not comprehensive, and just a taste of some small examples on simulated data on volvox

### Platform

Ran tests on a Dell Precision i9 laptop, ~2019, Ubuntu 22.04

Tests will also be run on a Amazon EC2 instance xlarge 4vcpu 16gb memory ubuntu 20.04

### How to interpret test names

The test e.g. volvox-20x-shortread-cram-10kb.json shows the coverage of the file being tested and region size being viewed

### Detailed results

Ran on a laptop with ubuntu 220.4 beta, intel i9

results/volvox-1000x-longread-bam.json, 
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 12.1 | 1.00 🍏 |
| jb2 v1.6.5 | 25.2 | 2.08 |
| jb2 v1.6.7 | 23.9 | 1.97 |
| jb2 v1.6.9 | 18.7 | 1.55 |
| jb2 main | 20.1 | 1.66 |
| jb2 no serialize | 14.8 | 1.22 |
| jb2 embedded lgv | 13.4 | 1.10 |

results/volvox-1000x-longread-cram.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 15.6 | 1.07 |
| jb2 v1.6.5 | 20.0 | 1.37 |
| jb2 v1.6.7 | 19.2 | 1.32 |
| jb2 v1.6.9 | 19.1 | 1.31 |
| jb2 main | 17.0 | 1.17 |
| jb2 no serialize | 14.6 | 1.00 🍏 |
| jb2 embedded lgv | 15.9 | 1.09 |

results/volvox-20x-shortread-bam-10kb.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 1.75 | 1.00 🍏 |
| jb2 v1.6.5 | 4.17 | 2.38 |
| jb2 v1.6.7 | 4.00 | 2.28 |
| jb2 v1.6.9 | 4.03 | 2.30 |
| jb2 main | 3.92 | 2.24 |
| jb2 no serialize | 3.54 | 2.02 |
| jb2 embedded lgv | 2.83 | 1.61 |

results/volvox-20x-shortread-cram-10kb.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 1.82 | 1.00 🍏 |
| jb2 v1.6.5 | 4.08 | 2.24 |
| jb2 v1.6.7 | 4.02 | 2.20 |
| jb2 v1.6.9 | 4.21 | 2.31 |
| jb2 main | 3.85 | 2.11 |
| jb2 no serialize | 3.65 | 2.00 |
| jb2 embedded lgv | 3.47 | 1.90 |

results/volvox-2400x-shortread-bam-100bp.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 2.00 | 1.00 🍏 |
| jb2 v1.6.5 | 12.1 | 6.01 |
| jb2 v1.6.7 | 11.8 | 5.89 |
| jb2 v1.6.9 | 4.51 | 2.25 |
| jb2 main | 4.37 | 2.18 |
| jb2 no serialize | 4.31 | 2.15 |
| jb2 embedded lgv | 4.20 | 2.10 |

results/volvox-2400x-shortread-bam-2kb.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 7.85 | 1.00 🍏 |
| jb2 v1.6.5 | 45.4 | 5.79 |
| jb2 v1.6.7 | 43.2 | 5.50 |
| jb2 v1.6.9 | 34.0 | 4.33 |
| jb2 main | 31.0 | 3.96 |
| jb2 no serialize | 14.7 | 1.88 |
| jb2 embedded lgv | 18.8 | 2.39 |

results/volvox-2400x-shortread-cram-2kb.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 10.4 | 1.00 🍏 |
| jb2 v1.6.5 | 35.4 | 3.40 |
| jb2 v1.6.7 | 34.4 | 3.30 |
| jb2 v1.6.9 | 35.9 | 3.44 |
| jb2 main | 31.1 | 2.99 |
| jb2 no serialize | 21.3 | 2.05 |
| jb2 embedded lgv | 24.0 | 2.30 |

results/volvox-50x-longread-cram.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 3.33 | 1.00 🍏 |
| jb2 v1.6.5 | 5.44 | 1.64 |
| jb2 v1.6.7 | 5.41 | 1.63 |
| jb2 v1.6.9 | 5.36 | 1.61 |
| jb2 main | 5.18 | 1.56 |
| jb2 no serialize | 4.90 | 1.47 |
| jb2 embedded lgv | 4.76 | 1.43 |

results/volvox-multi-highcov.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 43.6 | 1.88 |
| jb2 v1.6.5 | 49.5 | 2.13 |
| jb2 v1.6.7 | 48.7 | 2.10 |
| jb2 v1.6.9 | 39.0 | 1.68 |
| jb2 main | 35.6 | 1.53 |
| jb2 no serialize | 23.2 | 1.00 🍏 |
| jb2 embedded lgv | 70.3 | 3.03 |

results/volvox-multi-lowcov.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 6.21 | 1.27 |
| jb2 v1.6.5 | 6.05 | 1.23 |
| jb2 v1.6.7 | 6.37 | 1.30 |
| jb2 v1.6.9 | 5.53 | 1.13 |
| jb2 main | 5.38 | 1.10 |
| jb2 no serialize | 4.91 | 1.00 🍏 |
| jb2 embedded lgv | 7.91 | 1.61 |

## Results on EC2 Ubuntu 20 ultra-large

Note: jobs on 1.6.5/1.6.7/1.6.9 timed out so removed here

results/volvox-1000x-longread-bam.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 19.0 | 1.00 🍏 |
| jb2 main | 31.6 | 1.67 |
| jb2 no serialize | 24.4 | 1.29 |
| jb2 embedded lgv | 21.9 | 1.16 |

results/volvox-1000x-longread-cram.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 24.7 | 1.11 |
| jb2 main | 26.8 | 1.21 |
| jb2 no serialize | 22.1 | 1.00 🍏 |
| jb2 embedded lgv | 26.1 | 1.18 |

results/volvox-20x-shortread-bam-10kb.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 2.08 | 1.00 🍏 |
| jb2 main | 5.62 | 2.70 |
| jb2 no serialize | 4.45 | 2.14 |
| jb2 embedded lgv | 3.88 | 1.86 |

results/volvox-20x-shortread-cram-10kb.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 2.27 | 1.00 🍏 |
| jb2 main | 5.46 | 2.41 |
| jb2 no serialize | 4.89 | 2.16 |
| jb2 embedded lgv | 4.39 | 1.94 |

results/volvox-2400x-shortread-bam-100bp.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 2.78 | 1.00 🍏 |
| jb2 main | 7.11 | 2.56 |
| jb2 no serialize | 6.59 | 2.37 |
| jb2 embedded lgv | 6.45 | 2.32 |

results/volvox-2400x-shortread-bam-2kb.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 12.4 | 1.00 🍏 |
| jb2 main | 54.0 | 4.37 |
| jb2 no serialize | 24.8 | 2.01 |
| jb2 embedded lgv | 30.0 | 2.43 |

results/volvox-2400x-shortread-cram-2kb.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 16.2 | 1.00 🍏 |
| jb2 main | 53.2 | 3.28 |
| jb2 no serialize | 32.7 | 2.01 |
| jb2 embedded lgv | 38.3 | 2.36 |

results/volvox-50x-longread-cram.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 4.35 | 1.00 🍏 |
| jb2 main | 7.03 | 1.61 |
| jb2 no serialize | 6.54 | 1.50 |
| jb2 embedded lgv | 6.11 | 1.40 |

results/volvox-multi-highcov.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 71.6 | 1.37 |
| jb2 main | 85.1 | 1.63 |
| jb2 no serialize | 52.3 | 1.00 🍏 |
| jb2 embedded lgv | 119 | 2.27 |

results/volvox-multi-lowcov.json
| Command | Mean | Relative |
| :--------------- | :---- | :------- |
| igvjs | 9.40 | 1.03 |
| jb2 main | 10.6 | 1.16 |
| jb2 no serialize | 9.11 | 1.00 🍏 |
| jb2 embedded lgv | 11.9 | 1.30 |
results/*.json




