import fs from 'fs'
try {
  const x = JSON.parse(fs.readFileSync(process.argv[2]))
  x.results.map(r => {
    console.log([r.command, r.mean, r.exit_codes[0]].join('\t'))
  })
} catch (e) {}
