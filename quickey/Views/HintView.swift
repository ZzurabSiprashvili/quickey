import SwiftUI

// Represents a view that provides hints or tips to the user.
public struct HintView: View {
	private var screenService = ScreenService(for: ScreenService.activeScreen())

	public var body: some View {
		VStack {
			Text("Hello")
		}
		.frame(width: screenService.width, height: screenService.height)
		.background(.black.opacity(0.1))
	}
}
