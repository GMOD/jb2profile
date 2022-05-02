import fs from 'fs'
import { mean, stddev } from './util.js'

const rep = {
  'http://localhost:8000/': 'igvjs\t',
  'http://localhost:8001/': 'jb2 web\t',
  'http://localhost:8002/': 'jb2 embedded\t',
  'http://localhost:8003/': 'jb1\t',
}
const [, coverage, numTracks, win, read_type, file_type] = process.argv[2]
  .replace('.json', '')
  .split('-')

function formatLine(line) {
  const [command, times] = line
  const key = Object.keys(rep).find(key => command.includes(key))
  const filt = times.map(time => +time).filter(time => time < 300)

  const m = filt.length < 5 ? 300 : mean(filt)
  const s = filt.length < 5 ? 1 : stddev(filt)

  return [rep[key], win, coverage, numTracks, read_type, file_type, m, s].join(
    '\t',
  )
}

const x = JSON.parse(fs.readFileSync(process.argv[2]))
console.log(
  x.results
    .map(r => formatLine([r.command, r.times]))
    .filter(f => !!f)
    .join('\n'),
)
