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

function getBamAdapter(trackId: string, sequenceAdapter: any) {
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
    sequenceAdapter,
  }
}

function getAssembly(assembly: string) {
  if (assembly === 'volvox') {
    return {
      name: 'volvox',
      sequence: {
        type: 'ReferenceSequenceTrack',
        trackId: 'volvox_refseq',
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
    }
  } else if (assembly === 'hg19') {
    return {
      name: 'hg19',
      aliases: ['GRCh37'],
      sequence: {
        type: 'ReferenceSequenceTrack',
        trackId: 'Pd8Wh30ei9R',
        adapter: {
          type: 'IndexedFastaAdapter',
          fastaLocation: {
            uri: 'https://jbrowse.org/genomes/hg19/fasta/hg19.fa.gz',
            locationType: 'UriLocation',
          },
          faiLocation: {
            uri: 'https://jbrowse.org/genomes/hg19/fasta/hg19.fa.gz.fai',
            locationType: 'UriLocation',
          },
        },
      },
    }
  }
  throw new Error('unknown asm')
}

function getCramAdapter(trackId: string, sequenceAdapter: any) {
  return {
    type: 'CramAdapter',
    cramLocation: {
      uri: trackId,
    },
    craiLocation: {
      uri: trackId + '.crai',
    },
    sequenceAdapter,
  }
}
type ViewModel = ReturnType<typeof createViewState>
function View() {
  //@ts-ignore
  const { tracks, loc, assembly } = useQueryParams()
  const [viewState, setViewState] = useState<ViewModel>()

  useEffect(() => {
    const trackIds = (tracks || '')
      .split(',')
      .filter((f: string) => !!f) as string[]

    const assemblyConf = getAssembly(assembly)
    const defaultSession =
      trackIds.length === 0
        ? undefined
        : {
            name: 'this session',
            view: {
              id: 'linearGenomeView',
              type: 'LinearGenomeView',
              tracks: trackIds.map((trackId) => ({
                id: '' + Math.random(),
                type: 'AlignmentsTrack',
                configuration: trackId,
                displays: [
                  {
                    id: '' + Math.random(),
                    type: 'LinearAlignmentsDisplay',
                    configuration: trackId + '-LinearAlignmentsDisplay',
                    height: 250,
                  },
                ],
              })),
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
      tracks: trackIds.map((trackId) => ({
        type: 'AlignmentsTrack',
        trackId,
        name: trackId,
        adapter: trackId.endsWith('.bam')
          ? getBamAdapter(trackId, assemblyConf.sequence.adapter)
          : getCramAdapter(trackId, assemblyConf.sequence.adapter),
        assemblyNames: ['volvox'],
      })),
      location: loc,
      defaultSession,
    })
    setViewState(state)
  }, [tracks, loc])

  if (!viewState) {
    return null
  }

  return <JBrowseLinearGenomeView viewState={viewState} />
}

export default View
