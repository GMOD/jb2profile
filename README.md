# jb2profile

Some profiling on jbrowse 2

## Build igvtester app

setup custom igv.js build which has a special "DONE" console.log that it emits
on completion of drawing BAM, which profile_igvjs.js listens for

```
git clone https://github.com/cmdcolin/igv.js
cd igv.js
yarn
yarn build
yarn link
```

use custom igv.js build in tester app

```
cd igvtester
yarn
yarn link igv
yarn build
cd build
python3 -m RangeHTTPServer # starts on http://localhost:8000
```
