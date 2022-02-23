import puppeteer from 'puppeteer'
;(async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()
  console.time('timer')

  // this is the volvox sorted dataset
  await page.goto(process.argv[2])

  await page.waitForFunction(
    () =>
      document.querySelectorAll('[data-testid="pileup-normal"]').length === 2,
    { timeout: 120000 },
  )
  console.timeEnd('timer')

  await browser.close()
})()
