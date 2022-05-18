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
      if (!total_frames) return
      const arr = command.split('_')
      const port = arr[arr.length - 1]
      const cmd = arr.slice(0, arr.length - 2).join('_')
      const [coverage, window_size, read_type, file_type] = cmd.split('-')
      const key = Object.keys(map).find(key => port === key)
      const A = [0, ...total_frames.split(',').map(f => 1 / +f)]
      A.sort((a, b) => a - b)

      const Stab = new Map(A.map((r, i) => [i, sum(A.slice(0, i))]))
      const Ltab = new Map(A.map(r => [r, A.filter(f => f < r).length]))
      const N = A.length
      const T = sum(A)
      const E = sum(A, l => (l * l) / (2 * T))
      const V = sum(A, l => (l * l * l) / (3 * T)) - E * E
      const S = k => Stab.get(k)
      const L = X => Ltab.get(X)
      const C = X => (1 / T) * (X * (N - L(X)) + S(L(X)))
      const F = Q => {
        let maxK = -Infinity
        let val
        for (let k = 0; k < N; k++) {
          val = C(A[k])
          if (val < Q) {
            maxK = k
          }
        }

        return maxK
      }

      const C_inv = Q => {
        const kk = F(Q)
        const jj = S(kk)
        return (Q * T - jj) / (N - kk)
      }
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
          E,
          V,
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
