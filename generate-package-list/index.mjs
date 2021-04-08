import handlebars from "handlebars";
import { readFile, writeFile } from "fs/promises";
import read_stdin from "async-stdin-read";

const run = async () => {
  const packages = JSON.parse(await read_stdin());
  const template = await readFile("template.hbs", "utf-8");
  const compiledTemplate = handlebars.compile(template, { strict: true });
  const version = process.argv.length > 2 ? process.argv[2] : "<Untagged Set>";
  const output = compiledTemplate({ version, packages });
  await writeFile("dist/index.html", output);
  console.log("Wrote dist/index.html");
};

run();
