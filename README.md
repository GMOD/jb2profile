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

### Figures

![](img/bam_sr.png)
![](img/bam_lr.png)
![](img/cram_sr.png)
![](img/cram_lr.png)
