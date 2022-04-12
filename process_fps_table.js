const fs = require('fs')
const str = fs.readFileSync('fps_table.csv', 'utf8')

const map = {
  8000: 'igvjs',
  8001: 'jb2 v1.6.5',
  8002: 'jb2 v1.6.7',
  8003: 'jb2 v1.6.9',
  8004: 'jb2 main',
  8005: 'jb2 no serialize',
  8006: 'jb2 embedded lgv',
}

console.log(
  ['coverage', 'window', 'read_type', 'file_type', 'program', 'average_fps'].join(
    '\t',
  ),
)
console.log(
  str
    .split('\n')
    .map(line => {
      const [command, average_fps] = line.split('\t')
      const arr = command.split('_')
      const port = arr[arr.length - 1]
      const cmd = arr.slice(0, arr.length - 2).join('_')
      const [coverage, window, read_type, file_type] = cmd.split('-')
      const key = Object.keys(map).find(key => port === key)
      return [
        coverage.slice(0, coverage.length - 1),
        window,
        read_type,
        file_type,
        map[key],
        average_fps,
      ].join('\t')
    })
    .join('\n'),
)
