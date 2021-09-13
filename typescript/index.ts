import fs from 'fs';
import { performance } from 'perf_hooks';

const data = fs.readFileSync("../img.raw");

const dataCopy: Buffer = Buffer.alloc(data.length);

const start = performance.now();

for (let i = 0; i < data.length; i += 3) {
  const r = data[i];
  const g = data[i + 1];
  const b = data[i + 2];

  dataCopy[i] = r;
  dataCopy[i + 1] = g;
  dataCopy[i + 2] = b;
}

const stop = performance.now();

console.log(`took ${stop - start}ms`);

fs.writeFileSync("./img_ts.raw", dataCopy);