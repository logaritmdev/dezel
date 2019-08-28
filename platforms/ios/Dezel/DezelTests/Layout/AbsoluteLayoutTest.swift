import XCTest

@testable import Dezel

class LayoutAbsoluteTest: XCTestCase {

	var context: Layout!
	var window: LayoutNode!

	override func setUp() {

		super.setUp()

		self.context = Layout()

		self.window = LayoutNode(layout: self.context)
		self.window.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 320)
		self.window.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 480)
		self.window.id = "WINDOW"

		self.context.root = self.window
		self.context.viewportWidth = 320
		self.context.viewportHeight = 480
	}

	func testLayoutState() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		self.window.appendChild(node)

		XCTAssertTrue(self.window.hasInvalidLayout)
		XCTAssertTrue(node.hasInvalidPosition)

		self.window.resolve()

		XCTAssertFalse(self.window.hasInvalidLayout)
		XCTAssertFalse(node.hasInvalidPosition)
	}

	func testNodePositionInPX() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 10)
		XCTAssertEqual(node.measuredLeft, 20)
		XCTAssertEqual(node.measuredRight, 30)
		XCTAssertEqual(node.measuredBottom, 40)
	}

	func testNodePositionInPC() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodePositionInVW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 320 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 320 * 0.4)
	}

	func testNodePositionInVH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodePositionInPW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPW, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPW, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPW, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 320 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 320 * 0.4)
	}

	func testNodePositionInPH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPH, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPH, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPH, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodePositionInCW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCW, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCW, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCW, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCW, length: 40)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredBottom, 3200 * 0.4)
	}

	func testNodePositionInCH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCH, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCH, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCH, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCH, length: 40)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredBottom, 4800 * 0.4)
	}

	func testNodeMarginInPX() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 40)

		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 40)

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

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 40)

		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPC, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPC, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPC, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPC, length: 40)

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

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 40)

		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: 40)

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

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 30)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 40)

		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: 40)

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

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPW, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPW, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPW, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 320 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 320 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 320 * 0.4)
	}

	func testNodeMarginInPH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPH, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPH, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPH, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 480 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 480 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 480 * 0.4)
	}

	func testNodeMarginInCW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitCW, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitCW, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitCW, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitCW, length: 40)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 3200 * 0.4)
	}

	func testNodeMarginInCH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitCH, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitCH, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitCH, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitCH, length: 40)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 4800 * 0.4)
	}

	func testNodeWidthInPX() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 100)
	}

	func testNodeWidthInPC() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInVW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInVH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 480 * 0.5)
	}

	func testNodeWidthInPW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInPH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 480 * 0.5)
	}

	func testNodeWidthInCW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitCW, length: 50)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 3200 * 0.5)
	}

	func testNodeWidthInCH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitCH, length: 50)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 4800 * 0.5)
	}

	func testNodeWidthUsingFill() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
		node.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320)
	}

	func testNodeWidthUsingFillAndLeftPosition() {

		let node = LayoutNode(layout: self.context)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.width(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
		node.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 10)
	}

	func testNodeWidthUsingFillAndRightPosition() {

		let node = LayoutNode(layout: self.context)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 30)
		node.width(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
		node.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPX() {

		let node = LayoutNode(layout: self.context)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 20 - 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPC() {

		let node = LayoutNode(layout: self.context)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - (320 * 0.2) - (320 * 0.3))
	}

	func testNodeWidthUsingLeftAndRightPositionInVW() {

		let node = LayoutNode(layout: self.context)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - (320 * 0.2) - (320 * 0.3))
	}

	func testNodeWidthUsingLeftAndRightPositionInVH() {

		let node = LayoutNode(layout: self.context)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - (480 * 0.2) - (480 * 0.3))
	}

	func testNodeWidthtShouldBeMeasuredFromLeftAndRightInsteadOfLength() {

		let node = LayoutNode(layout: self.context)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 30)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 20 - 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPXIncludingNegativeMargins() {

		let node = LayoutNode(layout: self.context)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 30)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: -20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: -30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 50 + 50) // 320 - (20 + 30) + (20 + 30)
	}

	func testNodeWidthUsingLeftAndRightPositionInPXIncludingPositiveMargins() {

		let node = LayoutNode(layout: self.context)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 30)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 30)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 50 - 50) // 320 - (20 + 30) - (20 + 30)
	}

	func testNodeHeightInPX() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 100)
	}

	func testNodeHeightInPC() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 * 0.5)
	}

	func testNodeHeightInVW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 320 * 0.5)
	}

	func testNodeHeightInVH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 * 0.5)
	}

	func testNodeHeightInPW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 320 * 0.5)
	}

	func testNodeHeightInPH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 * 0.5)
	}

	func testNodeHeightInCW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitCW, length: 50)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 3200 * 0.5)
	}

	func testNodeHeightInCH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitCH, length: 50)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 4800 * 0.5)
	}

	func testNodeHeightUsingFill() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
		node.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480)
	}

	func testNodeHeightUsingFillAndTopPosition() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.width(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
		node.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 10)
	}

	func testNodeHeightUsingFillAndBottomPosition() {

		let node = LayoutNode(layout: self.context)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 40)
		node.width(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
		node.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPX() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 10 - 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPC() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: 10)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - (480 * 0.1) - (480 * 0.4))
	}

	func testNodeHeightUsingTopAndBottomPositionInVW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: 10)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - (320 * 0.1) - (320 * 0.4))
	}

	func testNodeHeightUsingTopAndBottomPositionInVH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: 10)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - (480 * 0.1) - (480 * 0.4))
	}

	func testNodeHeightShouldBeMeasuredFromTopAndBottomInsteadOfLength() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 40)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 150)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 10 - 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPXIncludingNegativeMargins() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 40)
		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: -10)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: -40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 50 + 50) // 480 - (10 + 40) + (10 + 40)
	}

	func testNodeHeightUsingTopAndBottomPositionInPXIncludingPositiveMargins() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 40)
		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 10)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480 - 50 - 50) // 480 - (10 + 40) - (10 + 40)
	}

	func testNodeBorderInPX() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 150)

		node.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: 10)
		node.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: 20)
		node.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: 30)
		node.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 10)
		XCTAssertEqual(node.measuredBorderLeft, 20)
		XCTAssertEqual(node.measuredBorderRight, 30)
		XCTAssertEqual(node.measuredBorderBottom, 40)
	}

	func testNodeBorderInPC() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 150)

		node.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPC, length: 10)
		node.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPC, length: 20)
		node.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPC, length: 30)
		node.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 150 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 100 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 100 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 150 * 0.4)
	}

	func testNodeBorderInVW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 150)

		node.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: 10)
		node.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: 20)
		node.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: 30)
		node.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 320 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 320 * 0.4)
	}

	func testNodeBorderInVH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 150)

		node.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: 10)
		node.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: 20)
		node.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: 30)
		node.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 480 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 480 * 0.4)
	}

func testNodeBorderInPW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPW, length: 10)
		node.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPW, length: 20)
		node.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPW, length: 30)
		node.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 320 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 320 * 0.4)
	}

	func testNodeBorderInPH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPH, length: 10)
		node.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPH, length: 20)
		node.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPH, length: 30)
		node.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 480 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 480 * 0.4)
	}

func testNodeBorderInCW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCW, length: 10)
		node.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCW, length: 20)
		node.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCW, length: 30)
		node.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCW, length: 40)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 3200 * 0.4)
	}

	func testNodeBorderInCH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCH, length: 10)
		node.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCH, length: 20)
		node.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCH, length: 30)
		node.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCH, length: 40)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredBorderTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredBorderLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredBorderRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredBorderBottom, 4800 * 0.4)
	}

	func testNodePaddingInPX() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 150)

		node.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 10)
		node.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 20)
		node.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 30)
		node.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 10)
		XCTAssertEqual(node.measuredPaddingLeft, 20)
		XCTAssertEqual(node.measuredPaddingRight, 30)
		XCTAssertEqual(node.measuredPaddingBottom, 40)
	}

	func testNodePaddingInPC() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 150)

		node.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPC, length: 10)
		node.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPC, length: 20)
		node.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPC, length: 30)
		node.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPC, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 150 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 100 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 100 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 150 * 0.4)
	}

	func testNodePaddingInVW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 150)

		node.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVW, length: 10)
		node.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVW, length: 20)
		node.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVW, length: 30)
		node.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 320 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 320 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 320 * 0.4)
	}

	func testNodePaddingInVH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 150)

		node.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVH, length: 10)
		node.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVH, length: 20)
		node.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVH, length: 30)
		node.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 480 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 480 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 480 * 0.4)
	}


	func testNodePaddingInPW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPW, length: 10)
		node.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPW, length: 20)
		node.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPW, length: 30)
		node.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 320 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 320 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 320 * 0.4)
	}

	func testNodePaddingInPH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPH, length: 10)
		node.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPH, length: 20)
		node.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPH, length: 30)
		node.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 480 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 480 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 480 * 0.4)
	}

	func testNodePaddingInCW() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCW, length: 10)
		node.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCW, length: 20)
		node.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCW, length: 30)
		node.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCW, length: 40)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 3200 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 3200 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 3200 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 3200 * 0.4)
	}

	func testNodePaddingInCH() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)

		node.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCH, length: 10)
		node.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCH, length: 20)
		node.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCH, length: 30)
		node.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCH, length: 40)

		self.window.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 3200)
		self.window.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: 4800)
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredPaddingTop, 4800 * 0.1)
		XCTAssertEqual(node.measuredPaddingLeft, 4800 * 0.2)
		XCTAssertEqual(node.measuredPaddingRight, 4800 * 0.3)
		XCTAssertEqual(node.measuredPaddingBottom, 4800 * 0.4)
	}

	func testAnchorInPC() {

		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		node.anchorTop(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: 50)
		node.anchorLeft(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, -100)
		XCTAssertEqual(node.measuredLeft, -100)
	}

	func testScaling() {

		// TODO: Test other properites
		let node = LayoutNode(layout: self.context)
		node.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: 33)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: 33)

		self.context.scale = 2
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 0)
		XCTAssertEqual(node.measuredLeft, 0)
		XCTAssertEqual(node.measuredWidth, 105.5)
		XCTAssertEqual(node.measuredHeight, 158.5)
	}

	func testWrappingFromContentSize() {

		let container = LayoutNode(layout: self.context)
		container.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		container.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)

		let node1 = LayoutNode(layout: self.context)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		let node2 = LayoutNode(layout: self.context)
		node2.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node2.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

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

		let container = LayoutNode(layout: self.context)
		container.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		container.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.minWidth(250)
		container.minHeight(450)

		let node1 = LayoutNode(layout: self.context)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		let node2 = LayoutNode(layout: self.context)
		node2.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node2.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

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

		let container = LayoutNode(layout: self.context)
		container.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		container.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.maxWidth(150)
		container.maxHeight(350)

		let node1 = LayoutNode(layout: self.context)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		let node2 = LayoutNode(layout: self.context)
		node2.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node2.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

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

		let container = LayoutNode(layout: self.context)
		container.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		container.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 10)
		container.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 20)
		container.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 30)
		container.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 40)

		let node1 = LayoutNode(layout: self.context)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		let node2 = LayoutNode(layout: self.context)
		node2.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node2.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

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

		let container = LayoutNode(layout: self.context)
		container.id = "container"
		container.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 0)
		container.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)

		let node1 = LayoutNode(layout: self.context)
		node1.id = "node1"
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 30)
		node1.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 20)

		let node2 = LayoutNode(layout: self.context)
		node2.id = "node2"
		node2.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node2.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node2.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 50)
		node2.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 40)

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

		let counter = LayoutNodeDelegateCounter()

		let node1 = LayoutNode(layout: self.context)
		node1.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node1.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.delegate = counter

		let node2 = LayoutNode(layout: self.context)
		node2.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node2.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node2.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node2.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node2.delegate = counter

		self.window.appendChild(node1)
		self.window.appendChild(node2)
		self.window.resolve()

		XCTAssertEqual(node1.resolveSizeCount, 1)
		XCTAssertEqual(node2.resolveSizeCount, 1)
		XCTAssertEqual(node1.resolvePositionCount, 1)
		XCTAssertEqual(node2.resolvePositionCount, 1)

		XCTAssertEqual(counter.didResolveSizeCount, 2)
		XCTAssertEqual(counter.didResolvePositionCount, 2)

		let node3 = LayoutNode(layout: self.context)
		node3.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 10)
		node3.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: 20)
		node3.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node3.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node3.delegate = counter

		self.window.appendChild(node3)
		self.window.resolve()

		XCTAssertEqual(counter.didResolveSizeCount, 3)
		XCTAssertEqual(counter.didResolvePositionCount, 3)

		XCTAssertEqual(node1.resolveSizeCount, 1)
		XCTAssertEqual(node2.resolveSizeCount, 1)
		XCTAssertEqual(node1.resolvePositionCount, 1)
		XCTAssertEqual(node2.resolvePositionCount, 1)

		XCTAssertEqual(node3.resolveSizeCount, 1)
		XCTAssertEqual(node3.resolvePositionCount, 1)
	}
}

