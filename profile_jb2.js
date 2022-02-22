import puppeteer from 'puppeteer'
;(async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()
  console.time('volvox-sorted')

  // this is the volvox sorted dataset
  await page.goto(
    'http://localhost:3000/?config=test_data%2Fvolvox%2Fconfig.json&session=encoded-eJylVe9v2jAQ_VeQP6dbEn605BvrqpWt69hA7bSpQia5BGuOk9kOBBD_-y52GigtbOqkfPHZ9-7d8_NlQ1hEArKIBhkrC7dDHCJoChgaCg2JpJploqVB6RaUNM05tPy3Pn6u7zstL2j3gnanNfqMeSmVCRMkcB0SSboEec8iPSdB-6LjkAWDpSLBz42tx3bg0woc0_Uqr8reMAFUfgCRpXCHSbiTxbECPSpJ4F-0PYfM8hHIatl7c37e9vveRd_z--c9t4uVmco5XUH0DRIEtyUlxLe2qVAnA0RUmkptmIJAOl3XdRFXwgKkAgzElCtwCFUK0hlf1cmLjC-ykmwfkKyk4a-9fn5Prr6O5e3Hu10jA84SkYLQalIdxo0wEzFLCtt2gzcNJU2ntDk9RY6UNJ3sFVmc_Rgvve9Rjx_Ktav13mbhgRHjUOSP66DGmLArdV7-TtblIcbT8w6ZA0vmKJLnus-ob06n1tSH0ekmz46Qn-YGb1qu1mSLlzXPluMs1pec5TkTSXM9MeMa5DvTXMxpMhQhLyIw91qtr8p67XU77haRxrejywzvmCZwqEu69osoZH3306EuLyTtxOl0_6bNi-n_K5ASeViDNioBh1BXvhcRSCMTIZWnVcYLy8wzXBV6F58f-mqzfYWGWBr7uT7e_2sa2lPU77r2yh9VI4GWBdiYNZqNbB-qhzhnEVwDxZYbW-xCXxChGjzNlnm2Y6NUJif2muYMy8hwzkJq3lV15IbOgKNCpOLAqbVdTQtpg6z6aFBNeKWzGRWRGoPWRn3L0SFLFiVg5H5SarJPpbHh8RONK6-PHbk3hcyc4cjZDLLNySFjG2hcMIFSW9dY0Z5P6coANNRsAff_1NWJva0xjsAFog_RlVSEUA27h8rLSmF08jhkd6HLJuVpfGAnNTtAGPECf0l1LGWCpWy9N9_tb2qUKVZbVxoPbv8Ar0eBCw',
  )

  await page.waitForFunction(
    () =>
      document.querySelectorAll('[data-testid="pileup-normal"]').length === 2,
  )
  console.timeEnd('volvox-sorted')

  await browser.close()
})()
