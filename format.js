import tablemark from 'tablemark'
import fs from 'fs'
const r = JSON.parse(fs.readFileSync(process.argv[2]))
const means = r.results.map(r => r.mean)
const min = Math.min(...means)
const final = r.results.map(r => ({
  command: r.command,
  mean: r.mean.toPrecision(3) + ' +/- ' + r.stddev.toPrecision(1),
  relative: (r.mean / min).toPrecision(3) + (r.mean === min ? ' 🍏' : ''),
}))

console.log(tablemark(final))
