import fs from 'fs'
import { sum } from './util.js'

const str = fs.readFileSync(process.argv[2], 'utf8')

const map = {
  8000: 'igvjs',
  8001: 'jb2 w/ workers',
  8002: 'jb2 w/o workers',
  8003: 'jb1',
}

console.log(
  [
    'coverage',
    'window',
    'read_type',
    'file_type',
    'program',
    'expected_value',
    'variance',
    'p05',
    'p25',
    'p50',
    'p75',
    'p95',
  ].join('\t'),
)
console.log(
  str
    .split('\n')
    .filter(f => !!f)
    .map(line => {
      const [command, total_frames] = line.split('\t')
      const arr = command.split('_')
      const port = arr[arr.length - 1]
      const cmd = arr.slice(0, arr.length - 2).join('_')
      const [coverage, window_size, read_type, file_type] = cmd.split('-')
      const key = Object.keys(map).find(key => port === key)
      const elts = total_frames.split(',').map(f => 1 / +f)
      const sorted_elts = elts.sort((a, b) => a - b)
      const N = elts.length
      const T = sum(elts)
      const S = k => sorted_elts.slice(0, k).reduce((a, b) => a + b, 0)
      const L = X => sorted_elts.filter(f => f < X).length
      const C = X => (1 / T) * (X * (N - L(X))) + S(L(X))
      const F = Q => {
        let max = -Infinity
        for (let k = 0; k < N; k++) {
          const val = C(sorted_elts[k])
          if (val < Q) {
            max = val
          }
        }
        return max
      }

      const C_inv = Q => (Q * T - S(F(Q))) / (N - F(Q))
      const p95 = C_inv(0.95)
      const p05 = C_inv(0.05)
      const p25 = C_inv(0.25)
      const p75 = C_inv(0.75)
      const p50 = C_inv(0.5)

      const cov = coverage.slice(0, coverage.length - 1)
      const prog = map[key]
      return (
        prog &&
        [
          cov,
          window_size,
          read_type,
          file_type,
          prog,
          p05,
          p25,
          p50,
          p75,
          p95,
        ].join('\t')
      )
    })
    .filter(f => !!f)
    .join('\n'),
)
