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

func step(_ message: String, command: String) {
  let spinners = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧"]
  var i = 0
  var running = true

  let queue = DispatchQueue.global(qos: .userInteractive)
  let errorPipe = Pipe()
  let process = Process()

  process.executableURL = URL(filePath: "/bin/bash")
  process.arguments = ["-c", command]
  process.standardOutput = FileHandle(forWritingAtPath: "/dev/null")!
  process.standardError = errorPipe

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

step("Update homebrew", command: "brew update")
step("Install from Brewfile", command: "brew bundle")

step(
  "Enable key repeat on hold",
  command: "defaults write -g ApplePressAndHoldEnabled -bool false")

let hideDelay = "defaults write com.apple.dock autohide-delay -int 0"
let hideTime = "defaults write com.apple.dock autohide-time-modifier -float 0.2"
step("Remove dock reveal delay", command: hideDelay + " && " + hideTime)
