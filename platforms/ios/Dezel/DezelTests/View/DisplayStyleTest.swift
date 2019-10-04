
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

	func testStylesheet() {

		let stylesheet = """
			NavigationBar {

				content-orientation: horizontal;
				content-disposition: start;
				content-arrangement: center;
				height: 48px + $safe-area-top-inset;
				padding-top: $safe-area-top-inset;
				padding-left: 6px;
				padding-right: 6px;

				.title-container {
					content-orientation: horizontal;
					content-disposition: center;
					content-arrangement: center;
					height: fill;
					shrink: 1;
				}

				.buttons-container {
					content-orientation: horizontal;
					content-disposition: center;
					content-arrangement: center;
					height: fill;
					width: wrap;
				}

				.title {
					left: 0px;
					lines: 1;
					font-size: 17;
					font-weight: 600;
					height: wrap;
					text-color: #000;
					text-alignment: center;
					width: wrap;
				}
			}

		""";

		self.display.loadStylesheet(stylesheet);

	}

}