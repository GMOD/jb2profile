export function mean(arr) {
  return sum(arr) / arr.length
}

export function sum(arr) {
  return arr.reduce((a, b) => a + b, 0)
}

export function stddev(arr) {
  return Math.sqrt(sum(arr.map(k => (k - mean(arr)) ** 2)) / arr.length)
}
