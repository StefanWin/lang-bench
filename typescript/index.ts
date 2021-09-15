import fs from 'fs';
import { performance } from 'perf_hooks';

const _clamp_byte = (x: number) => x > 255 ? 255 : x;

const plain_copy = (src: Buffer): Buffer => {
  const dst: Buffer = Buffer.alloc(src.length);
  for (let i = 0; i < src.length; i += 3) {
    src[i] = src[i];
    src[i + 1] = src[i + 1];
    src[i + 2] = src[i + 2];
  }
  return dst;
}

const avg_gray = (src: Buffer): Buffer => {
  const dst: Buffer = Buffer.alloc(src.length);
  for (let i = 0; i < src.length; i += 3) {
    let sum = src[i] + src[i + 1] + src[i + 2];
    const avg = _clamp_byte(sum) / 3;
    dst[i] = avg;
    dst[i + 1] = avg;
    dst[i + 2] = avg;
  }
  return dst;
}

const perc_gray = (src: Buffer): Buffer => {
  const dst: Buffer = Buffer.alloc(src.length);
  for (let i = 0; i < src.length; i += 3) {
    const r  = src[i + 0] * 0.2126;
    const g  = src[i + 1] * 0.7152;
    const b  = src[i + 2] * 0.0722;
    const val = _clamp_byte(r + g + b);
    dst[i] = val;
    dst[i+1] = val;
    dst[i+2] = val;
  }
  return dst;
}

let alg = process.argv[2] ?? "copy";

let func: (buf: Buffer) => Buffer;

switch (alg) {
  case "copy":
    func = plain_copy;
    break;
  case "avg_gray":
    func = avg_gray;
    break;
  case "perc_gray":
    func = perc_gray;
    break;
  default:
    func = plain_copy;
    break;
}

const data = fs.readFileSync("../img.raw");
const start = performance.now();
const result = func(data);
const stop = performance.now();

console.log(`${alg} took ${stop - start}ms`);
fs.writeFileSync(`./img_ts_${alg}.raw`, result);