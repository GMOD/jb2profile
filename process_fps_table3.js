import fs from 'fs'
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
    'total',
    'long1s',
    'long5s',
    'long10s',
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
      const frames = total_frames.split(',').map(e => 1 / +e)
      const total = frames.reduce((a, b) => a + b, 0)
      const long1s = frames.filter(f => f > 1).reduce((a, b) => a + b, 0)
      const long5s = frames.filter(f => f > 5).reduce((a, b) => a + b, 0)
      const long10s = frames.filter(f => f > 10).reduce((a, b) => a + b, 0)
      const prog = map[key]

      return [
        coverage.replace('x', ''),
        window_size,
        read_type,
        file_type,
        prog,
        total / 20,
        long1s / 20,
        long5s / 20,
        long10s / 20,
      ]
    })
    .map(f => f.join('\t'))
    .join('\n'),
)
