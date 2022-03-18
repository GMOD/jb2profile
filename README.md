# jb2profile

Some profiling on jbrowse 2

## Results

### How to read results

- igvjs - a create-react-app with igv package from npm installed
- jbrowse-web-1.6.5 - stock
- jbrowse-web-1.6.7 - stock
- jb2 v1.6.7+optim  - modest optimizations from https://github.com/GMOD/jbrowse-components/pull/2809
- jb2 v1.6.7+noserial - removes serialization across webworker which removes ability to click on features, and is just here to demonstrate the overhead of serialization
- jb2 embedded lgv - a create-react-app with @jbrowse/react-linear-genome-view

## Notes

- thse tests are all chrome based (using puppeteer library for automation), running same on firefox or safari may be slower (especially on jbrowse-web)
- these benchmarks are not comprehensive, and just a taste of some small examples on simulated data on volvox

### Platform


Ran tests on a Dell Precision i9 laptop, ~2019, Ubuntu 22.04

Tests will also be run on a Amazon EC2 instance xlarge 4vcpu 16gb memory ubuntu 20.04

### Detailed results



results/volvox-1000x-longread-bam.json
| Command             | Mean         | Relative |
| :------------------ | :----------- | :------- |
| igvjs               | 12.0 +/- 0.4 | 1.00 🍏  |
| jb2 v1.6.5          | 25.3 +/- 0.4 | 2.10     |
| jb2 v1.6.7          | 24.2 +/- 0.6 | 2.01     |
| jb2 v1.6.7+optim    | 18.4 +/- 0.5 | 1.53     |
| jb2 v1.6.7+noserial | 15.5 +/- 0.7 | 1.29     |
| jb2 embedded lgv    | 20.6 +/- 0.5 | 1.71     |

results/volvox-1000x-longread-cram.json
| Command             | Mean         | Relative |
| :------------------ | :----------- | :------- |
| igvjs               | 18.2 +/- 0.7 | 1.27     |
| jb2 v1.6.5          | 20.3 +/- 0.6 | 1.42     |
| jb2 v1.6.7          | 19.9 +/- 0.8 | 1.39     |
| jb2 v1.6.7+optim    | 17.3 +/- 0.3 | 1.21     |
| jb2 v1.6.7+noserial | 14.3 +/- 0.3 | 1.00 🍏  |
| jb2 embedded lgv    | 16.6 +/- 0.5 | 1.16     |

results/volvox-20x-shortread-bam-10kb.json
| Command             | Mean          | Relative |
| :------------------ | :------------ | :------- |
| igvjs               | 1.77 +/- 0.09 | 1.00 🍏  |
| jb2 v1.6.5          | 4.01 +/- 0.07 | 2.26     |
| jb2 v1.6.7          | 4.04 +/- 0.2  | 2.28     |
| jb2 v1.6.7+optim    | 3.76 +/- 0.07 | 2.12     |
| jb2 v1.6.7+noserial | 2.93 +/- 0.04 | 1.65     |
| jb2 embedded lgv    | 2.95 +/- 0.03 | 1.66     |

results/volvox-20x-shortread-cram-10kb.json
| Command             | Mean          | Relative |
| :------------------ | :------------ | :------- |
| igvjs               | 1.87 +/- 0.04 | 1.00 🍏  |
| jb2 v1.6.5          | 4.04 +/- 0.08 | 2.16     |
| jb2 v1.6.7          | 4.04 +/- 0.1  | 2.16     |
| jb2 v1.6.7+optim    | 3.91 +/- 0.06 | 2.10     |
| jb2 v1.6.7+noserial | 3.22 +/- 0.06 | 1.72     |
| jb2 embedded lgv    | 3.28 +/- 0.04 | 1.76     |

results/volvox-2400x-shortread-bam-100bp.json
| Command             | Mean          | Relative |
| :------------------ | :------------ | :------- |
| igvjs               | 2.10 +/- 0.08 | 1.00 🍏  |
| jb2 v1.6.5          | 13.5 +/- 0.7  | 6.42     |
| jb2 v1.6.7          | 12.2 +/- 0.2  | 5.82     |
| jb2 v1.6.7+optim    | 12.0 +/- 0.2  | 5.72     |
| jb2 v1.6.7+noserial | 11.5 +/- 0.4  | 5.46     |
| jb2 embedded lgv    | 12.0 +/- 0.4  | 5.74     |

results/volvox-2400x-shortread-bam-2kb.json
| Command             | Mean         | Relative |
| :------------------ | :----------- | :------- |
| igvjs               | 7.58 +/- 0.2 | 1.00 🍏  |
| jb2 v1.6.5          | 46.3 +/- 2   | 6.11     |
| jb2 v1.6.7          | 48.7 +/- 2   | 6.42     |
| jb2 v1.6.7+optim    | 43.3 +/- 3   | 5.71     |
| jb2 v1.6.7+noserial | 26.5 +/- 0.4 | 3.50     |
| jb2 embedded lgv    | 33.3 +/- 2   | 4.40     |

results/volvox-2400x-shortread-cram-2kb.json
| Command             | Mean         | Relative |
| :------------------ | :----------- | :------- |
| igvjs               | 10.6 +/- 0.2 | 1.00 🍏  |
| jb2 v1.6.5          | 33.8 +/- 0.6 | 3.20     |
| jb2 v1.6.7          | 34.3 +/- 0.4 | 3.25     |
| jb2 v1.6.7+optim    | 29.6 +/- 0.3 | 2.80     |
| jb2 v1.6.7+noserial | 17.9 +/- 1   | 1.70     |
| jb2 embedded lgv    | 24.2 +/- 1   | 2.29     |

results/volvox-50x-longread-cram.json
| Command             | Mean          | Relative |
| :------------------ | :------------ | :------- |
| igvjs               | 3.31 +/- 0.07 | 1.00 🍏  |
| jb2 v1.6.5          | 5.33 +/- 0.1  | 1.61     |
| jb2 v1.6.7          | 5.35 +/- 0.2  | 1.62     |
| jb2 v1.6.7+optim    | 4.89 +/- 0.1  | 1.48     |
| jb2 v1.6.7+noserial | 4.33 +/- 0.1  | 1.31     |
| jb2 embedded lgv    | 4.46 +/- 0.06 | 1.35     |

results/volvox-multi-highcov.json
| Command             | Mean         | Relative |
| :------------------ | :----------- | :------- |
| igvjs               | 43.9 +/- 2   | 1.55     |
| jb2 v1.6.5          | 60.5 +/- 9   | 2.14     |
| jb2 v1.6.7          | 52.4 +/- 2   | 1.85     |
| jb2 v1.6.7+optim    | 51.3 +/- 2   | 1.81     |
| jb2 v1.6.7+noserial | 28.3 +/- 0.8 | 1.00 🍏  |
| jb2 embedded lgv    | 89.0 +/- 2   | 3.15     |

results/volvox-multi-lowcov.json
| Command             | Mean          | Relative |
| :------------------ | :------------ | :------- |
| igvjs               | 6.60 +/- 0.4  | 1.27     |
| jb2 v1.6.5          | 6.17 +/- 0.2  | 1.19     |
| jb2 v1.6.7          | 6.25 +/- 0.2  | 1.20     |
| jb2 v1.6.7+optim    | 5.33 +/- 0.09 | 1.03     |
| jb2 v1.6.7+noserial | 5.19 +/- 0.09 | 1.00 🍏  |
| jb2 embedded lgv    | 9.01 +/- 0.4  | 1.74     |

