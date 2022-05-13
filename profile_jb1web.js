import puppeteer from 'puppeteer'
import fs from 'fs'
import { checkFileExistsSync } from './util.js'
;(async () => {
  const timeoutToken = process.argv[3] + '.timeout'
  if (checkFileExistsSync(timeoutToken)) {
    throw new Error('Timed out already')
  }
  // use a wide view because in order to force not only rendering skips/dels
  // from mismatches, a bpperpx
  const browser = await puppeteer.launch({
    args: ['--window-size=2500,980'],
  })

  const page = await browser.newPage()
  await page._client.send('Emulation.clearDeviceMetricsOverride')
  await page.goto(process.argv[2] + '&tracklist=0')

  const params = new URL(process.argv[2]).searchParams
  const tracks = params.get('tracks')
  const n = tracks.split(',').length
  const nblocks = 4 * n
  try {
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
    await page.waitForFunction(
      nblocks => document.querySelectorAll('.canvas-track').length >= nblocks,
      { timeout: 300000 },
      nblocks,
    )

    const fps = await page.evaluate(() => JSON.stringify(window.fps))

    fs.appendFileSync(process.argv[3], fps + '\n')
    fs.appendFileSync(
      process.argv[4],
      JSON.stringify(await page.metrics()) + '\n',
    )
    await page.screenshot({ path: process.argv[3] + '.png' })
  } catch (e) {
    fs.appendFileSync(timeoutToken, '')
  }

  await browser.close()
  process.exit(0)
})()
