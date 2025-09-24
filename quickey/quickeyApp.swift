import SwiftUI

@main
struct QuickeyApp: App {
	@StateObject private var accessibilityService = AccessibilityService()

	@NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

	var body: some Scene {
		// Menu bar extra for the application with an icon
		// TODO: Replace "keyboard" with a better icon
		MenuBarExtra("qk", systemImage: "keyboard") {
			MenuBarView()
		}

		// A window for displaying hints
		// Note: This is conditionally rendered based on activation state
		Window("Hint", id: "hint") {
			HintView()
		}
	}
}
