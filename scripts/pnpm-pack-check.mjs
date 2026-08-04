#!/usr/bin/env node
import { spawn } from "node:child_process";
import { mkdtemp, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";

const destination = await mkdtemp(join(tmpdir(), "forma-pack-"));

try {
  await new Promise((resolve, reject) => {
    const child = spawn("pnpm", ["pack", "--json", "--pack-destination", destination], {
      stdio: "inherit",
    });

    child.on("exit", (code) => {
      if (code === 0) resolve();
      else reject(new Error(`pnpm pack exited ${code}`));
    });
    child.on("error", reject);
  });
} finally {
  await rm(destination, { recursive: true, force: true });
}
