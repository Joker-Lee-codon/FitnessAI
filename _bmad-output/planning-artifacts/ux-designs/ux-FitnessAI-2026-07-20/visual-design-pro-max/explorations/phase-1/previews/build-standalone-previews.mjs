import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const directory = path.dirname(fileURLToPath(import.meta.url));
const source = fs.readFileSync(path.join(directory, "preview-board.html"), "utf8");
const definitionsStart = source.indexOf('<svg aria-hidden="true"');
const definitionsEnd = source.indexOf("</svg>", definitionsStart) + "</svg>".length;
const definitions = source.slice(definitionsStart, definitionsEnd);

const starts = {
  a: source.indexOf('<section class="board direction-a"'),
  b: source.indexOf('<section class="board direction-b"'),
  c: source.indexOf('<section class="board direction-c"'),
};
const ends = { a: starts.b, b: starts.c, c: source.indexOf("</main>", starts.c) };

for (const key of ["a", "b", "c"]) {
  const section = source.slice(starts[key], ends[key]);
  const html = `<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <title>FitnessAI · 方向 ${key.toUpperCase()}</title>
  <link rel="stylesheet" href="preview-board.css">
  <style>html,body{margin:0;width:1280px;height:760px;overflow:hidden}.board{transform:scale(.45);transform-origin:0 0}</style>
</head>
<body>${definitions}<main>${section}</main></body>
</html>`;
  fs.writeFileSync(path.join(directory, `standalone-direction-${key}.html`), html);
}
