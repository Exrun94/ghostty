import Foundation
import Cocoa

enum QuickTerminalSpaceBehavior {
    case remain
    case move

    init?(fromGhosttyConfig string: String) {
        switch string {
        case "move":
            self = .move

        case "remain":
            self = .remain

        default:
            return nil
        }
    }

    var collectionBehavior: NSWindow.CollectionBehavior {
        let commonBehavior: [NSWindow.CollectionBehavior] = [
            .ignoresCycle,
            .fullScreenAuxiliary
        ]

        switch self {
        case .move:
            // Follow the active space: when the quick terminal is shown,
            // macOS relocates the window to whichever space is currently active.
            return NSWindow.CollectionBehavior([.moveToActiveSpace] + commonBehavior)
        case .remain:
            // Stay in the space where the window was originally created.
            // We intentionally do NOT set .canJoinAllSpaces or
            // .moveToActiveSpace here so the window stays put.
            return NSWindow.CollectionBehavior(commonBehavior)
        }
    }
}
