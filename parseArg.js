console.log(
  process.argv[2]
    .split(',')
    .map(track => (track.includes('.bam') ? '--bam' : '--cram') + ' ' + track)
    .join(' '),
)
