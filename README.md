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


results/hg19_ultralong_cram_100b.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 11.3  | 1.00 🍏  |
| jb2 v1.6.5                | 16.9  | 1.49     |
| jb2 v1.6.7                | 17.4  | 1.54     |
| jb2 v1.6.9                | 13.5  | 1.19     |
| jb2 v1.6.9+rpc_optim      | 13.8  | 1.22     |
| jb2 v1.6.7+noserial_optim | 12.8  | 1.13     |





results/hg19_ultralong_cram_20kb.json
| Command | Mean  | Relative |
| :------ | :---- | :------- |
| igvjs   | 17.3  | 1.00 🍏  |





results/hg19_ultralong_cram_2kb.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 11.7  | 1.00 🍏  |
| jb2 v1.6.5                | 13.1  | 1.12     |
| jb2 v1.6.7                | 13.2  | 1.13     |
| jb2 v1.6.9                | 13.2  | 1.14     |
| jb2 v1.6.9+rpc_optim      | 13.4  | 1.15     |
| jb2 v1.6.7+noserial_optim | 12.8  | 1.09     |





results/hg19_ultralong_cram_50kb.json




results/volvox-1000x-longread-bam.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 12.0  | 1.00 🍏  |
| jb2 v1.6.5                | 25.2  | 2.11     |
| jb2 v1.6.7                | 23.3  | 1.95     |
| jb2 v1.6.9                | 17.8  | 1.49     |
| jb2 v1.6.9+rpc_optim      | 18.5  | 1.55     |
| jb2 v1.6.7+noserial_optim | 13.8  | 1.16     |
| jb2 embedded lgv          | 13.5  | 1.13     |





results/volvox-1000x-longread-cram.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 15.0  | 1.00 🍏  |
| jb2 v1.6.5                | 18.8  | 1.25     |
| jb2 v1.6.7                | 19.0  | 1.27     |
| jb2 v1.6.9                | 18.3  | 1.22     |
| jb2 v1.6.9+rpc_optim      | 19.3  | 1.29     |
| jb2 v1.6.7+noserial_optim | 16.5  | 1.10     |
| jb2 embedded lgv          | 16.3  | 1.09     |





results/volvox-20x-shortread-bam-10kb.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 1.71  | 1.00 🍏  |
| jb2 v1.6.5                | 4.04  | 2.36     |
| jb2 v1.6.7                | 3.96  | 2.32     |
| jb2 v1.6.9                | 3.74  | 2.19     |
| jb2 v1.6.9+rpc_optim      | 3.89  | 2.27     |
| jb2 v1.6.7+noserial_optim | 3.15  | 1.84     |
| jb2 embedded lgv          | 2.79  | 1.63     |





results/volvox-20x-shortread-cram-10kb.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 1.79  | 1.00 🍏  |
| jb2 v1.6.5                | 4.08  | 2.27     |
| jb2 v1.6.7                | 4.06  | 2.26     |
| jb2 v1.6.9                | 4.09  | 2.28     |
| jb2 v1.6.9+rpc_optim      | 4.16  | 2.32     |
| jb2 v1.6.7+noserial_optim | 3.62  | 2.02     |
| jb2 embedded lgv          | 3.43  | 1.91     |





results/volvox-2400x-shortread-bam-100bp.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 2.05  | 1.00 🍏  |
| jb2 v1.6.5                | 11.8  | 5.75     |
| jb2 v1.6.7                | 11.8  | 5.77     |
| jb2 v1.6.9                | 4.50  | 2.20     |
| jb2 v1.6.9+rpc_optim      | 4.71  | 2.30     |
| jb2 v1.6.7+noserial_optim | 4.44  | 2.17     |
| jb2 embedded lgv          | 4.13  | 2.01     |





results/volvox-2400x-shortread-bam-2kb.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 7.56  | 1.00 🍏  |
| jb2 v1.6.5                | 44.3  | 5.86     |
| jb2 v1.6.7                | 42.4  | 5.61     |
| jb2 v1.6.9                | 33.1  | 4.38     |
| jb2 v1.6.9+rpc_optim      | 34.2  | 4.52     |
| jb2 v1.6.7+noserial_optim | 18.9  | 2.50     |
| jb2 embedded lgv          | 17.6  | 2.33     |





results/volvox-2400x-shortread-cram-2kb.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 10.0  | 1.00 🍏  |
| jb2 v1.6.5                | 33.5  | 3.35     |
| jb2 v1.6.7                | 34.0  | 3.39     |
| jb2 v1.6.9                | 33.1  | 3.30     |
| jb2 v1.6.9+rpc_optim      | 32.7  | 3.26     |
| jb2 v1.6.7+noserial_optim | 23.7  | 2.36     |
| jb2 embedded lgv          | 23.0  | 2.30     |





results/volvox-50x-longread-cram.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 3.21  | 1.00 🍏  |
| jb2 v1.6.5                | 5.45  | 1.70     |
| jb2 v1.6.7                | 5.49  | 1.71     |
| jb2 v1.6.9                | 5.45  | 1.70     |
| jb2 v1.6.9+rpc_optim      | 5.45  | 1.70     |
| jb2 v1.6.7+noserial_optim | 4.99  | 1.56     |
| jb2 embedded lgv          | 4.67  | 1.46     |





results/volvox-multi-highcov.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 44.3  | 1.66     |
| jb2 v1.6.5                | 49.1  | 1.84     |
| jb2 v1.6.7                | 50.3  | 1.88     |
| jb2 v1.6.9                | 38.6  | 1.44     |
| jb2 v1.6.9+rpc_optim      | 38.4  | 1.44     |
| jb2 v1.6.7+noserial_optim | 26.7  | 1.00 🍏  |
| jb2 embedded lgv          | 69.4  | 2.60     |





results/volvox-multi-lowcov.json
| Command                   | Mean  | Relative |
| :------------------------ | :---- | :------- |
| igvjs                     | 5.94  | 1.21     |
| jb2 v1.6.5                | 5.93  | 1.20     |
| jb2 v1.6.7                | 5.89  | 1.20     |
| jb2 v1.6.9                | 5.67  | 1.15     |
| jb2 v1.6.9+rpc_optim      | 5.72  | 1.16     |
| jb2 v1.6.7+noserial_optim | 4.93  | 1.00 🍏  |
| jb2 embedded lgv          | 7.68  | 1.56     |





