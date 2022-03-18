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
  const { tracks, loc, assembly } = useQueryParams()

  useEffect(() => {
    if (!ref.current) {
      return
    }
    var options = {
      genome: assembly,
      locus: loc,
      tracks: tracks
        ?.split(',')
        .filter(f => !!f)
        .map(trackId => ({
          name: trackId,
          url: trackId,
          indexURL: trackId.endsWith('.bam')
            ? trackId + '.bai'
            : trackId + '.crai',
          format: trackId.endsWith('.cram') ? 'cram' : 'bam',
        })),
      reference:
        assembly === 'volvox'
          ? {
              id: 'volvox',
              fastaURL: 'volvox.fa',
              indexURL: 'volvox.fa.fai',
            }
          : undefined,
    }

    igv.createBrowser(ref.current, options).then(browser => {
      console.log('Created IGV browser')
    })
  }, [tracks, loc, assembly])
  return <div ref={ref} />
}

export default App
