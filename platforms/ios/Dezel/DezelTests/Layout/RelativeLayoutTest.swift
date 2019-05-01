import XCTest

@testable import Dezel

class RelativeLayoutTest: XCTestCase {

	var layout: Layout!

	var window: LayoutNode!

	override func setUp() {

		super.setUp()

		self.layout = Layout()

		self.window = LayoutNode(layout: self.layout)
		self.window.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 320)
		self.window.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 480)

		self.layout.root = self.window
		self.layout.viewportWidth = 320
		self.layout.viewportHeight = 480
	}

	override func tearDown() {
		super.tearDown()
	}

	func testLayoutState() {

		let node = LayoutNode(layout: self.layout)

		self.window.appendChild(node)

		XCTAssertTrue(self.window.hasInvalidLayout)

		self.window.resolve()

		XCTAssertFalse(self.window.hasInvalidLayout)
	}

	func testNodeMarginInPX() {

		let node = LayoutNode(layout: self.layout)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 40)
		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 - 20 - 30)
		XCTAssertEqual(node.measuredHeight, 40)

		XCTAssertEqual(node.measuredTop, 10)
		XCTAssertEqual(node.measuredLeft, 20)
		XCTAssertEqual(node.measuredRight, 30)
		XCTAssertEqual(node.measuredBottom, 480 - 40 - 10)

		XCTAssertEqual(node.measuredMarginTop, 10)
		XCTAssertEqual(node.measuredMarginLeft, 20)
		XCTAssertEqual(node.measuredMarginRight, 30)
		XCTAssertEqual(node.measuredMarginBottom, 40)
	}

	func testNodeMarginInPC() {

		let node = LayoutNode(layout: self.layout)
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

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodeMarginInVW() {

		let node = LayoutNode(layout: self.layout)
		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 320 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 320 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 320 * 0.4)

		XCTAssertEqual(node.measuredTop, 320 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 320 * 0.4)
	}

	func testNodeMarginInVH() {

		let node = LayoutNode(layout: self.layout)
		node.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: 10)
		node.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: 20)
		node.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: 30)
		node.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: 40)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredMarginTop, 480 * 0.1)
		XCTAssertEqual(node.measuredMarginLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredMarginRight, 480 * 0.3)
		XCTAssertEqual(node.measuredMarginBottom, 480 * 0.4)

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 480 * 0.2)
		XCTAssertEqual(node.measuredRight, 480 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)
	}

	func testNodeWidthInPX() {

		let node = LayoutNode(layout: self.layout)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 100)
	}

	func testNodeWidthInPC() {

		let node = LayoutNode(layout: self.layout)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInVW() {

		let node = LayoutNode(layout: self.layout)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInVH() {

		let node = LayoutNode(layout: self.layout)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 480 * 0.5)
	}

	func testNodeWidthUsingFill() {

		let node = LayoutNode(layout: self.layout)
		node.width(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
		node.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320)
	}

	func testNodeHeightUsingFill() {

		let node = LayoutNode(layout: self.layout)
		node.width(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
		node.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480)
	}

	func testNodeBorderInPX() {

		let node = LayoutNode(layout: self.layout)
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

		let node = LayoutNode(layout: self.layout)
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

		let node = LayoutNode(layout: self.layout)
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

		let node = LayoutNode(layout: self.layout)
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

	func testNodePaddingInPX() {

		let node = LayoutNode(layout: self.layout)
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

		let node = LayoutNode(layout: self.layout)
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

		let node = LayoutNode(layout: self.layout)
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

		let node = LayoutNode(layout: self.layout)
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

	func testAnchorInPC() {

		let node = LayoutNode(layout: self.layout)
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

		let node = LayoutNode(layout: self.layout)
		node.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: 33)
		node.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: 33)

		self.layout.scale = 2
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 0)
		XCTAssertEqual(node.measuredLeft, 0)
		XCTAssertEqual(node.measuredWidth, 105.5)
		XCTAssertEqual(node.measuredHeight, 158.5)
	}

	func testPositionInVerticalLayout() {

		let node1 = LayoutNode(layout: self.layout)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)

		let node2 = LayoutNode(layout: self.layout)
		node2.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		self.window.appendChild(node1)
		self.window.appendChild(node2)
		self.window.resolve()

		XCTAssertEqual(node1.measuredWidth, 320)
		XCTAssertEqual(node1.measuredHeight, 100)
		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredRight, 0)
		XCTAssertEqual(node1.measuredBottom, 480 - 100)

		XCTAssertEqual(node2.measuredWidth, 320)
		XCTAssertEqual(node2.measuredHeight, 200)
		XCTAssertEqual(node2.measuredTop, 100)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredRight, 0)
		XCTAssertEqual(node2.measuredBottom, 480 - 200 - 100)
	}

	func testPositionInHorizontalLayout() {

		let node1 = LayoutNode(layout: self.layout)
		node1.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 100)

		let node2 = LayoutNode(layout: self.layout)
		node2.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
		node2.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		self.window.contentOrientation(kDLLayoutContentOrientationHorizontal)
		self.window.appendChild(node1)
		self.window.appendChild(node2)
		self.window.resolve()

		XCTAssertEqual(node1.measuredWidth, 100)
		XCTAssertEqual(node1.measuredHeight, 480)
		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredRight, 320 - 100)
		XCTAssertEqual(node1.measuredBottom, 0)

		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 480)
		XCTAssertEqual(node2.measuredTop, 0)
		XCTAssertEqual(node2.measuredLeft, 100)
		XCTAssertEqual(node2.measuredRight, 320 - 200 - 100)
		XCTAssertEqual(node2.measuredBottom, 0)
	}

	func testPercentageCarrying() {

		self.window.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 320)
		self.window.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 485)

		self.layout.viewportWidth = 320
		self.layout.viewportHeight = 480
		self.layout.scale = 2

		let node1 = LayoutNode(layout: self.layout)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: 33.3333)

		let node2 = LayoutNode(layout: self.layout)
		node2.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: 33.3333)

		let node3 = LayoutNode(layout: self.layout)
		node3.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: 33.3333)

		self.window.appendChild(node1)
		self.window.appendChild(node2)
		self.window.appendChild(node3)
		self.window.resolve()

		XCTAssertEqual(node1.measuredHeight, 161.5)
		XCTAssertEqual(node2.measuredHeight, 162)
		XCTAssertEqual(node3.measuredHeight, 161.5)
	}

	func testWrappingFromContentSize() {

		let container = LayoutNode(layout: self.layout)
		container.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)

		let node1 = LayoutNode(layout: self.layout)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		let node2 = LayoutNode(layout: self.layout)
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

		let container = LayoutNode(layout: self.layout)
		container.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.minWidth(250)
		container.minHeight(450)

		let node1 = LayoutNode(layout: self.layout)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		let node2 = LayoutNode(layout: self.layout)
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

		let container = LayoutNode(layout: self.layout)
		container.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.maxWidth(150)
		container.maxHeight(350)

		let node1 = LayoutNode(layout: self.layout)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		let node2 = LayoutNode(layout: self.layout)
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

		let container = LayoutNode(layout: self.layout)

		container.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 10)
		container.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 20)
		container.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 30)
		container.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: 40)

		let node1 = LayoutNode(layout: self.layout)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)

		let node2 = LayoutNode(layout: self.layout)
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

		let container = LayoutNode(layout: self.layout)
		container.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
		container.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)

		let node1 = LayoutNode(layout: self.layout)
		node1.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: 200)
		node1.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 30)
		node1.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: 20)

		let node2 = LayoutNode(layout: self.layout)
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
}
