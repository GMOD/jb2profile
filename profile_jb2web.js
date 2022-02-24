import puppeteer from 'puppeteer'
;(async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()
  await page.goto(process.argv[2])

  const params = new URL(process.argv[2]).searchParams
  const tracks = params.get('tracks')
  const n = tracks.split(',').length
  const nblocks = 2 * n
  await page.waitForFunction(
    nblocks =>
      document.querySelectorAll('[data-testid="pileup-normal"]').length ===
        nblocks &&
      document.querySelectorAll('[data-testid="wiggle-rendering-test"]')
        .length == nblocks,
    { timeout: 120000 },
    nblocks,
  )

  await browser.close()
})()
