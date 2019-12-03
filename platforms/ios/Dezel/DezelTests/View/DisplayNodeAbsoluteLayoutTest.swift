import XCTest

@testable import Dezel

class DisplayNodeAbsoluteLayoutTest: XCTestCase {

	var display: Display!

	var window: DisplayNode!

	override func setUp() {

		super.setUp()

		self.display = Display()
		self.display.viewportWidth = 320
		self.display.viewportHeight = 480

		self.window = DisplayNode(display: self.display)
		self.window.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 320)
		self.window.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 480)
		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 320)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 480)
		self.window.setName("Window")

		self.display.window = self.window
	}

	func testNodePositionInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 10)
		XCTAssertEqual(node.measuredLeft, 20)
		XCTAssertEqual(node.measuredRight, 30)
		XCTAssertEqual(node.measuredBottom, 40)
	}

	func testNodePositionInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPC, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPC, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPC, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodePositionInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitVW, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitVW, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitVW, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 320 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 320 * 0.4)
	}

	func testNodePositionInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitVH, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitVH, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitVH, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodePositionInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPW, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPW, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPW, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 320 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 320 * 0.4)
	}

	func testNodePositionInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPH, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPH, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPH, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodePositionInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitCW, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitCW, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitCW, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitCW, length: 40)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredBottom, 3200 * 0.4)
	}

	func testNodePositionInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitCH, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitCH, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitCH, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitCH, length: 40)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredBottom, 4800 * 0.4)
	}

	func testNodeMarginInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: 40)

		node.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPX, length: 10)
		node.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPX, length: 20)
		node.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPX, length: 30)
		node.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 10)
		XCTAssertEqual(node.measuredMarginLeft, 20)
		XCTAssertEqual(node.measuredMarginRight, 30)
		XCTAssertEqual(node.measuredMarginBottom, 40)

		XCTAssertEqual(node.measuredTop, 10 + 10)
		XCTAssertEqual(node.measuredLeft, 20 + 20)
		XCTAssertEqual(node.measuredRight, 30 + 30)
		XCTAssertEqual(node.measuredBottom, 40 + 40)
	}

	func testNodeMarginInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: 40)

		node.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPC, length: 10)
		node.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPC, length: 20)
		node.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPC, length: 30)
		node.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 480 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 320 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 480 * 0.4)

		XCTAssertEqual(node.measuredTop, 10 + 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 20 + 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 30 + 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 40 + 480 * 0.4)
	}

	func testNodeMarginInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: 40)

		node.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitVW, length: 10)
		node.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitVW, length: 20)
		node.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitVW, length: 30)
		node.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 10 + 320 * 0.1)
		XCTAssertEqual(node.measuredLeft, 20 + 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 30 + 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 40 + 320 * 0.4)

		XCTAssertEqual(node.measuredMarginTop, 320 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 320 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 320 * 0.4)
	}

	func testNodeMarginInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: 30)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: 40)

		node.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitVH, length: 10)
		node.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitVH, length: 20)
		node.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitVH, length: 30)
		node.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 10 + 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 20 + 480 * 0.2)
		XCTAssertEqual(node.measuredRight, 30 + 480 * 0.3)
		XCTAssertEqual(node.measuredBottom, 40 + 480 * 0.4)

		XCTAssertEqual(node.measuredMarginTop, 480 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 480 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 480 * 0.4)
	}

	func testNodeMarginInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPW, length: 10)
		node.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPW, length: 20)
		node.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPW, length: 30)
		node.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 320 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 320 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 320 * 0.4)
	}

	func testNodeMarginInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPH, length: 10)
		node.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPH, length: 20)
		node.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPH, length: 30)
		node.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 480 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 480 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 480 * 0.4)
	}

	func testNodeMarginInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitCW, length: 10)
		node.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitCW, length: 20)
		node.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitCW, length: 30)
		node.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitCW, length: 40)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 3200 * 0.4)
	}

	func testNodeMarginInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitCH, length: 10)
		node.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitCH, length: 20)
		node.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitCH, length: 30)
		node.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitCH, length: 40)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 4800 * 0.4)
	}

	func testNodeWidthInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 100)
	}

	func testNodeWidthInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPC, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitVW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitVH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 480 * 0.5)
	}

	func testNodeWidthInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 480 * 0.5)
	}

	func testNodeWidthInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitCW, length: 50)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 3200 * 0.5)
	}

	func testNodeWidthInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitCH, length: 50)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 4800 * 0.5)
	}

	func testNodeWidthUsingFill() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)
		node.setHeight(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320)
	}

	func testNodeWidthUsingFillAndLeftPosition() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setWidth(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)
		node.setHeight(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 10)
	}

	func testNodeWidthUsingFillAndRightPosition() {

		let node = DisplayNode(display: self.display)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: 30)
		node.setWidth(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)
		node.setHeight(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPX() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 20 - 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPC() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPC, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPC, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - (320 * 0.2) - (320 * 0.3))
	}

	func testNodeWidthUsingLeftAndRightPositionInVW() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitVW, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitVW, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - (320 * 0.2) - (320 * 0.3))
	}

	func testNodeWidthUsingLeftAndRightPositionInVH() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitVH, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitVH, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - (480 * 0.2) - (480 * 0.3))
	}

	func testNodeWidthtShouldBeMeasuredFromLeftAndRightInsteadOfLength() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: 30)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 20 - 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPXIncludingNegativeMargins() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: 30)
		node.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPX, length: -20)
		node.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPX, length: -30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 50 + 50) // 320 - (20 + 30) + (20 + 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPXIncludingPositiveMargins() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: 30)
		node.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPX, length: 20)
		node.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPX, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 50 - 50) // 320 - (20 + 30) - (20 + 30)
	}

	func testNodeHeightInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 100)
	}

	func testNodeHeightInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPC, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 * 0.5)
	}

	func testNodeHeightInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitVW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 320 * 0.5)
	}

	func testNodeHeightInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitVH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 * 0.5)
	}

	func testNodeHeightInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 320 * 0.5)
	}

	func testNodeHeightInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 * 0.5)
	}

	func testNodeHeightInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitCW, length: 50)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 3200 * 0.5)
	}

	func testNodeHeightInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitCH, length: 50)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 4800 * 0.5)
	}

	func testNodeHeightUsingFill() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)
		node.setHeight(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480)
	}

	func testNodeHeightUsingFillAndTopPosition() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setWidth(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)
		node.setHeight(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 10)
	}

	func testNodeHeightUsingFillAndBottomPosition() {

		let node = DisplayNode(display: self.display)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: 40)
		node.setWidth(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)
		node.setHeight(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 10 - 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPC, length: 10)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - (480 * 0.1) - (480 * 0.4))
	}

	func testNodeHeightUsingTopAndBottomPositionInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitVW, length: 10)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - (320 * 0.1) - (320 * 0.4))
	}

	func testNodeHeightUsingTopAndBottomPositionInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitVH, length: 10)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - (480 * 0.1) - (480 * 0.4))
	}

	func testNodeHeightShouldBeMeasuredFromTopAndBottomInsteadOfLength() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: 40)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 150)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 10 - 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPXIncludingNegativeMargins() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: 40)
		node.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPX, length: -10)
		node.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPX, length: -40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 50 + 50) // 480 - (10 + 40) + (10 + 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPXIncludingPositiveMargins() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: 40)
		node.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPX, length: 10)
		node.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 50 - 50) // 480 - (10 + 40) - (10 + 40)
	}

	func testNodeBorderInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 150)

		node.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPX, length: 10)
		node.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPX, length: 20)
		node.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPX, length: 30)
		node.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 10)
		XCTAssertEqual(node.measuredBorderLeft, 20)
		XCTAssertEqual(node.measuredBorderRight, 30)
		XCTAssertEqual(node.measuredBorderBottom, 40)
	}

	func testNodeBorderInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 150)

		node.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPC, length: 10)
		node.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPC, length: 20)
		node.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPC, length: 30)
		node.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 150 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 100 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 100 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 150 * 0.4)
	}

	func testNodeBorderInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 150)

		node.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitVW, length: 10)
		node.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitVW, length: 20)
		node.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitVW, length: 30)
		node.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 320 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 320 * 0.4)
	}

	func testNodeBorderInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 150)

		node.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitVH, length: 10)
		node.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitVH, length: 20)
		node.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitVH, length: 30)
		node.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 480 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 480 * 0.4)
	}

func testNodeBorderInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPW, length: 10)
		node.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPW, length: 20)
		node.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPW, length: 30)
		node.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 320 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 320 * 0.4)
	}

	func testNodeBorderInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPH, length: 10)
		node.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPH, length: 20)
		node.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPH, length: 30)
		node.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 480 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 480 * 0.4)
	}

func testNodeBorderInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitCW, length: 10)
		node.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitCW, length: 20)
		node.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitCW, length: 30)
		node.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitCW, length: 40)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 3200 * 0.4)
	}

	func testNodeBorderInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitCH, length: 10)
		node.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitCH, length: 20)
		node.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitCH, length: 30)
		node.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitCH, length: 40)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 4800 * 0.4)
	}

	func testNodePaddingInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 150)

		node.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 10)
		node.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 20)
		node.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 30)
		node.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 10)
		XCTAssertEqual(node.measuredPaddingLeft, 20)
		XCTAssertEqual(node.measuredPaddingRight, 30)
		XCTAssertEqual(node.measuredPaddingBottom, 40)
	}

	func testNodePaddingInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 150)

		node.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: 10)
		node.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: 20)
		node.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: 30)
		node.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 150 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 100 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 100 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 150 * 0.4)
	}

	func testNodePaddingInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 150)

		node.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: 10)
		node.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: 20)
		node.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: 30)
		node.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 320 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 320 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 320 * 0.4)
	}

	func testNodePaddingInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 150)

		node.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: 10)
		node.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: 20)
		node.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: 30)
		node.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 480 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 480 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 480 * 0.4)
	}


	func testNodePaddingInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: 10)
		node.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: 20)
		node.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: 30)
		node.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 320 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 320 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 320 * 0.4)
	}

	func testNodePaddingInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: 10)
		node.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: 20)
		node.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: 30)
		node.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 480 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 480 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 480 * 0.4)
	}

	func testNodePaddingInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: 10)
		node.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: 20)
		node.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: 30)
		node.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: 40)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 3200 * 0.4)
	}

	func testNodePaddingInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)

		node.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: 10)
		node.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: 20)
		node.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: 30)
		node.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: 40)

		self.window.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 4800 * 0.4)
	}

	func testAnchorInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		node.setAnchorTop(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: 50)
		node.setAnchorLeft(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, -100)
		XCTAssertEqual(node.measuredLeft, -100)
	}

	func testScaling() {

		// TODO: Test other properites
		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPC, length: 33)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPC, length: 33)

		self.display.scale = 2
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 0)
		XCTAssertEqual(node.measuredLeft, 0)
		XCTAssertEqual(node.measuredWidth, 105.5)
		XCTAssertEqual(node.measuredHeight, 158.5)
	}

	func testWrappingFromContentSize() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
container.setName("CONTAINER")
		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
node1.setName("NODE1")
		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
node1.setName("NODE2")
		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200)
		XCTAssertEqual(container.measuredHeight, 400)

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappingFromContentSizeWithMin() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setMinWidth(250)
		container.setMinHeight(450)

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 250)
		XCTAssertEqual(container.measuredHeight, 450)

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappingFromContentSizeWithMax() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setMaxWidth(150)
		container.setMaxHeight(350)

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 150)
		XCTAssertEqual(container.measuredHeight, 350)

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappingFromContentSizeAndPadding() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 10)
		container.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 20)
		container.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 30)
		container.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 40)

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + 20 + 30)
		XCTAssertEqual(container.measuredHeight, 400 + 10 + 40)

		XCTAssertEqual(node1.measuredTop, 10)
		XCTAssertEqual(node1.measuredLeft, 20)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 10)
		XCTAssertEqual(node2.measuredLeft, 20)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappingFromContentSizeAndMargin() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPX, length: 30)
		node1.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPX, length: 20)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPX, length: 50)
		node2.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPX, length: 40)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + 50)
		XCTAssertEqual(container.measuredHeight, 400 + 20 + 40)

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 20)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testNodePositionAndSizeCaching() {

		let counter = DisplayNodeDelegateCounter()

		let node1 = DisplayNode(display: self.display)
		node1.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node1.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.delegate = counter

		let node2 = DisplayNode(display: self.display)
		node2.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node2.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.delegate = counter

		self.window.appendChild(node1)
		self.window.appendChild(node2)
		self.window.resolve()

		XCTAssertEqual(counter.resolvedSize, 2)
		XCTAssertEqual(counter.resolvedOrigin, 2)

		let node3 = DisplayNode(display: self.display)
		node3.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 10)
		node3.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: 20)
		node3.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node3.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node3.delegate = counter

		self.window.appendChild(node3)
		self.window.resolve()

		XCTAssertEqual(counter.resolvedSize, 3)
		XCTAssertEqual(counter.resolvedOrigin, 3)
	}

	func testWrappedNodePaddingInPX() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 20);
		container.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 40);
		container.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 60);
		container.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredPaddingTop, 20)
		XCTAssertEqual(container.measuredPaddingLeft, 40)
		XCTAssertEqual(container.measuredPaddingRight, 60)
		XCTAssertEqual(container.measuredPaddingBottom, 80)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + 40 + 60)
		XCTAssertEqual(container.measuredHeight, 400 + 20 + 80)

		XCTAssertEqual(node1.measuredTop, 20)
		XCTAssertEqual(node1.measuredLeft, 40)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 20)
		XCTAssertEqual(node2.measuredLeft, 40)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodePaddingInPC() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: 20);
		container.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: 40);
		container.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: 60);
		container.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredPaddingTop, 400 * 0.2)
		XCTAssertEqual(container.measuredPaddingLeft, 200 * 0.4)
		XCTAssertEqual(container.measuredPaddingRight, 200 * 0.6)
		XCTAssertEqual(container.measuredPaddingBottom, 400 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (200 * 0.4) + (200 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (400 * 0.2) + (400 * 0.8))

		XCTAssertEqual(node1.measuredTop, 400 * 0.2)
		XCTAssertEqual(node1.measuredLeft, 200 * 0.4)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 400 * 0.2)
		XCTAssertEqual(node2.measuredLeft, 200 * 0.4)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodePaddingInVW() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: 20);
		container.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: 40);
		container.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: 60);
		container.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredPaddingTop, 320 * 0.2)
		XCTAssertEqual(container.measuredPaddingLeft, 320 * 0.4)
		XCTAssertEqual(container.measuredPaddingRight, 320 * 0.6)
		XCTAssertEqual(container.measuredPaddingBottom, 320 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (320 * 0.4) + (320 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (320 * 0.2) + (320 * 0.8))

		XCTAssertEqual(node1.measuredTop, 320 * 0.2)
		XCTAssertEqual(node1.measuredLeft, 320 * 0.4)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 320 * 0.2)
		XCTAssertEqual(node2.measuredLeft, 320 * 0.4)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodePaddingInVH() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: 20);
		container.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: 40);
		container.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: 60);
		container.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredPaddingTop, 480 * 0.2)
		XCTAssertEqual(container.measuredPaddingLeft, 480 * 0.4)
		XCTAssertEqual(container.measuredPaddingRight, 480 * 0.6)
		XCTAssertEqual(container.measuredPaddingBottom, 480 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (480 * 0.4) + (480 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (480 * 0.2) + (480 * 0.8))

		XCTAssertEqual(node1.measuredTop, 480 * 0.2)
		XCTAssertEqual(node1.measuredLeft, 480 * 0.4)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 480 * 0.2)
		XCTAssertEqual(node2.measuredLeft, 480 * 0.4)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodePaddingInPW() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: 20);
		container.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: 40);
		container.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: 60);
		container.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredPaddingTop, 320 * 0.2)
		XCTAssertEqual(container.measuredPaddingLeft, 320 * 0.4)
		XCTAssertEqual(container.measuredPaddingRight, 320 * 0.6)
		XCTAssertEqual(container.measuredPaddingBottom, 320 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (320 * 0.4) + (320 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (320 * 0.2) + (320 * 0.8))

		XCTAssertEqual(node1.measuredTop, 320 * 0.2)
		XCTAssertEqual(node1.measuredLeft, 320 * 0.4)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 320 * 0.2)
		XCTAssertEqual(node2.measuredLeft, 320 * 0.4)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodePaddingInPH() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: 20);
		container.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: 40);
		container.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: 60);
		container.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredPaddingTop, 480 * 0.2)
		XCTAssertEqual(container.measuredPaddingLeft, 480 * 0.4)
		XCTAssertEqual(container.measuredPaddingRight, 480 * 0.6)
		XCTAssertEqual(container.measuredPaddingBottom, 480 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (480 * 0.4) + (480 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (480 * 0.2) + (480 * 0.8))

		XCTAssertEqual(node1.measuredTop, 480 * 0.2)
		XCTAssertEqual(node1.measuredLeft, 480 * 0.4)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 480 * 0.2)
		XCTAssertEqual(node2.measuredLeft, 480 * 0.4)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodePaddingInCW() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: 20);
		container.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: 40);
		container.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: 60);
		container.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredPaddingTop, 320 * 0.2)
		XCTAssertEqual(container.measuredPaddingLeft, 320 * 0.4)
		XCTAssertEqual(container.measuredPaddingRight, 320 * 0.6)
		XCTAssertEqual(container.measuredPaddingBottom, 320 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (320 * 0.4) + (320 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (320 * 0.2) + (320 * 0.8))

		XCTAssertEqual(node1.measuredTop, 320 * 0.2)
		XCTAssertEqual(node1.measuredLeft, 320 * 0.4)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 320 * 0.2)
		XCTAssertEqual(node2.measuredLeft, 320 * 0.4)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodePaddingInCH() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: 20);
		container.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: 40);
		container.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: 60);
		container.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredPaddingTop, 480 * 0.2)
		XCTAssertEqual(container.measuredPaddingLeft, 480 * 0.4)
		XCTAssertEqual(container.measuredPaddingRight, 480 * 0.6)
		XCTAssertEqual(container.measuredPaddingBottom, 480 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (480 * 0.4) + (480 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (480 * 0.2) + (480 * 0.8))

		XCTAssertEqual(node1.measuredTop, 480 * 0.2)
		XCTAssertEqual(node1.measuredLeft, 480 * 0.4)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 480 * 0.2)
		XCTAssertEqual(node2.measuredLeft, 480 * 0.4)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodeBorderInPX() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPX, length: 20);
		container.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPX, length: 40);
		container.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPX, length: 60);
		container.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPX, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredBorderTop, 20)
		XCTAssertEqual(container.measuredBorderLeft, 40)
		XCTAssertEqual(container.measuredBorderRight, 60)
		XCTAssertEqual(container.measuredBorderBottom, 80)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + 40 + 60)
		XCTAssertEqual(container.measuredHeight, 400 + 20 + 80)

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodeBorderInPC() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPC, length: 20);
		container.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPC, length: 40);
		container.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPC, length: 60);
		container.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPC, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredBorderTop, 400 * 0.2)
		XCTAssertEqual(container.measuredBorderLeft, 200 * 0.4)
		XCTAssertEqual(container.measuredBorderRight, 200 * 0.6)
		XCTAssertEqual(container.measuredBorderBottom, 400 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (200 * 0.4) + (200 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (400 * 0.2) + (400 * 0.8))

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodeBorderInPW() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPW, length: 20);
		container.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPW, length: 40);
		container.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPW, length: 60);
		container.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPW, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredBorderTop, 320 * 0.2)
		XCTAssertEqual(container.measuredBorderLeft, 320 * 0.4)
		XCTAssertEqual(container.measuredBorderRight, 320 * 0.6)
		XCTAssertEqual(container.measuredBorderBottom, 320 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (320 * 0.4) + (320 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (320 * 0.2) + (320 * 0.8))

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodeBorderInPH() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPH, length: 20);
		container.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPH, length: 40);
		container.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPH, length: 60);
		container.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPH, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredBorderTop, 480 * 0.2)
		XCTAssertEqual(container.measuredBorderLeft, 480 * 0.4)
		XCTAssertEqual(container.measuredBorderRight, 480 * 0.6)
		XCTAssertEqual(container.measuredBorderBottom, 480 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (480 * 0.4) + (480 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (480 * 0.2) + (480 * 0.8))

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodeBorderInCW() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitCW, length: 20);
		container.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitCW, length: 40);
		container.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitCW, length: 60);
		container.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitCW, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredBorderTop, 320 * 0.2)
		XCTAssertEqual(container.measuredBorderLeft, 320 * 0.4)
		XCTAssertEqual(container.measuredBorderRight, 320 * 0.6)
		XCTAssertEqual(container.measuredBorderBottom, 320 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (320 * 0.4) + (320 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (320 * 0.2) + (320 * 0.8))

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testWrappedNodeBorderInCH() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		container.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
		container.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitCH, length: 20);
		container.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitCH, length: 40);
		container.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitCH, length: 60);
		container.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitCH, length: 80);

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node1.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)
		node2.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredBorderTop, 480 * 0.2)
		XCTAssertEqual(container.measuredBorderLeft, 480 * 0.4)
		XCTAssertEqual(container.measuredBorderRight, 480 * 0.6)
		XCTAssertEqual(container.measuredBorderBottom, 480 * 0.8)

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + (480 * 0.4) + (480 * 0.6))
		XCTAssertEqual(container.measuredHeight, 400 + (480 * 0.2) + (480 * 0.8))

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)
	}

	func testNodeMeasure() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: 0)
		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 100)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 200)

		self.window.appendChild(node)
		self.window.resolve()

		node.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: 150)
		node.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: 250)

		node.measure()

		XCTAssertEqual(node.measuredWidth, 150)
		XCTAssertEqual(node.measuredHeight, 250)
	}
}

