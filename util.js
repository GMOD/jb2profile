export function mean(arr) {
  return sum(arr) / arr.length
}

export function sum(arr, cb = n => n) {
  return arr.reduce((a, b) => a + cb(b), 0)
}

export function stddev(arr) {
  return Math.sqrt(sum(arr.map(k => (k - mean(arr)) ** 2)) / arr.length)
}

export function checkFileExistsSync(filepath) {
  let flag = true
  try {
    fs.accessSync(filepath, fs.constants.F_OK)
  } catch (e) {
    flag = false
  }
  return flag
}
