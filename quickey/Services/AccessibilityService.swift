import SwiftUI

// Defines methods and published properties over Accessibility settings
final class AccessibilityService: ObservableObject {
	// Boolean value, resolving trust status
	@Published var isTrusted = AXIsProcessTrusted()

	// Polls and sets trust status
	func pollTrustStatus() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.isTrusted = AXIsProcessTrusted()

			// Perform recursion
			if !self.isTrusted {
				self.pollTrustStatus()
			}
		}
	}

	// Requests Accessibility permissions
	static func requestAccessibilityPermissions() {
		let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
		_ = AXIsProcessTrustedWithOptions(options)
	}
}
