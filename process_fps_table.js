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
    'average_fps',
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
      const prog = map[key]
      return total_frames
        .split(',')
        .map(
          frame =>
            prog &&
            [
              coverage.slice(0, coverage.length - 1),
              window_size,
              read_type,
              file_type,
              prog,
              frame,
            ].join('\t'),
        )
        .filter(f => !!f)
        .join('\n')
    })
    .join('\n'),
)
