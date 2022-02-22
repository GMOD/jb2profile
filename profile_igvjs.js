import puppeteer from 'puppeteer'
;(async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()
  console.time('volvox-sorted')
  page.on('console', async msg => {
    const msgArgs = msg.args()
    for (let i = 0; i < msgArgs.length; ++i) {
      console.log(await msgArgs[i].jsonValue())
    }
  })

  // this is the volvox sorted dataset
  await page.goto('http://localhost:3001')

  await page.waitForFunction(
    () => document.querySelectorAll('.igv-canvas').length === 3,
  )
  console.timeEnd('volvox-sorted')

  await browser.close()
})()
