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

function getBamAdapter(trackId: string) {
  return {
    type: 'BamAdapter',
    bamLocation: {
      uri: trackId,
    },
    index: {
      location: {
        uri: trackId + '.bai',
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
  }
}

function getCramAdapter(trackId: string) {
  return {
    type: 'CramAdapter',
    cramLocation: {
      uri: trackId,
    },
    craiLocation: {
      uri: trackId + '.crai',
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
  }
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
                configuration: trackId + '-LinearAlignmentsDisplay',
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
          trackId,
          name: trackId,
          adapter: trackId.endsWith('.bam')
            ? getBamAdapter(trackId)
            : getCramAdapter(trackId),
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
