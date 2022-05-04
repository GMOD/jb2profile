import fs from 'fs'

const rep = {
  'http://localhost:8000/': 'igvjs',
  'http://localhost:8001/': 'jb2 web',
  'http://localhost:8002/': 'jb2 emb',
  'http://localhost:8003/': 'jb1',
}
const [, coverage, numTracks, win, read_type, file_type] = process.argv[2]
  .replace('.json', '')
  .split('-')

function formatLine(line) {
  const [command, mean] = line
  const key = Object.keys(rep).find(key => command.includes(key))

  return [rep[key], win, coverage, numTracks, read_type, file_type, mean].join(
    '\t',
  )
}

const x = JSON.parse(fs.readFileSync(process.argv[2]))
console.log(
  x.results
    .map(r => formatLine([r.command, r.mean]))
    .filter(f => !!f)
    .join('\n'),
)
