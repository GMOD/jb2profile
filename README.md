# jb2profile

Some profiling on jbrowse 2

## Results

### How to read results

- igvjs is a create-react-app with igv package from npm installed
- jbrowse-web-1.6.5 is the full jbrowse-web package (uses webworkers)
- jbrowse-web-1.6.5+optim is the full jbrowse-web package with some unmerged
  optimizations which disables serializing features across the RPC boundary,
  which will require work to accomplish a merge (uses webworkers)
- jbrowse-lgv is a create-react-app with the @jbrowse/react-linear-genome-view
  package installed (no webworkers)

### Summary

- igv.js is often somewhat faster than both JBrowse Web and
  @jbrowse/react-linaer-genome-view
- high coverage short read BAM and CRAM files stand out as being poor
  performers (~5.4 and ~3x slower respectively)
- potential optimizations to help the high coverage short reads on the optim
  branch lower this gap to ~2.8x slower and ~1.6x slower respectively
- this is all chrome based, firefox will likely be slower on jbrowse-web
- these benchmarks are not comprehensive, and just a taste of some small
  examples on simulated data on volvox

### Detailed results

results/large_longread_cram.md (1000x long reads)

| Command                   |   Mean [s] | Min [s] | Max [s] |  Relative |
| :------------------------ | ---------: | ------: | ------: | --------: |
| `igvjs`                   | 16.2 ± 0.3 |    15.9 |    16.5 |    1.0 🍏 |
| `jbrowse-web-1.6.5`       | 19.9 ± 0.3 |    19.5 |    20.2 | 1.2 ± 0.0 |
| `jbrowse-web-1.6.5+optim` | 16.2 ± 0.5 |    15.7 |    16.8 | 1.0 ± 0.0 |
| `jbrowse-react-lgv`       | 17.5 ± 0.3 |    17.1 |    17.7 | 1.0 ± 0.0 |

results/large_multi.md (load 1000x long reads and 2000x short reads at once)

| Command                   |   Mean [s] | Min [s] | Max [s] |  Relative |
| :------------------------ | ---------: | ------: | ------: | --------: |
| `igvjs`                   | 25.8 ± 1.1 |    24.7 |    26.9 | 1.4 ± 0.0 |
| `jbrowse-web-1.6.5`       | 35.0 ± 0.1 |    34.9 |    35.2 | 1.9 ± 0.0 |
| `jbrowse-web-1.6.5+optim` | 18.1 ± 0.1 |    18.0 |    18.3 |    1.0 🍏 |
| `jbrowse-react-lgv`       | 37.3 ± 0.2 |    37.1 |    37.6 | 2.0 ± 0.0 |

results/large_shortread_bam.md (2000x short reads)

| Command                   |   Mean [s] | Min [s] | Max [s] |  Relative |
| :------------------------ | ---------: | ------: | ------: | --------: |
| `igvjs`                   |  8.6 ± 0.3 |     8.3 |     8.9 |    1.0 🍏 |
| `jbrowse-web-1.6.5`       | 46.5 ± 1.0 |    45.3 |    47.4 | 5.4 ± 0.2 |
| `jbrowse-web-1.6.5+optim` | 24.5 ± 0.3 |    24.1 |    24.7 | 2.8 ± 0.1 |
| `jbrowse-react-lgv`       | 30.0 ± 0.5 |    29.5 |    30.5 | 3.4 ± 0.1 |

results/large_shortread_cram.md (2000x short reads)

| Command                   |   Mean [s] | Min [s] | Max [s] |  Relative |
| :------------------------ | ---------: | ------: | ------: | --------: |
| `igvjs`                   | 11.0 ± 0.2 |    10.8 |    11.3 |    1.0 🍏 |
| `jbrowse-web-1.6.5`       | 34.3 ± 0.3 |    34.0 |    34.7 | 3.1 ± 0.0 |
| `jbrowse-web-1.6.5+optim` | 17.5 ± 0.2 |    17.2 |    17.7 | 1.5 ± 0.0 |
| `jbrowse-react-lgv`       | 24.0 ± 0.4 |    23.5 |    24.4 | 2.1 ± 0.0 |

results/small_longread_cram.md (50x long reads)

| Command                   |  Mean [s] | Min [s] | Max [s] |  Relative |
| :------------------------ | --------: | ------: | ------: | --------: |
| `igvjs`                   | 4.0 ± 0.0 |     4.0 |     4.1 |    1.0 🍏 |
| `jbrowse-web-1.6.5`       | 6.3 ± 0.0 |     6.3 |     6.4 | 1.5 ± 0.0 |
| `jbrowse-web-1.6.5+optim` | 5.5 ± 0.0 |     5.4 |     5.5 | 1.3 ± 0.0 |
| `jbrowse-react-lgv`       | 5.5 ± 0.0 |     5.4 |     5.5 | 1.3 ± 0.0 |

results/small_multi.md (4 tracks from the 30x short and 50x read datasets)

| Command                   |  Mean [s] | Min [s] | Max [s] |  Relative |
| :------------------------ | --------: | ------: | ------: | --------: |
| `igvjs`                   | 7.1 ± 0.2 |     6.8 |     7.4 | 1.2 ± 0.0 |
| `jbrowse-web-1.6.5`       | 7.2 ± 0.0 |     7.1 |     7.2 | 1.2 ± 0.0 |
| `jbrowse-web-1.6.5+optim` | 5.6 ± 0.0 |     5.6 |     5.7 |    1.0 🍏 |
| `jbrowse-react-lgv`       | 9.9 ± 0.1 |     9.7 |    10.0 | 1.7 ± 0.0 |

results/small_shortread_bam.md (30x short reads)

| Command                   |  Mean [s] | Min [s] | Max [s] |  Relative |
| :------------------------ | --------: | ------: | ------: | --------: |
| `igvjs`                   | 2.7 ± 0.1 |     2.6 |     2.8 |    1.0 🍏 |
| `jbrowse-web-1.6.5`       | 5.4 ± 0.0 |     5.3 |     5.4 | 1.9 ± 0.1 |
| `jbrowse-web-1.6.5+optim` | 4.2 ± 0.1 |     4.1 |     4.4 | 1.5 ± 0.1 |
| `jbrowse-react-lgv`       | 4.1 ± 0.0 |     4.1 |     4.2 | 1.5 ± 0.0 |

results/small_shortread_cram.md (30x short reads)

| Command                   |  Mean [s] | Min [s] | Max [s] |  Relative |
| :------------------------ | --------: | ------: | ------: | --------: |
| `igvjs`                   | 3.0 ± 0.0 |     2.9 |     3.1 |    1.0 🍏 |
| `jbrowse-web-1.6.5`       | 5.0 ± 0.2 |     4.8 |     5.2 | 1.6 ± 0.0 |
| `jbrowse-web-1.6.5+optim` | 4.2 ± 0.0 |     4.1 |     4.2 | 1.4 ± 0.0 |
| `jbrowse-react-lgv`       | 4.2 ± 0.0 |     4.1 |     4.3 | 1.4 ± 0.0 |

## Developers

Run ./init.sh

Will compile igv.js CRA app, @jbrowse/react-linear-genome-view based CRA app, and download jbrowse web instance

Will also download BAM/CRAM files for testing

Also this repo uses a custom igv.js build which has a special "DONE"
console.log that it emits on completion of drawing BAM, which profile_igvjs.js
listens for

```
git clone https://github.com/cmdcolin/igv.js
cd igv.js
yarn
yarn build
yarn link
```
