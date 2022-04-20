import fs from 'fs'
const str = fs.readFileSync(process.argv[2], 'utf8')

const map = {
  8000: 'igvjs',
  8001: 'jb2 v1.7.4',
  8002: 'jb2 no serialize',
  8003: 'jb2 embedded lgv',
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
      const [coverage, window, read_type, file_type] = cmd.split('-')
      const key = Object.keys(map).find(key => port === key)
      return total_frames
        .split(',')
        .map(frame =>
          [
            coverage.slice(0, coverage.length - 1),
            window,
            read_type,
            file_type,
            map[key],
            frame,
          ].join('\t'),
        )
        .join('\n')
    })
    .join('\n'),
)
