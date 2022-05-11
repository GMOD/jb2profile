import fs from 'fs'
import { mean, stddev } from './util.js'

const rep = {
  'http://localhost:8000/': 'igvjs',
  'http://localhost:8002/': 'jb2 emb',
  'http://localhost:8003/': 'jb1',
  'http://localhost:8004/': 'jb2 web',
}

function formatLine([command, times]) {
  const key = Object.keys(rep).find(key => command.includes(key))
  const filt = times.map(time => +time).filter(time => time < 300)
  const m = filt.length < 5 ? 300 : mean(filt)
  const s = (filt.length < 5 ? 1 : stddev(filt)) / Math.sqrt(filt.length)
  const read_type = command.includes('shortread') ? 'shortread' : 'longread'
  const file_type = command.includes('bam') ? 'bam' : 'cram'
  const coverage = command.match(/(\d+)x/)[1]
  const prog = rep[key]
  return prog && [prog, '5kb', coverage, read_type, file_type, m, s].join('\t')
}

const x = JSON.parse(fs.readFileSync(process.argv[2]))
console.log(
  x.results
    .map(r => formatLine([r.command, r.times]))
    .filter(f => !!f)
    .join('\n'),
)
