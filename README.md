# jb2profile

Some profiling on jbrowse 2

## Setup

Run ./init.sh

Will compile igv.js CRA app, @jbrowse/react-linear-genome-view based CRA app, and download jbrowse web instance

Will also download BAM/CRAM files for testing

Also you we use a custom igv.js build which has a special "DONE" console.log
that it emits on completion of drawing BAM, which profile_igvjs.js listens for

```
git clone https://github.com/cmdcolin/igv.js
cd igv.js
yarn
yarn build
yarn link
```

## Results

### Summary

IGV is often 1.7 times (small 15x coverage) to 3x times (2000x coverage) than JBrowse Web. The optimization branch of JBrowse Web proposes to reduce this gap (optimization branch is 2x faster than JBrowse Web, but as above, igv.js can be 3x as fast)

### How to read results

localhost:8000 is IGV
localhost:8001 is jbrowse-web (tag v1.6.5)
localhost:8002 is jbrowse-web (optimization branch, no serialization of features and others)

### Detailed results
