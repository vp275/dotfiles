import Cocoa

atexit {
    log("exiting")
}

let logURL = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent("Library/Logs/ducky-f8-aerospace-listener.log")
let aerospaceTogglePath = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent(".local/bin/aerospace-toggle-enabled").path
let protonVPNTogglePath = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent(".local/bin/protonvpn-app-toggle").path

var lastAeroSpaceTrigger = CFAbsoluteTimeGetCurrent() - 10
var lastProtonVPNTrigger = CFAbsoluteTimeGetCurrent() - 10
var listenOnly = false

func log(_ message: String) {
    let line = "\(Date()) \(message)\n"
    if let data = line.data(using: .utf8) {
        if FileManager.default.fileExists(atPath: logURL.path),
           let handle = try? FileHandle(forWritingTo: logURL) {
            defer { try? handle.close() }
            _ = try? handle.seekToEnd()
            _ = try? handle.write(contentsOf: data)
        } else {
            _ = try? data.write(to: logURL)
        }
    }
}

func toggleAeroSpace(reason: String) {
    let now = CFAbsoluteTimeGetCurrent()
    guard now - lastAeroSpaceTrigger > 0.7 else { return }
    lastAeroSpaceTrigger = now

    log("toggle reason=\(reason)")

    let process = Process()
    process.executableURL = URL(fileURLWithPath: aerospaceTogglePath)
    try? process.run()
}

func toggleProtonVPN(reason: String) {
    let now = CFAbsoluteTimeGetCurrent()
    guard now - lastProtonVPNTrigger > 0.7 else { return }
    lastProtonVPNTrigger = now

    log("toggle protonvpn reason=\(reason)")

    let process = Process()
    process.executableURL = URL(fileURLWithPath: protonVPNTogglePath)
    try? process.run()
}

let callback: CGEventTapCallBack = { _, type, event, _ in
    if type == .tapDisabledByTimeout || type == .tapDisabledByUserInput {
        log("event tap disabled")
        return Unmanaged.passUnretained(event)
    }

    let keyCode = event.getIntegerValueField(.keyboardEventKeycode)
    guard type == .keyDown else {
        return Unmanaged.passUnretained(event)
    }
    let isAutorepeat = event.getIntegerValueField(.keyboardEventAutorepeat) != 0

    let directF4 = keyCode == 118
    let directF8OrF18 = keyCode == 100 || keyCode == 79

    if directF4 {
        if !isAutorepeat {
            toggleProtonVPN(reason: "keyCode=\(keyCode)")
        }
        return listenOnly ? Unmanaged.passUnretained(event) : nil
    } else if directF8OrF18 {
        if !isAutorepeat {
            toggleAeroSpace(reason: "keyCode=\(keyCode)")
        }
        return listenOnly ? Unmanaged.passUnretained(event) : nil
    }

    return Unmanaged.passUnretained(event)
}

func makeTap(options: CGEventTapOptions) -> CFMachPort? {
    let mask = (1 << CGEventType.keyDown.rawValue) |
        (1 << CGEventType.flagsChanged.rawValue) |
        (1 << CGEventType.tapDisabledByTimeout.rawValue) |
        (1 << CGEventType.tapDisabledByUserInput.rawValue)

    return CGEvent.tapCreate(
        tap: .cgSessionEventTap,
        place: .headInsertEventTap,
        options: options,
        eventsOfInterest: CGEventMask(mask),
        callback: callback,
        userInfo: nil
    )
}

let tap: CFMachPort
if let activeTap = makeTap(options: .defaultTap) {
    tap = activeTap
    log("started active event tap")
} else if let passiveTap = makeTap(options: .listenOnly) {
    tap = passiveTap
    listenOnly = true
    log("started listen-only event tap")
} else {
    log("failed to create event tap")
    exit(1)
}

let source = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
CFRunLoopAddSource(CFRunLoopGetCurrent(), source, .commonModes)
CGEvent.tapEnable(tap: tap, enable: true)
CFRunLoopRun()
