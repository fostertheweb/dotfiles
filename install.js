#!/usr/bin/env bun

import { $ } from "bun";
import { readdir, lstat, readlink } from "fs/promises";
import { resolve, join, dirname } from "path";

const colors = {
  red: "\u{001B}[0;31m",
  green: "\u{001B}[0;32m",
  yellow: "\u{001B}[0;33m",
  cyan: "\u{001B}[0;36m",
  reset: "\u{001B}[0m"
};

const symbols = {
  checkmark: "\u{2713}",
  cross: "\u{2717}",
  alert: "\u{26A0}",
  linked: "✓",
  notLinked: "○"
};

const ignoredDirectories = [
  ".git", ".gitignore", ".aider", ".termai", ".todo", ".ropeproject", 
  ".gitmodules", ".opencode", "scripts", ".jj"
];

function askUser(question) {
  return new Promise((resolve) => {
    process.stdout.write(`${question} [y/N]: `);
    
    process.stdin.setRawMode(true);
    process.stdin.resume();
    process.stdin.setEncoding('utf8');
    
    process.stdin.once('data', (key) => {
      process.stdin.setRawMode(false);
      process.stdin.pause();
      
      const answer = key.toString().toLowerCase().trim();
      console.log(answer);
      resolve(answer === 'y' || answer === 'yes');
    });
  });
}

async function getStowPackages() {
  try {
    const entries = await readdir(".", { withFileTypes: true });
    
    return entries
      .filter(entry => entry.isDirectory())
      .map(entry => entry.name)
      .filter(name => !ignoredDirectories.includes(name))
      .filter(name => !name.startsWith('.'));
  } catch (error) {
    console.error(`${colors.red}${symbols.alert} Error reading directories: ${error.message}${colors.reset}`);
    return [];
  }
}

async function isStowed(packageName) {
  try {
    const packageDir = join(process.cwd(), packageName);
    const homeDir = process.env.HOME;
    
    const entries = await readdir(packageDir, { recursive: true, withFileTypes: true });
    
    for (const entry of entries) {
      if (entry.isFile()) {
        const relativePath = entry.path.replace(packageDir, '');
        const fileName = entry.name;
        const fullRelativePath = join(relativePath, fileName).replace(/^\//, '');
        
        const sourcePath = join(packageDir, fullRelativePath);
        const targetPath = join(homeDir, fullRelativePath);
        
        try {
          const linkTarget = await readlink(targetPath);
          const resolvedTarget = resolve(dirname(targetPath), linkTarget);
          
          if (resolvedTarget === sourcePath) {
            return true;
          }
        } catch {
          continue;
        }
      }
    }
    
    return false;
  } catch (error) {
    return false;
  }
}

async function getStowStatus() {
  const packages = await getStowPackages();
  const status = {};
  
  for (const pkg of packages) {
    status[pkg] = await isStowed(pkg);
  }
  
  return status;
}

async function step(message, command) {
  const spinners = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧"];
  let i = 0;
  let spinning = true;
  
  const spinnerInterval = setInterval(() => {
    if (spinning) {
      process.stdout.write(`\r${message}: ${colors.cyan}${spinners[i]}${colors.reset}`);
      i = (i + 1) % spinners.length;
    }
  }, 100);
  
  try {
    const result = await $`${command}`.quiet();
    spinning = false;
    clearInterval(spinnerInterval);
    
    if (result.exitCode === 0) {
      console.log(`\r${message}: ${colors.green}${symbols.checkmark}${colors.reset}`);
    } else {
      console.log(`\r${message}: ${colors.red}${symbols.cross}${colors.reset}`);
      if (result.stderr) {
        console.log(`${colors.red}${symbols.alert} ${result.stderr}${colors.reset}`);
      }
    }
  } catch (error) {
    spinning = false;
    clearInterval(spinnerInterval);
    console.log(`\r${message}: ${colors.red}${symbols.cross}${colors.reset}`);
    console.log(`${colors.red}${symbols.alert} ${error.message}${colors.reset}`);
  }
}

async function main() {
  console.log(`${colors.cyan}Dotfiles Setup${colors.reset}`);
  console.log("================");
  
  // Show current stow status
  console.log("\nCurrent Configuration Status:");
  const stowStatus = await getStowStatus();
  for (const [pkg, isLinked] of Object.entries(stowStatus)) {
    const status = isLinked ? `${colors.green}${symbols.linked} linked${colors.reset}` : `${colors.yellow}${symbols.notLinked} not linked${colors.reset}`;
    console.log(`  ${pkg}: ${status}`);
  }
  console.log("");
  
  if (await askUser("Update Homebrew?")) {
    await step("Update Homebrew", "brew update");
  }
  
  if (await askUser("Install from Brewfile?")) {
    await step("Install from Brewfile", "brew bundle");
  }
  
  if (await askUser("Install npm globals?")) {
    await step("Install npm globals", "zsh ./scripts/npm.zsh");
  }
  
  if (await askUser("Install cargo bins?")) {
    await step("Install cargo bins", "zsh ./scripts/cargo.zsh");
  }
  
  if (await askUser("Install python packages?")) {
    await step("Install python packages", "zsh ./scripts/pip.zsh");
  }
  
  if (await askUser("Write macOS Defaults?")) {
    await step("Write macOS Defaults", "zsh ./scripts/defaults.zsh");
  }
  
  if (await askUser("Set API Credentials?")) {
    await step("Set API Credentials", "zsh ./scripts/set-api-keys.zsh");
  }
  
  if (await askUser("Link Configurations?")) {
    const packages = await getStowPackages();
    const packageList = packages.join(' ');
    await step("Link Configurations", `stow ${packageList}`);
  }
  
  console.log("\n[Setup Complete]");
  process.exit(0);
}

main().catch(console.error);