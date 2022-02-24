import puppeteer from 'puppeteer'
;(async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()

  await page.goto(process.argv[2])

  const url = new URL(process.argv[2])
  const tracks = url.searchParams.get('tracks')
  const n = tracks.split(',').length

  await new Promise(resolve => {
    let i = 0
    page.on('console', async msg => {
      const msgArgs = msg.args()
      const val = await msgArgs[0].jsonValue()
      if (val === 'DONE') {
        i++
      }
      if (i == n) {
        resolve()
      }
    })
  })

  await browser.close()
})()
