import puppeteer from 'puppeteer'
import fs from 'fs'
;(async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()

  await page.goto(process.argv[2])

  const url = new URL(process.argv[2])
  const tracks = url.searchParams.get('tracks')
  const n = tracks.split(',').length
  await page.evaluate(() => {
    window.fps = []

    let LAST_FRAME_TIME = 0
    function measure(TIME) {
      window.fps.push(1 / ((performance.now() - LAST_FRAME_TIME) / 1000))
      LAST_FRAME_TIME = TIME
      window.requestAnimationFrame(measure)
    }
    window.requestAnimationFrame(measure)
  })

  await new Promise(resolve => {
    let i = 0
    page.on('console', async msg => {
      const msgArgs = msg.args()
      const val = await msgArgs[0]?.jsonValue()
      if (val === 'DONE') {
        i++
      }
      if (i == n) {
        resolve()
      }
    })
  })

  const fps = await page.evaluate(() => JSON.stringify(window.fps))

  fs.writeFileSync(process.argv[3], fps)

  await browser.close()
})()
