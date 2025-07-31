#!/usr/bin/env swift

import Foundation

let red = "\u{001B}[0;31m"
let green = "\u{001B}[0;32m"
let yellow = "\u{001B}[0;33m"
let cyan = "\u{001B}[0;36m"
let reset = "\u{001B}[0m"

let checkmark = "\u{2713}"
let cross = "\u{2717}"
let alert = "\u{26A0}"

let ignoredDirectories = [
  ".git", ".gitignore", ".aider", ".termai", ".todo", ".ropeproject", ".gitmodules", ".opencode",
  "scripts", ".jj",
]

func askUser(_ question: String) -> Bool {
  print("\(question) [y/N]: ", terminator: "")
  fflush(stdout)
  
  guard let input = readLine()?.lowercased() else { return false }
  return input == "y" || input == "yes"
}

func step(_ message: String, command: String) {
  let spinners = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧"]
  let queue = DispatchQueue.global(qos: .userInteractive)
  let errorPipe = Pipe()
  let process = Process()

  process.executableURL = URL(filePath: "/bin/bash")
  process.arguments = ["-c", command]
  process.standardOutput = FileHandle(forWritingAtPath: "/dev/null")!
  process.standardError = errorPipe

  var i = 0
  var running = true

  queue.async {
    while running {
      print("\r\(message): \(cyan)\(spinners[i])\(reset)", terminator: "")
      fflush(stdout)
      i = (i + 1) % spinners.count
      Thread.sleep(forTimeInterval: 0.1)
    }
  }

  process.terminationHandler = { result in
    running = false

    if result.terminationStatus == 0 {
      print("\r\(message): \(green)\(checkmark)\(reset)")
    } else {
      print("\r\(message): \(red)\(cross)\(reset)")
      let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
      if let errorOutput = String(data: errorData, encoding: .utf8), !errorOutput.isEmpty {
        print("\(red)\(alert) \(errorOutput)")
      }
    }
  }

  try? process.run()
  process.waitUntilExit()
}

if askUser("Update Homebrew?") {
  step("Update Homebrew", command: "brew update")
}

if askUser("Install from Brewfile?") {
  step("Install from Brewfile", command: "brew bundle")
}

if askUser("Install npm globals?") {
  step("Install npm globals", command: "zsh ./scripts/npm.zsh")
}

if askUser("Install cargo bins?") {
  step("Install cargo bins", command: "zsh ./scripts/cargo.zsh")
}

if askUser("Write macOS Defaults?") {
  step("Write macOS Defaults", command: "zsh ./scripts/defaults.zsh")
}

if askUser("Set API Credentials?") {
  step("Set API Credentials", command: "zsh ./scripts/set-api-keys.zsh")
}

if askUser("Link Configurations?") {
  step("Link Configurations", command: "stow ghostty karabiner neovim ranger starship tig tmux zsh")
}

print("\r")
print("\r[Setup Complete]")
