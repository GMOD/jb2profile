import fs from 'fs'

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
  return fs.existsSync(filepath)
}
