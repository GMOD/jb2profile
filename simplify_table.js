import fs from 'fs'
let tab = fs.readFileSync(process.argv[2], 'utf8')

const rep = {
  'http://localhost:8000/': 'igvjs\t',
  'http://localhost:8001/': 'jb2 v1.6.5\t',
  'http://localhost:8002/': 'jb2 v1.6.7\t',
  'http://localhost:8003/': 'jb2 v1.6.9\t',
  'http://localhost:8004/': 'jb2 main\t',
  'http://localhost:8005/': 'jb2 no serialize\t',
  'http://localhost:8006/': 'jb2 embedded lgv\t',
}
console.log(['program', 'window', 'coverage', 'time', 'exit_code'].join('\t'))
console.log(
  tab
    .replace(/node profile_jb2web.js "/g, '')
    .replace(/node profile_igvjs.js "/g, '')
    .replace(/\?loc=ctgA:15,000-34,000&assembly=volvox&tracks=/g, '19kb\t')
    .replace(/\?loc=ctgA:15,000-35,000&assembly=volvox&tracks=/g, '20kb\t')
    .replace(/\?loc=ctgA:19,000-20,000&assembly=volvox&tracks=/g, '1kb\t')
    .replace(/\?loc=ctgA:19,000-29,000&assembly=volvox&tracks=/g, '10kb\t')
    .replace(/"/g, '')
    .split('\n')
    .map(row => {
      const key = Object.keys(rep).find(key => row.includes(key))
      return row.replace(key, rep[key])
    })
    .join('\n'),
)
