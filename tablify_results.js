import fs from 'fs'

const rep = {
  'http://localhost:8000/': 'igvjs\t',
  'http://localhost:8001/': 'jb2 v1.6.5\t',
  'http://localhost:8002/': 'jb2 v1.6.7\t',
  'http://localhost:8003/': 'jb2 v1.6.9\t',
  'http://localhost:8004/': 'jb2 main\t',
  'http://localhost:8005/': 'jb2 no serialize\t',
  'http://localhost:8006/': 'jb2 embedded lgv\t',
}
function formatLine(line) {
  const [command, mean, exit_code] = line
  const key = Object.keys(rep).find(key => command.includes(key))
  const newcommand = command
    .replace(/node profile_jb2web.js "/, '')
    .replace(/node profile_igvjs.js "/, '')
    .replace(/ .*fps.json"/, '')
    .replace(/\?loc=ctgA:15,000-34,000&assembly=volvox&tracks=/, '19kb\t')
    .replace(/\?loc=ctgA:19,000-20,000&assembly=volvox&tracks=/, '1kb\t')
    .replace(/\?loc=ctgA:19,000-29,000&assembly=volvox&tracks=/, '10kb\t')
    .replace(/"/g, '')
    .replace(key, rep[key])

  return [newcommand, mean, exit_code].join('\t')
}

const x = JSON.parse(fs.readFileSync(process.argv[2]))
console.log(
  x.results
    .map(r => formatLine([r.command, r.mean, r.exit_codes[0]]))
    .join('\n'),
)
