# jb2profile

Some profiling on jbrowse 2

## Pre-requisites

Install pbsim2, add to path

## Setup

To setup from scratch, see source code for the breakdown of the scripts

```
./everything.sh
```

## Background

We had a concerted effort to improve performance in JBrowse 2, particularly
alignments track performance, in early 2022. This lasted from versions ~1.6.4
-> 1.7.5. This README only shows the latest version, but older documents show
that versions 1.6.5 would timeout and fail under loads while the latest version
shows significantly better performance.

## Results

### How to read results

- igvjs - a create-react-app with igv package from npm installed. the igv.js is
  instrumented to output "DONE" to the console when finished, and to have an
  increased fetchSizeLimit (which is otherwise git in CRAM longread tests)
- jbrowse-web-1.7.5 - stock instance of jbrowse 1.7.5
- jb2 embedded lgv - a create-react-app with @jbrowse/react-linear-genome-view

## Notes

- these tests are all chrome based (using puppeteer library for automation),
  running same on firefox or safari may be slower (especially on jbrowse-web)
- these benchmarks are not comprehensive, and just a taste of some small
  examples on simulated data on hg19

### Platform

Ran tests on a Dell Precision i9 laptop, ~2019, Ubuntu 22.04

### How to interpret test names

The test e.g. hg19-20x-shortread-cram-10kb.json shows the coverage of the file
being tested and region size being viewed

### Figures

#### Runtime

![](img/single.png)

Note: the cram longread has failures in igv.js due to fetchSizeLimit being
triggered

#### Main thread hanging time

Shows a plot of the seconds-per-frame (inverse of FPS) in order to highlight
frames that took an especially long time, essentially indicating when the
user-interface would be locked up

![](img/fps.png)

#### Rendering multiple tracks at once

This image shows two figures for rendering different numbers of tracks at once,
in BAM and CRAM format, and at various coverage levels. If line is truncated, then
it timed out (>10 minutes indicating memory out of bounds or extreme slowness).
This example shows the power of webworkers which can parallelize rendering

![](img/multi.png)
