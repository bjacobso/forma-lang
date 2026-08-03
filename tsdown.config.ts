import { readFileSync } from "node:fs";
import { basename, resolve } from "node:path";
import { defineConfig, type UserConfig } from "tsdown";

type PackageJson = {
  name?: string;
};

const cwd = process.cwd();
const pkg = JSON.parse(readFileSync(resolve(cwd, "package.json"), "utf8")) as PackageJson;
const packageName = pkg.name ?? basename(cwd);

const packageEntries: Record<string, UserConfig["entry"]> = {
  "@forma/ts": ["src/*.ts"],
  "@forma/host": ["src/*.ts"],
};

export default defineConfig({
  name: packageName,
  cwd,
  entry: packageEntries[packageName] ?? ["src/index.ts"],
  root: "src",
  format: "esm",
  dts: true,
  clean: true,
  platform: "node",
  target: "esnext",
  fixedExtension: packageName === "@forma/ts" || packageName === "@forma/host",
  unbundle: true,
});
