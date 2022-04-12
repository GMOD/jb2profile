import puppeteer from 'puppeteer'
import fs from 'fs'
import path from 'path'
;(async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()
  await page.goto(process.argv[2])

  const params = new URL(process.argv[2]).searchParams
  const tracks = params.get('tracks')
  const n = tracks.split(',').length
  const nblocks = 2 * n
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
    nblocks =>
      document.querySelectorAll('[data-testid="pileup-normal"]').length ===
        nblocks &&
      document.querySelectorAll('[data-testid="wiggle-rendering-test"]')
        .length == nblocks,
    { timeout: 120000 },
    nblocks,
  )

  const fps = await page.evaluate(() => {
    let r = 0
    for (let i = 0; i < window.fps.length; i++) {
      r += window.fps[i]
    }
    return r / window.fps.length
  })

  console.log(fps)
  fs.writeFileSync(path.join('results', process.argv[3]), `${fps}`)

  await browser.close()
})()
