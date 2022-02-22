import puppeteer from 'puppeteer'
;(async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()
  console.time('volvox-sorted')

  // this is the volvox sorted dataset
  await page.goto('http://localhost:8000')

  await new Promise(resolve => {
    page.on('console', async msg => {
      const msgArgs = msg.args()
      const val = await msgArgs[0].jsonValue()
      if (val === 'DONE') {
        resolve()
      }
    })
  })

  console.timeEnd('volvox-sorted')

  await browser.close()
})()
