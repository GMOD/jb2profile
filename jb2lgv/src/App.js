import { useRef, useEffect } from 'react'
// import igv from 'igv'
import igv from 'igv'

function App() {
  const ref = useRef()
  useEffect(() => {
    if (!ref.current) {
      return
    }
    var options = {
      genome: 'volvox',
      locus: 'ctgA:19,176-29,416',
      tracks: [
        {
          name: 'volvox-sorted.cram',
          url: 'volvox-sorted.cram',
          indexURL: 'volvox-sorted.cram.crai',
          format: 'cram',
        },
      ],
      reference: {
        id: 'volvox',
        fastaURL: 'volvox.fa',
        indexURL: 'volvox.fa.fai',
      },
    }

    igv.createBrowser(ref.current, options).then(function (browser) {
      console.log('Created IGV browser')
    })
  }, [])
  return <div ref={ref} />
}

export default App
