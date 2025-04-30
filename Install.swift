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

func getProjectDirectories() -> [String] {
  let fileManager = FileManager.default
  let currentPath = fileManager.currentDirectoryPath
  guard let contents = try? fileManager.contentsOfDirectory(atPath: currentPath) else {
    return []
  }
  return contents.filter { name in
    var isDir: ObjCBool = false
    let fullPath = "\(currentPath)/\(name)"
    return fileManager.fileExists(atPath: fullPath, isDirectory: &isDir)
      && isDir.boolValue
      && !ignoredDirectories.contains(name)
  }.sorted()
}

func promptToggleOptions(options: [String]) -> [String] {
  var selected = Set<Int>()
  while true {
    print("\nToggle options (selected marked with [x]):")
    for (i, option) in options.enumerated() {
      let mark = selected.contains(i) ? "[x]" : "[ ]"
      print("\(i+1). \(mark) \(option)")
    }
    print("Enter numbers to toggle (e.g. 1 3 5), or press Enter to finish:")
    guard let input = readLine(), !input.trimmingCharacters(in: .whitespaces).isEmpty else {
      break
    }
    let numbers = input.split(separator: " ").compactMap { Int($0) }
    for n in numbers {
      let idx = n - 1
      if idx >= 0 && idx < options.count {
        if selected.contains(idx) {
          selected.remove(idx)
        } else {
          selected.insert(idx)
        }
      }
    }
  }
  return selected.sorted().map { options[$0] }
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

let projectDirs = getProjectDirectories()
if !projectDirs.isEmpty {
  let selectedDirs = promptToggleOptions(options: projectDirs)
  print("\nSelected directories: \(selectedDirs.joined(separator: ", "))")
}

step("Update Homebrew", command: "brew update")
step("Install from Brewfile", command: "brew bundle")
step("Install npm globals", command: "zsh ./scripts/npm.zsh")
step("Install cargo bins", command: "zsh ./scripts/cargo.zsh")
step("Write macOS Defaults", command: "zsh ./scripts/defaults.zsh")
step("Link Configurations", command: "stow ghostty karabiner neovim ranger starship tig tmux zsh")

print("\r")
print("\r[Setup Complete]")
