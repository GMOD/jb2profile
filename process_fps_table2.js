import fs from 'fs'
import { sum } from './util.js'

const str = fs.readFileSync(process.argv[2], 'utf8')

const map = {
  8000: 'igvjs',
  8001: 'jb2 web',
  8002: 'jb2 emb',
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
    'alpha',
    'beta',
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
      const T = sum(elts)
      const E = sum(elts, l => (l * l) / (2 * T))
      const V = sum(elts, l => (l * l * l) / (3 * T)) - E * E
      const A = (E * E) / V
      const B = E / V
      const f = n => n.toPrecision(4)
      const cov = coverage.slice(0, coverage.length - 1)
      const prog = map[key]
      return [
        cov,
        window_size,
        read_type,
        file_type,
        prog,
        f(E),
        f(V),
        f(A),
        f(B),
      ].join('\t')
    })
    .join('\n'),
)
