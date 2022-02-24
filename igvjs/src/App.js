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
  const { tracks, loc } = useQueryParams()
  const trackIds = tracks.split(',')

  useEffect(() => {
    if (!ref.current) {
      return
    }
    const trackIds = tracks.split(',').filter(f => !!f)
    var options = {
      genome: 'volvox',
      locus: loc,
      tracks: trackIds.map(trackId => ({
        name: trackId,
        url: trackId,
        indexURL: trackId.endsWith('.bam')
          ? trackId + '.bai'
          : trackId + '.crai',
        format: trackId.endsWith('.cram') ? 'cram' : 'bam',
      })),
      reference: {
        id: 'volvox',
        fastaURL: 'volvox.fa',
        indexURL: 'volvox.fa.fai',
      },
    }

    igv.createBrowser(ref.current, options).then(browser => {
      console.log('Created IGV browser')
    })
  }, [tracks, loc])
  return <div ref={ref} />
}

export default App
