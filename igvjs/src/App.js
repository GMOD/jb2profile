import { useRef, useEffect } from 'react'
import igv from 'igv'

function useQueryParams() {
  const params = new URLSearchParams(window ? window.location.search : {})

  return new Proxy(params, {
    get(target, prop) {
      return target.get(prop)
    },
  })
}

function App() {
  const ref = useRef()
  const { smallBam, smallCram, largeBam, largeCram, loc } = useQueryParams()

  useEffect(() => {
    if (!ref.current) {
      return
    }
    var options = {
      genome: 'volvox',
      locus: loc,
      tracks: [
        smallCram && {
          name: 'volvox-sorted.cram',
          url: 'volvox-sorted.cram',
          indexURL: 'volvox-sorted.cram.crai',
          format: 'cram',
        },

        smallBam && {
          name: 'volvox-sorted.bam',
          url: 'volvox-sorted.bam',
          indexURL: 'volvox-sorted.bam.bai',
          format: 'bam',
        },
        largeCram && {
          name: 'volvox-wgsim.cram',
          url: 'volvox-wgsim.cram',
          indexURL: 'volvox-wgsim.cram.crai',
          format: 'cram',
        },
        largeBam && {
          name: 'volvox-wgsim.bam',
          url: 'volvox-wgsim.bam',
          indexURL: 'volvox-wgsim.bam.bai',
          format: 'bam',
        },
      ].filter(f => !!f),
      reference: {
        id: 'volvox',
        fastaURL: 'volvox.fa',
        indexURL: 'volvox.fa.fai',
      },
    }

    igv.createBrowser(ref.current, options).then(browser => {
      console.log('Created IGV browser')
    })
  }, [largeBam, largeCram, smallBam, smallCram])
  return <div ref={ref} />
}

export default App
