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
  const { trackId, loc } = useQueryParams()

  useEffect(() => {
    if (!ref.current) {
      return
    }
    var options = {
      genome: 'volvox',
      locus: loc,
      tracks: [
        {
          name: trackId,
          url: trackId,
          indexURL: trackId.endsWith('.bam')
            ? trackId + '.bai'
            : trackId + '.crai',
          format: trackId.endsWith('.cram') ? 'cram' : 'bam',
        },
      ],
      reference: {
        id: 'volvox',
        fastaURL: 'volvox.fa',
        indexURL: 'volvox.fa.fai',
      },
    }

    igv.createBrowser(ref.current, options).then(browser => {
      console.log('Created IGV browser')
    })
  }, [trackId, loc])
  return <div ref={ref} />
}

export default App
