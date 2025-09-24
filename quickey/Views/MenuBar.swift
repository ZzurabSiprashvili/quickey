import SwiftUI

// Menu bar component displayed
// This menu bar component usually displays buttons for:
// 1. About the app
// (2) Check for privacy settings -- Conditionally rendered button, when privacy settings are not set
// 2. Preferences
// 3. Quit the app
public struct MenuBarView: View {
	public var body: some View {
		AboutButton {
			Text("About Quickey")
		}.keyboardShortcut("a", modifiers: [.command, .capsLock])

		SettingsButton {
			Text("Settings")
		}.keyboardShortcut(",", modifiers: [.command])

		AccessibilityPermissionButton {
			HStack {
				Image(systemName: "exclamationmark.triangle.fill")
				Text("Allow Accessibility access")
					.foregroundColor(.red)
			}
		}

		Divider()

		QuitButton {
			Text("Quit")
		}.keyboardShortcut("q", modifiers: [.capsLock, .command])
	}
}

// Renders content provided in params
// on click, it opens a window (default about window)
struct AboutButton<Content: View>: View {
	private let content: Content

	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}

	// Opens the standard about window for the app
	private func openAboutWindow() {
		NSApp.orderFrontStandardAboutPanel()
		NSApp.activate(ignoringOtherApps: true)
	}

	var body: some View {
		Button {
			openAboutWindow()
		} label: {
			content
		}
	}
}

// Renders settings button
// On click it opens Settings Window
struct SettingsButton<Content: View>: View {
	@Environment(\.openSettings) var openSettings

	private let content: Content

	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}

	var body: some View {
		Button {
			openSettings()
		} label: {
			content
		}
	}
}

// Renders Accessibility permission button
// On click, it requests accessibility permission + starts polling for accessibilityService to check trust status
struct AccessibilityPermissionButton<Content: View>: View {
	@StateObject private var accessibilityService = AccessibilityService()

	private let content: Content

	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}

	private func setupAccessibilityAccess() {
		AccessibilityService.requestAccessibilityPermissions()
		accessibilityService.pollTrustStatus()
	}

	var body: some View {
		// Renders nothing if app is trusted
		if !accessibilityService.isTrusted {
			Button {
				setupAccessibilityAccess()
			} label: {
				content
			}
		}
	}
}

// Renders Quit button
// On click, it will quit from application
struct QuitButton<Content: View>: View {
	private let content: Content

	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}

	private func quitApp() {
		NSApplication.shared.terminate(nil)
	}

	var body: some View {
		Button {
			quitApp()
		} label: {
			content
		}
	}
}
