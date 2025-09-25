import SwiftUI

// Activation service provides activation status
final class ActivationService: ObservableObject {
	static var activationWindow: NSWindow?

	private var screenService = ScreenService(
		for: ScreenService.activeScreen()
	)

	@Published var isActive: Bool = false
}
