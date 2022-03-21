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


results/volvox-1000x-longread-bam.json
| Command             | Mean  | Relative |
| :------------------ | :---- | :------- |
| igvjs               | 12.0  | 1.00 🍏  |
| jb2 v1.6.5          | 26.1  | 2.17     |
| jb2 v1.6.7          | 25.0  | 2.08     |
| jb2 v1.6.7+optim    | 19.1  | 1.59     |
| jb2 v1.6.7+noserial | 14.0  | 1.17     |
| jb2 embedded lgv    | 20.7  | 1.72     |

results/volvox-1000x-longread-cram.json
| Command             | Mean  | Relative |
| :------------------ | :---- | :------- |
| igvjs               | 14.9  | 1.00 🍏  |
| jb2 v1.6.5          | 19.8  | 1.34     |
| jb2 v1.6.7          | 19.1  | 1.29     |
| jb2 v1.6.7+optim    | 19.9  | 1.34     |
| jb2 v1.6.7+noserial | 16.4  | 1.11     |
| jb2 embedded lgv    | 16.7  | 1.13     |

results/volvox-20x-shortread-bam-10kb.json
| Command             | Mean  | Relative |
| :------------------ | :---- | :------- |
| igvjs               | 1.87  | 1.00 🍏  |
| jb2 v1.6.5          | 4.27  | 2.28     |
| jb2 v1.6.7          | 4.28  | 2.29     |
| jb2 v1.6.7+optim    | 4.11  | 2.19     |
| jb2 v1.6.7+noserial | 3.43  | 1.83     |
| jb2 embedded lgv    | 3.24  | 1.73     |

results/volvox-20x-shortread-cram-10kb.json
| Command             | Mean  | Relative |
| :------------------ | :---- | :------- |
| igvjs               | 1.94  | 1.00 🍏  |
| jb2 v1.6.5          | 4.21  | 2.17     |
| jb2 v1.6.7          | 4.13  | 2.13     |
| jb2 v1.6.7+optim    | 4.20  | 2.17     |
| jb2 v1.6.7+noserial | 3.69  | 1.91     |
| jb2 embedded lgv    | 3.43  | 1.77     |

results/volvox-2400x-shortread-bam-100bp.json
| Command             | Mean  | Relative |
| :------------------ | :---- | :------- |
| igvjs               | 1.91  | 1.00 🍏  |
| jb2 v1.6.5          | 12.2  | 6.38     |
| jb2 v1.6.7          | 12.1  | 6.34     |
| jb2 v1.6.7+optim    | 4.88  | 2.56     |
| jb2 v1.6.7+noserial | 4.55  | 2.38     |
| jb2 embedded lgv    | 11.6  | 6.07     |

results/volvox-2400x-shortread-bam-2kb.json
| Command             | Mean  | Relative |
| :------------------ | :---- | :------- |
| igvjs               | 7.36  | 1.00 🍏  |
| jb2 v1.6.5          | 45.6  | 6.20     |
| jb2 v1.6.7          | 47.4  | 6.45     |
| jb2 v1.6.7+optim    | 35.0  | 4.76     |
| jb2 v1.6.7+noserial | 19.0  | 2.59     |
| jb2 embedded lgv    | 29.6  | 4.02     |

results/volvox-2400x-shortread-cram-2kb.json
| Command             | Mean  | Relative |
| :------------------ | :---- | :------- |
| igvjs               | 10.8  | 1.00 🍏  |
| jb2 v1.6.5          | 35.8  | 3.31     |
| jb2 v1.6.7          | 34.2  | 3.16     |
| jb2 v1.6.7+optim    | 34.5  | 3.19     |
| jb2 v1.6.7+noserial | 23.6  | 2.18     |
| jb2 embedded lgv    | 23.8  | 2.20     |

results/volvox-50x-longread-cram.json
| Command             | Mean  | Relative |
| :------------------ | :---- | :------- |
| igvjs               | 3.26  | 1.00 🍏  |
| jb2 v1.6.5          | 5.61  | 1.72     |
| jb2 v1.6.7          | 5.42  | 1.66     |
| jb2 v1.6.7+optim    | 5.48  | 1.68     |
| jb2 v1.6.7+noserial | 5.12  | 1.57     |
| jb2 embedded lgv    | 4.65  | 1.42     |

results/volvox-multi-highcov.json
| Command             | Mean  | Relative |
| :------------------ | :---- | :------- |
| igvjs               | 45.2  | 1.64     |
| jb2 v1.6.5          | 50.1  | 1.82     |
| jb2 v1.6.7          | 49.9  | 1.81     |
| jb2 v1.6.7+optim    | 39.8  | 1.45     |
| jb2 v1.6.7+noserial | 27.5  | 1.00 🍏  |
| jb2 embedded lgv    | 89.5  | 3.25     |

results/volvox-multi-lowcov.json
| Command             | Mean  | Relative |
| :------------------ | :---- | :------- |
| igvjs               | 6.61  | 1.33     |
| jb2 v1.6.5          | 6.22  | 1.25     |
| jb2 v1.6.7          | 6.61  | 1.33     |
| jb2 v1.6.7+optim    | 5.88  | 1.19     |
| jb2 v1.6.7+noserial | 4.96  | 1.00 🍏  |
| jb2 embedded lgv    | 8.96  | 1.81     |

