import XCTest

@testable import Dezel

class DisplayNodeAbsoluteLayoutTest: XCTestCase {

	var display: Display!

	var window: DisplayNode!

	override func setUp() {

		super.setUp()

		self.display = Display()
		self.display.setViewportWidth(320)
		self.display.setViewportHeight(480)

		self.window = DisplayNode(display: self.display)
		self.window.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 320)
		self.window.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 480)
		self.window.setId("WINDOW")

		self.display.setWindow(self.window)

	}

//	func testLayoutState() {
//
//		let node = DisplayNode(display: self.display)
//		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
//
//		self.window.appendChild(node)
//
//		XCTAssertTrue(self.window.hasInvalidLayout)
//		XCTAssertTrue(node.hasInvalidPosition)
//
//		self.window.resolve()
//
//		XCTAssertFalse(self.window.hasInvalidLayout)
//		XCTAssertFalse(node.hasInvalidPosition)
//	}

	func testNodePositionInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 10)
		XCTAssertEqual(node.measuredLeft, 20)
		XCTAssertEqual(node.measuredRight, 30)
		XCTAssertEqual(node.measuredBottom, 40)
	}

	func testNodePositionInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodePositionInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 320 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 320 * 0.4)
	}

	func testNodePositionInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodePositionInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPW, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPW, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPW, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 320 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 320 * 0.4)
	}

	func testNodePositionInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPH, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPH, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPH, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodePositionInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCW, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCW, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCW, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCW, length: 40)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredBottom, 3200 * 0.4)
	}

	func testNodePositionInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCH, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCH, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCH, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCH, length: 40)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredBottom, 4800 * 0.4)
	}

	func testNodeMarginInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 40)

		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 40)

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
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 40)

		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPC, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPC, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPC, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPC, length: 40)

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
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 40)

		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: 40)

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
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 30)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 40)

		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: 40)

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
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPW, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPW, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPW, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 320 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 320 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 320 * 0.4)
	}

	func testNodeMarginInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPH, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPH, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPH, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 480 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 480 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 480 * 0.4)
	}

	func testNodeMarginInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitCW, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitCW, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitCW, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitCW, length: 40)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 3200 * 0.4)
	}

	func testNodeMarginInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitCH, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitCH, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitCH, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitCH, length: 40)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 4800 * 0.4)
	}

	func testNodeWidthInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 100)
	}

	func testNodeWidthInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 480 * 0.5)
	}

	func testNodeWidthInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 480 * 0.5)
	}

	func testNodeWidthInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitCW, length: 50)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 3200 * 0.5)
	}

	func testNodeWidthInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitCH, length: 50)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 4800 * 0.5)
	}

	func testNodeWidthUsingFill() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320)
	}

	func testNodeWidthUsingFillAndLeftPosition() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setWidth(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 10)
	}

	func testNodeWidthUsingFillAndRightPosition() {

		let node = DisplayNode(display: self.display)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 30)
		node.setWidth(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPX() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 20 - 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPC() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - (320 * 0.2) - (320 * 0.3))
	}

	func testNodeWidthUsingLeftAndRightPositionInVW() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - (320 * 0.2) - (320 * 0.3))
	}

	func testNodeWidthUsingLeftAndRightPositionInVH() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - (480 * 0.2) - (480 * 0.3))
	}

	func testNodeWidthtShouldBeMeasuredFromLeftAndRightInsteadOfLength() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 30)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 20 - 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPXIncludingNegativeMargins() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 30)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: -20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: -30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 50 + 50) // 320 - (20 + 30) + (20 + 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPXIncludingPositiveMargins() {

		let node = DisplayNode(display: self.display)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 30)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 50 - 50) // 320 - (20 + 30) - (20 + 30)
	}

	func testNodeHeightInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 100)
	}

	func testNodeHeightInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 * 0.5)
	}

	func testNodeHeightInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 320 * 0.5)
	}

	func testNodeHeightInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 * 0.5)
	}

	func testNodeHeightInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 320 * 0.5)
	}

	func testNodeHeightInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 * 0.5)
	}

	func testNodeHeightInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitCW, length: 50)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 3200 * 0.5)
	}

	func testNodeHeightInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitCH, length: 50)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 4800 * 0.5)
	}

	func testNodeHeightUsingFill() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480)
	}

	func testNodeHeightUsingFillAndTopPosition() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setWidth(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 10)
	}

	func testNodeHeightUsingFillAndBottomPosition() {

		let node = DisplayNode(display: self.display)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 40)
		node.setWidth(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 10 - 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: 10)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - (480 * 0.1) - (480 * 0.4))
	}

	func testNodeHeightUsingTopAndBottomPositionInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: 10)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - (320 * 0.1) - (320 * 0.4))
	}

	func testNodeHeightUsingTopAndBottomPositionInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: 10)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - (480 * 0.1) - (480 * 0.4))
	}

	func testNodeHeightShouldBeMeasuredFromTopAndBottomInsteadOfLength() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 40)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 150)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 10 - 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPXIncludingNegativeMargins() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 40)
		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: -10)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: -40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 50 + 50) // 480 - (10 + 40) + (10 + 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPXIncludingPositiveMargins() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 40)
		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 10)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 50 - 50) // 480 - (10 + 40) - (10 + 40)
	}

	func testNodeBorderInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 150)

		node.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: 10)
		node.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: 20)
		node.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: 30)
		node.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 10)
		XCTAssertEqual(node.measuredBorderLeft, 20)
		XCTAssertEqual(node.measuredBorderRight, 30)
		XCTAssertEqual(node.measuredBorderBottom, 40)
	}

	func testNodeBorderInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 150)

		node.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: 10)
		node.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: 20)
		node.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: 30)
		node.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 150 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 100 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 100 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 150 * 0.4)
	}

	func testNodeBorderInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 150)

		node.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: 10)
		node.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: 20)
		node.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: 30)
		node.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 320 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 320 * 0.4)
	}

	func testNodeBorderInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 150)

		node.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: 10)
		node.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: 20)
		node.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: 30)
		node.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 480 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 480 * 0.4)
	}

func testNodeBorderInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPW, length: 10)
		node.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPW, length: 20)
		node.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPW, length: 30)
		node.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 320 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 320 * 0.4)
	}

	func testNodeBorderInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPH, length: 10)
		node.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPH, length: 20)
		node.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPH, length: 30)
		node.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 480 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 480 * 0.4)
	}

func testNodeBorderInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: 10)
		node.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: 20)
		node.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: 30)
		node.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: 40)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 3200 * 0.4)
	}

	func testNodeBorderInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: 10)
		node.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: 20)
		node.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: 30)
		node.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: 40)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 4800 * 0.4)
	}

	func testNodePaddingInPX() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 150)

		node.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 10)
		node.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 20)
		node.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 30)
		node.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 10)
		XCTAssertEqual(node.measuredPaddingLeft, 20)
		XCTAssertEqual(node.measuredPaddingRight, 30)
		XCTAssertEqual(node.measuredPaddingBottom, 40)
	}

	func testNodePaddingInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 150)

		node.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: 10)
		node.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: 20)
		node.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: 30)
		node.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 150 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 100 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 100 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 150 * 0.4)
	}

	func testNodePaddingInVW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 150)

		node.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: 10)
		node.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: 20)
		node.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: 30)
		node.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 320 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 320 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 320 * 0.4)
	}

	func testNodePaddingInVH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 150)

		node.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: 10)
		node.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: 20)
		node.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: 30)
		node.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 480 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 480 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 480 * 0.4)
	}


	func testNodePaddingInPW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: 10)
		node.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: 20)
		node.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: 30)
		node.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 320 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 320 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 320 * 0.4)
	}

	func testNodePaddingInPH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: 10)
		node.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: 20)
		node.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: 30)
		node.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 480 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 480 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 480 * 0.4)
	}

	func testNodePaddingInCW() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: 10)
		node.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: 20)
		node.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: 30)
		node.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: 40)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 3200 * 0.4)
	}

	func testNodePaddingInCH() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)

		node.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: 10)
		node.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: 20)
		node.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: 30)
		node.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: 40)

		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 3200)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 4800 * 0.4)
	}

	func testAnchorInPC() {

		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		node.setAnchorTop(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: 50)
		node.setAnchorLeft(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, -100)
		XCTAssertEqual(node.measuredLeft, -100)
	}

	func testScaling() {

		// TODO: Test other properites
		let node = DisplayNode(display: self.display)
		node.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: 33)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: 33)

		self.display.setScale(2)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 0)
		XCTAssertEqual(node.measuredLeft, 0)
		XCTAssertEqual(node.measuredWidth, 105.5)
		XCTAssertEqual(node.measuredHeight, 158.5)
	}

	func testWrappingFromContentSize() {

		let container = DisplayNode(display: self.display)
		container.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node1.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node2.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

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
		container.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setMinWidth(250)
		container.setMinHeight(450)

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node1.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node2.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

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
		container.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setMaxWidth(150)
		container.setMaxHeight(350)

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node1.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node2.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

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
		container.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 10)
		container.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 20)
		container.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 30)
		container.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 40)

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node1.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		let node2 = DisplayNode(display: self.display)
		node2.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node2.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

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
		container.setId("container")
		container.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 0)
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)

		let node1 = DisplayNode(display: self.display)
		node1.setId("node1")
		node1.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node1.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node1.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 30)
		node1.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 20)

		let node2 = DisplayNode(display: self.display)
		node2.setId("node2")
		node2.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node2.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node2.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 50)
		node2.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 40)

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
		node1.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node1.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node1.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node1.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node1.delegate = counter

		let node2 = DisplayNode(display: self.display)
		node2.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node2.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node2.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node2.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node2.delegate = counter

		self.window.appendChild(node1)
		self.window.appendChild(node2)
		self.window.resolve()

		XCTAssertEqual(counter.didResolveSizeCount, 2)
		XCTAssertEqual(counter.didResolvePositionCount, 2)

		let node3 = DisplayNode(display: self.display)
		node3.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 10)
		node3.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: 20)
		node3.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node3.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node3.delegate = counter

		self.window.appendChild(node3)
		self.window.resolve()

		XCTAssertEqual(counter.didResolveSizeCount, 3)
		XCTAssertEqual(counter.didResolvePositionCount, 3)
	}
}

