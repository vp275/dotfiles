import CoreGraphics
import Foundation

private let controlKey: CGKeyCode = 59
private let tabKey: CGKeyCode = 48
private let source = CGEventSource(stateID: .hidSystemState)

guard CGPreflightPostEventAccess() else {
    fputs("btt-codex-key-event: missing event-posting permission\n", stderr)
    exit(77)
}

private func postKey(_ key: CGKeyCode, down: Bool, flags: CGEventFlags) {
    guard let event = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: down) else {
        exit(2)
    }

    event.flags = flags
    event.post(tap: .cghidEventTap)
}

private func tapTabWithControl() {
    postKey(tabKey, down: true, flags: .maskControl)
    usleep(20_000)
    postKey(tabKey, down: false, flags: .maskControl)
}

private func clickCurrentPointerPosition() {
    guard let locationEvent = CGEvent(source: source) else {
        exit(2)
    }

    let location = locationEvent.location
    guard
        let mouseDown = CGEvent(
            mouseEventSource: source,
            mouseType: .leftMouseDown,
            mouseCursorPosition: location,
            mouseButton: .left
        ),
        let mouseUp = CGEvent(
            mouseEventSource: source,
            mouseType: .leftMouseUp,
            mouseCursorPosition: location,
            mouseButton: .left
        )
    else {
        exit(2)
    }

    mouseDown.flags = []
    mouseUp.flags = []
    mouseDown.post(tap: .cghidEventTap)
    usleep(1_000)
    mouseUp.post(tap: .cghidEventTap)
}

let command = CommandLine.arguments.dropFirst().first

switch command {
case "control-down":
    postKey(controlKey, down: true, flags: .maskControl)
case "control-up":
    postKey(controlKey, down: false, flags: [])
case "tab-with-control":
    tapTabWithControl()
case "click-current-position":
    clickCurrentPointerPosition()
default:
    fputs("usage: btt-codex-key-event control-down|control-up|tab-with-control|click-current-position\n", stderr)
    exit(64)
}
