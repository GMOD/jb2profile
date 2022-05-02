import fs from 'fs'

const rep = {
  'http://localhost:8000/': 'igvjs\t',
  'http://localhost:8001/': 'jb2 web\t',
  'http://localhost:8002/': 'jb2 embedded\t',
  'http://localhost:8003/': 'jb1\t',
}

function formatLine([command, times]) {
  const key = Object.keys(rep).find(key => command.includes(key))
  const filt = times.map(time => +time).filter(time => time < 300)
  const m = filt.length < 5 ? 300 : mean(filt)
  const s = filt.length < 5 ? 1 : stddev(filt)
  return [rep[key], m, s].join('\t')
}

const x = JSON.parse(fs.readFileSync(process.argv[2]))
console.log(
  x.results
    .map(r => formatLine([r.command, r.times]))
    .filter(f => !!f)
    .join('\n'),
)
