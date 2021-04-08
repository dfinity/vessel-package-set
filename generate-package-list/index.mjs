import handlebars from "handlebars";
import { readFile, writeFile } from "fs/promises";
import read_stdin from "async-stdin-read";

const run = async () => {
    const packages = JSON.parse(await read_stdin());
    let template = await readFile("template.hbs", "utf-8");
    let compiledTemplate = handlebars.compile(template, { strict: true });
    let version = process.argv.length > 1 ? process.argv[2] : "No version";
    let output = compiledTemplate({ version, packages });
    await writeFile("dist/index.html", output);
    console.log("Written index.html");
};

run()
