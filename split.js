const x = process.argv[2]
console.log(
  x
    .split(',')
    .map(elt => elt + ' aln,' + elt + ' snp')
    .join(','),
)
