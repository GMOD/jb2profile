import fs from 'fs'
const file = process.argv[2]
const [, base, port] = file.match(/(.*)_fps_(.*)\.json/)
const r2 = JSON.parse(fs.readFileSync(base + '.json')).results
const r1 = r2[+port - 8000].times.filter(f => f > 300).length
const fps = fs
  .readFileSync(file, 'utf8')
  .split('\n')
  .filter(f => !!f)
  .map(line => {
    const r = line.replace(/.*\]\[/, '[')
    return r1 < 5 ? JSON.parse(r) : []
  })
  .flat()
process.stdout.write('\t' + fps.map(r => r.toPrecision(6)).join(',') + '\n')
