import tablemark from 'tablemark'
import fs from 'fs'

const map = {
  'http://localhost:8000/': 'igvjs',
  'http://localhost:8001/': 'jb2 v1.6.5',
  'http://localhost:8002/': 'jb2 v1.6.7',
  'http://localhost:8003/': 'jb2 v1.6.7+optim',
  'http://localhost:8004/': 'jb2 v1.6.7+noserial',
  'http://localhost:8005/': 'jb2 embedded lgv',
}

const r = JSON.parse(fs.readFileSync(process.argv[2]))
const means = r.results.map(r => r.mean)
const min = Math.min(...means)
const final = r.results.map(r => ({
  command:
    Object.entries(map).find(f => r.command.includes(f[0]))[1] || r.command,
  mean: r.mean.toPrecision(3) + ' +/- ' + r.stddev.toPrecision(1),
  relative: (r.mean / min).toPrecision(3) + (r.mean === min ? ' 🍏' : ''),
}))

console.log(tablemark(final))
