import SwiftUI

class ScreenService {
	var width: CGFloat = 0
	var height: CGFloat = 0

	// Returns active screen
	static func activeScreen() -> NSScreen? {
		// TODO: Support multiple screens
		NSScreen.main
	}

	init(for screen: NSScreen?) {
		guard let screen else { return }

		self.width = screen.frame.width
		self.height = screen.frame.height
	}
}
