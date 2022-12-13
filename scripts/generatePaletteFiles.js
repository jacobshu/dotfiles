import fs from 'fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const __dirname = dirname(fileURLToPath(import.meta.url));
const paletteFile = join(__dirname, "..", "/config/synthwavePalette.json");

const palette = JSON.parse(fs.readFileSync(paletteFile));
console.log(palette);
