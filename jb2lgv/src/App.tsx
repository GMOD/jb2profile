import { useState, useEffect } from 'react'
import 'fontsource-roboto'
import {
  createViewState,
  JBrowseLinearGenomeView,
} from '@jbrowse/react-linear-genome-view'

function useQueryParams() {
  const params = new URLSearchParams(window ? window.location.search : {})

  return new Proxy(params, {
    get(target, prop) {
      return target.get(prop as string) as string
    },
  })
}
type ViewModel = ReturnType<typeof createViewState>
function View() {
  //@ts-ignore
  const { trackId, loc } = useQueryParams()
  const [viewState, setViewState] = useState<ViewModel>()

  useEffect(() => {
    const defaultSession = trackId && {
      name: 'this session',
      view: {
        id: 'linearGenomeView',
        type: 'LinearGenomeView',
        tracks: [
          {
            id: 'KHwe41KXk',
            type: 'AlignmentsTrack',
            configuration: trackId,
            displays: [
              {
                id: '_-kwYVczT8',
                type: 'LinearAlignmentsDisplay',
                configuration: trackId + '_linearalignments',
                height: 250,
              },
            ],
          },
        ],
      },
    }
    const state = createViewState({
      assembly: {
        name: 'volvox',
        sequence: {
          type: 'ReferenceSequenceTrack',
          trackId: 'volvox-ReferenceSequenceTrack',
          adapter: {
            type: 'IndexedFastaAdapter',
            fastaLocation: {
              uri: 'volvox.fa',
            },
            faiLocation: {
              uri: 'volvox.fa.fai',
            },
          },
        },
      },
      tracks: [
        {
          type: 'AlignmentsTrack',
          trackId: 'volvox-wgsim.bam',
          name: 'volvox-wgsim.bam',
          adapter: {
            type: 'BamAdapter',
            bamLocation: {
              uri: 'volvox-wgsim.bam',
            },
            index: {
              location: {
                uri: 'volvox-wgsim.bam.bai',
              },
              indexType: 'BAI',
            },
            sequenceAdapter: {
              type: 'IndexedFastaAdapter',
              fastaLocation: {
                uri: 'volvox.fa',
              },
              faiLocation: {
                uri: 'volvox.fa.fai',
              },
            },
          },
          assemblyNames: ['volvox'],
        },
        {
          type: 'AlignmentsTrack',
          trackId: 'volvox-wgsim.cram',
          name: 'volvox-wgsim.cram',
          adapter: {
            type: 'CramAdapter',
            cramLocation: {
              uri: 'volvox-wgsim.cram',
            },
            craiLocation: {
              uri: 'volvox-wgsim.cram.crai',
            },
            sequenceAdapter: {
              type: 'IndexedFastaAdapter',
              fastaLocation: {
                uri: 'volvox.fa',
              },
              faiLocation: {
                uri: 'volvox.fa.fai',
              },
            },
          },
          assemblyNames: ['volvox'],
        },
        {
          type: 'AlignmentsTrack',
          trackId: 'volvox-sorted.bam',
          name: 'volvox-sorted.bam',
          adapter: {
            type: 'BamAdapter',
            bamLocation: {
              uri: 'volvox-sorted.bam',
            },
            index: {
              location: {
                uri: 'volvox-sorted.bam.bai',
              },
              indexType: 'BAI',
            },
            sequenceAdapter: {
              type: 'IndexedFastaAdapter',
              fastaLocation: {
                uri: 'volvox.fa',
              },
              faiLocation: {
                uri: 'volvox.fa.fai',
              },
            },
          },
          assemblyNames: ['volvox'],
        },
        {
          type: 'AlignmentsTrack',
          trackId: 'volvox-sorted.cram',
          name: 'volvox-sorted.cram',
          adapter: {
            type: 'CramAdapter',
            cramLocation: {
              uri: 'volvox-sorted.cram',
            },
            craiLocation: {
              uri: 'volvox-sorted.cram.crai',
            },
            sequenceAdapter: {
              type: 'IndexedFastaAdapter',
              fastaLocation: {
                uri: 'volvox.fa',
              },
              faiLocation: {
                uri: 'volvox.fa.fai',
              },
            },
          },
          assemblyNames: ['volvox'],
        },
      ],
      location: loc,
      defaultSession,
    })
    setViewState(state)
  }, [trackId, loc])

  if (!viewState) {
    return null
  }

  return <JBrowseLinearGenomeView viewState={viewState} />
}

export default View
