import puppeteer from 'puppeteer'
import fs from 'fs'
import { checkFileExistsSync } from './util.js'
;(async () => {
  const timeoutToken = process.argv[3] + '.timeout'
  if (checkFileExistsSync(timeoutToken)) {
    throw new Error('Timed out already')
  }
  const browser = await puppeteer.launch()
  const page = await browser.newPage()

  await page._client.send('Performance.enable')
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

  try {
    await new Promise((resolve, reject) => {
      let i = 0
      page.on('console', async msg => {
        setTimeout(() => {
          reject()
        }, 300000)
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

    fs.appendFileSync(process.argv[3], fps + '\n')
    fs.appendFileSync(
      process.argv[4],
      JSON.stringify(await page.metrics(), null, 2) + '\n',
    )
    await page.screenshot({ path: process.argv[3] + '.png' })
  } catch (e) {
    fs.appendFileSync(timeoutToken, '')
  }

  await browser.close()
  process.exit(0)
})()
