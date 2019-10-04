
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


			NavigationBarButton,
			SegmentedBarButton {

				content-orientation: horizontal;
				content-disposition: center;
				content-arrangement: center;
				height: 30px;
				padding-left: 12px;
				padding-right: 12px;
				width: wrap;

				.image {
					height: wrap;
					width: wrap;
				}

				.label {
					font-size: 17px;
					lines: 1;
					text-color: blue;
					text-alignment: center;
					text-overflow: ellipsis;
				}

				&:pressed {

					.image {
						opacity: 0.5;
					}

					.label {
						opacity: 0.5;
					}
				}

				&:disabled {

					.image {
						image-tint: #9da6a5;
					}

					.label {
						text-color: #9da6a5;
					}
				}
			}

		""";

		self.display.loadStylesheet(stylesheet);

	}

}
