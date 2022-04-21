import fs from 'fs'

const rep = {
  'http://localhost:8000/': 'igvjs',
  'http://localhost:8001/': 'jb2 v1.7.4',
  'http://localhost:8002/': 'jb2 no serialize',
  'http://localhost:8003/': 'jb2 embedded lgv',
}
  const [,coverage,numTracks,win,read_type,file_type]=process.argv[2].replace('.json','').split('-')



function formatLine(line) {
  const [command, mean, exit_code] = line
  const key = Object.keys(rep).find(key => command.includes(key))
  const newcommand = command
    .replace(/node profile_jb2web.js "/, '')
    .replace(/node profile_igvjs.js "/, '')
    .replace(/ .*fps.json"/, '')
    .replace(
      /\?loc=chr22_mask:129,000-130,000&assembly=hg19mod&tracks=/,
      '1kb\t',
    )
    .replace(
      /\?loc=chr22_mask:129,000-139,000&assembly=hg19mod&tracks=/,
      '10kb\t',
    )
    .replace(
      /\?loc=chr22_mask:125,000-144,000&assembly=hg19mod&tracks=/,
      '19kb\t',
    )
    .replace(/shortread.bam.*/, '\tshortread\tbam')
    .replace(/shortread.cram.*/, '\tshortread\tcram')
    .replace(/longread.bam.*/, '\tlongread\tbam')
    .replace(/longread.cram.*/, '\tlongread\tcram')
    .replace(/results.*/, '')
    .replace(/"/g, '')
    .replace(key, rep[key])



  return newcommand.includes('jb2export')
    ? undefined
    : [rep[key],win,coverage,numTracks,read_type,file_type, mean, exit_code].join('\t')
}

const x = JSON.parse(fs.readFileSync(process.argv[2]))
console.log(
  x.results
    .map(r => formatLine([r.command, r.mean, r.exit_codes[0]]))
    .filter(f => !!f)
    .join('\n'),
)
