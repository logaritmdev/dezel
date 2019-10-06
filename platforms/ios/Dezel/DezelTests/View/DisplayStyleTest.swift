
import XCTest

@testable import Dezel

class DisplayNodeStyleTest: XCTestCase {

	var display: Display!

	var window: DisplayNode!

	override func setUp() {

		super.setUp()

		self.display = Display()
		self.display.viewportWidth = 320
		self.display.viewportHeight = 480
	}

}
