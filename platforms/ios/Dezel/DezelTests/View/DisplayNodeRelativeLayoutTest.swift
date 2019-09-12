import XCTest

@testable import Dezel

class DisplayNodeRelativeLayoutTest: XCTestCase {

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
		self.window.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 320)
		self.window.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: 480)
		self.window.id = "Window"

		self.display.setWindow(self.window)
	}

	override func tearDown() {
		super.tearDown()
	}

	func testWindowSize() {

		self.window.resolve()

		XCTAssertEqual(self.window.measuredTop, 0)
		XCTAssertEqual(self.window.measuredLeft, 0)
		XCTAssertEqual(self.window.measuredRight, 0)
		XCTAssertEqual(self.window.measuredBottom, 0)

		XCTAssertEqual(self.window.measuredWidth, 320)
		XCTAssertEqual(self.window.measuredHeight, 480)
		XCTAssertEqual(self.window.measuredInnerWidth, 320)
		XCTAssertEqual(self.window.measuredInnerHeight, 480)
		XCTAssertEqual(self.window.measuredContentWidth, 320)
		XCTAssertEqual(self.window.measuredContentHeight, 480)
	}

	func testNodeMarginInPX() {

		let node = DisplayNode(display: self.display)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 40)
		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 40)

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

		let node = DisplayNode(display: self.display)
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

		XCTAssertEqual(node.measuredTop, 480 * 0.1)
		XCTAssertEqual(node.measuredLeft, 320 * 0.2)
		XCTAssertEqual(node.measuredRight, 320 * 0.3)
		XCTAssertEqual(node.measuredBottom, 480 * 0.4)

		XCTAssertEqual(node.measuredWidth, 320 * (0.2 + 0.3))
		XCTAssertEqual(node.measuredHeight, 480 * (0.1 + 0.4))
	}

	func testNodeMarginInVW() {

		let node = DisplayNode(display: self.display)
		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: 40)

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

		let node = DisplayNode(display: self.display)
		node.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: 10)
		node.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: 20)
		node.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: 30)
		node.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: 40)

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

		let node = DisplayNode(display: self.display)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 100)
	}

	func testNodeWidthInPC() {

		let node = DisplayNode(display: self.display)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInVW() {

		let node = DisplayNode(display: self.display)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVW, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320 * 0.5)
	}

	func testNodeWidthInVH() {

		let node = DisplayNode(display: self.display)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVH, length: 50)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 480 * 0.5)
	}

	func testNodeWidthUsingFill() {

		let node = DisplayNode(display: self.display)
		node.setWidth(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredWidth, 320)
	}

	func testNodeHeightUsingFill() {

		let node = DisplayNode(display: self.display)
		node.setWidth(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
		node.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)

		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredHeight, 480)
	}

	func testNodeBorderInPX() {

		let node = DisplayNode(display: self.display)
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

	func testNodePaddingInPX() {

		let node = DisplayNode(display: self.display)
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

	func testAnchorInPC() {

		let node = DisplayNode(display: self.display)
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

		let node = DisplayNode(display: self.display)
		node.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: 33)
		node.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: 33)

		self.display.setScale(2);
		self.window.appendChild(node)
		self.window.resolve()

		XCTAssertEqual(node.measuredTop, 0)
		XCTAssertEqual(node.measuredLeft, 0)
		XCTAssertEqual(node.measuredWidth, 105.5)
		XCTAssertEqual(node.measuredHeight, 158.5)
	}

	func testPositionInVerticalLayout() {

		let node1 = DisplayNode(display: self.display)
		node1.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)

		let node2 = DisplayNode(display: self.display)
		node2.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

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

		let node1 = DisplayNode(display: self.display)
		node1.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
		node1.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 100)

		let node2 = DisplayNode(display: self.display)
		node2.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
		node2.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		self.window.setContentDirection(kDisplayNodeContentDirectionHorizontal)
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

		self.window.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 320)
		self.window.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 485)

		self.display.setViewportWidth(320)
		self.display.setViewportHeight(480)
		self.display.setScale(2)

		let node1 = DisplayNode(display: self.display)
		node1.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: 33.3333)

		let node2 = DisplayNode(display: self.display)
		node2.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: 33.3333)

		let node3 = DisplayNode(display: self.display)
		node3.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: 33.3333)

		self.window.appendChild(node1)
		self.window.appendChild(node2)
		self.window.appendChild(node3)
		self.window.resolve()

		XCTAssertEqual(node1.measuredHeight, 161.5)
		XCTAssertEqual(node2.measuredHeight, 162)
		XCTAssertEqual(node3.measuredHeight, 161.5)
	}

	func testContentSizeAutoMeasurement() {

		let container = DisplayNode(display: self.display)
		container.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitNone, length: 200)
		container.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitNone, length: 200)

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

		XCTAssertEqual(container.measuredContentWidth, 200)
		XCTAssertEqual(container.measuredContentHeight, 400)

	}

	func testWrappingFromContentSize() {

		let container = DisplayNode(display: self.display)
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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)

		let node1 = DisplayNode(display: self.display)
		node1.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node1.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node1.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 30)
		node1.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: 20)

		let node2 = DisplayNode(display: self.display)
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

	func testWrappedNodePaddingInPX() {

		let container = DisplayNode(display: self.display)
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 20);
		container.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 40);
		container.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 60);
		container.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: 20);
		container.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: 40);
		container.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: 60);
		container.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: 20);
		container.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: 40);
		container.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: 60);
		container.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: 20);
		container.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: 40);
		container.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: 60);
		container.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: 20);
		container.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: 40);
		container.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: 60);
		container.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: 20);
		container.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: 40);
		container.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: 60);
		container.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: 20);
		container.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: 40);
		container.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: 60);
		container.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: 80);

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
print("TEST \(self.window.measuredContentWidth) \(self.window.measuredWidth)")
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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: 20);
		container.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: 40);
		container.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: 60);
		container.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: 20);
		container.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: 40);
		container.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: 60);
		container.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: 20);
		container.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: 40);
		container.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: 60);
		container.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPW, length: 20);
		container.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPW, length: 40);
		container.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPW, length: 60);
		container.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPW, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPH, length: 20);
		container.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPH, length: 40);
		container.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPH, length: 60);
		container.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPH, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: 20);
		container.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: 40);
		container.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: 60);
		container.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: 80);

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
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: 20);
		container.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: 40);
		container.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: 60);
		container.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: 80);

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

	func testWrappedNodeCallbackCount() {

		let containerd = DisplayNodeDelegateCounter()

		let node1d = DisplayNodeDelegateCounter()
		let node2d = DisplayNodeDelegateCounter()
		let node3d = DisplayNodeDelegateCounter()

		let node4d = DisplayNodeDelegateCounter()
		let node5d = DisplayNodeDelegateCounter()
		let node6d = DisplayNodeDelegateCounter()

		let container = DisplayNode(display: self.display)
		container.delegate = containerd
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)

		let node1 = DisplayNode(display: self.display)
		node1.delegate = node1d
		node1.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		node1.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)

		let node2 = DisplayNode(display: self.display)
		node2.delegate = node2d
		node2.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		node2.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)

		let node3 = DisplayNode(display: self.display)
		node3.delegate = node3d
		node3.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		node3.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)

		let node4 = DisplayNode(display: self.display)
		node4.delegate = node4d
		node4.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node4.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		let node5 = DisplayNode(display: self.display)
		node5.delegate = node5d
		node5.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node5.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		let node6 = DisplayNode(display: self.display)
		node6.delegate = node6d
		node6.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node6.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)
		container.appendChild(node3)

		node1.appendChild(node4)
		node2.appendChild(node5)
		node3.appendChild(node6)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200)
		XCTAssertEqual(container.measuredHeight, 600)

		XCTAssertEqual(node1.measuredTop, 0)
		XCTAssertEqual(node1.measuredLeft, 0)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200)
		XCTAssertEqual(node2.measuredLeft, 0)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)

		XCTAssertEqual(node3.measuredTop, 400)
		XCTAssertEqual(node3.measuredLeft, 0)
		XCTAssertEqual(node3.measuredWidth, 200)
		XCTAssertEqual(node3.measuredHeight, 200)

		XCTAssertEqual(node4.measuredTop, 0)
		XCTAssertEqual(node4.measuredLeft, 0)
		XCTAssertEqual(node4.measuredWidth, 200)
		XCTAssertEqual(node4.measuredHeight, 200)

		XCTAssertEqual(node5.measuredTop, 0)
		XCTAssertEqual(node5.measuredLeft, 0)
		XCTAssertEqual(node5.measuredWidth, 200)
		XCTAssertEqual(node5.measuredHeight, 200)

		XCTAssertEqual(node6.measuredTop, 0)
		XCTAssertEqual(node6.measuredLeft, 0)
		XCTAssertEqual(node6.measuredWidth, 200)
		XCTAssertEqual(node6.measuredHeight, 200)

		XCTAssertEqual(containerd.measured, 1)
		XCTAssertEqual(containerd.resolvedSize, 1)
		XCTAssertEqual(containerd.resolvedOrigin, 1)
		XCTAssertEqual(containerd.resolvedInnerSize, 1)
		XCTAssertEqual(containerd.resolvedContentSize, 1)
		XCTAssertEqual(containerd.resolvedMargin, 0)
		XCTAssertEqual(containerd.resolvedBorder, 0)
		XCTAssertEqual(containerd.resolvedPadding, 0)
		XCTAssertEqual(containerd.invalidate, 1)
		XCTAssertEqual(containerd.layoutBegan, 1)
		XCTAssertEqual(containerd.layoutEnded, 1)

		XCTAssertEqual(node1d.measured, 1)
		XCTAssertEqual(node1d.resolvedSize, 1)
		XCTAssertEqual(node1d.resolvedOrigin, 1)
		XCTAssertEqual(node1d.resolvedInnerSize, 1)
		XCTAssertEqual(node1d.resolvedContentSize, 1)
		XCTAssertEqual(node1d.resolvedMargin, 0)
		XCTAssertEqual(node1d.resolvedBorder, 0)
		XCTAssertEqual(node1d.resolvedPadding, 0)
		XCTAssertEqual(node1d.invalidate, 1)
		XCTAssertEqual(node1d.layoutBegan, 1)
		XCTAssertEqual(node1d.layoutEnded, 1)

		XCTAssertEqual(node2d.measured, 1)
		XCTAssertEqual(node2d.resolvedSize, 1)
		XCTAssertEqual(node2d.resolvedOrigin, 1)
		XCTAssertEqual(node2d.resolvedInnerSize, 1)
		XCTAssertEqual(node2d.resolvedContentSize, 1)
		XCTAssertEqual(node2d.resolvedMargin, 0)
		XCTAssertEqual(node2d.resolvedBorder, 0)
		XCTAssertEqual(node2d.resolvedPadding, 0)
		XCTAssertEqual(node2d.invalidate, 1)
		XCTAssertEqual(node2d.layoutBegan, 1)
		XCTAssertEqual(node2d.layoutEnded, 1)

		XCTAssertEqual(node3d.measured, 1)
		XCTAssertEqual(node3d.resolvedSize, 1)
		XCTAssertEqual(node3d.resolvedOrigin, 1)
		XCTAssertEqual(node3d.resolvedInnerSize, 1)
		XCTAssertEqual(node3d.resolvedContentSize, 1)
		XCTAssertEqual(node3d.resolvedMargin, 0)
		XCTAssertEqual(node3d.resolvedBorder, 0)
		XCTAssertEqual(node3d.resolvedPadding, 0)
		XCTAssertEqual(node3d.invalidate, 1)
		XCTAssertEqual(node3d.layoutBegan, 1)
		XCTAssertEqual(node3d.layoutEnded, 1)

		XCTAssertEqual(node4d.measured, 0)
		XCTAssertEqual(node4d.resolvedSize, 1)
		XCTAssertEqual(node4d.resolvedOrigin, 1)
		XCTAssertEqual(node4d.resolvedInnerSize, 1)
		XCTAssertEqual(node4d.resolvedContentSize, 1)
		XCTAssertEqual(node4d.resolvedMargin, 0)
		XCTAssertEqual(node4d.resolvedBorder, 0)
		XCTAssertEqual(node4d.resolvedPadding, 0)
		XCTAssertEqual(node4d.invalidate, 1)
		XCTAssertEqual(node4d.layoutBegan, 0)
		XCTAssertEqual(node4d.layoutEnded, 0)

		XCTAssertEqual(node5d.measured, 0)
		XCTAssertEqual(node5d.resolvedSize, 1)
		XCTAssertEqual(node5d.resolvedOrigin, 1)
		XCTAssertEqual(node5d.resolvedInnerSize, 1)
		XCTAssertEqual(node5d.resolvedContentSize, 1)
		XCTAssertEqual(node5d.resolvedMargin, 0)
		XCTAssertEqual(node5d.resolvedBorder, 0)
		XCTAssertEqual(node5d.resolvedPadding, 0)
		XCTAssertEqual(node5d.invalidate, 1)
		XCTAssertEqual(node5d.layoutBegan, 0)
		XCTAssertEqual(node5d.layoutEnded, 0)

		XCTAssertEqual(node6d.measured, 0)
		XCTAssertEqual(node6d.resolvedSize, 1)
		XCTAssertEqual(node6d.resolvedOrigin, 1)
		XCTAssertEqual(node6d.resolvedInnerSize, 1)
		XCTAssertEqual(node6d.resolvedContentSize, 1)
		XCTAssertEqual(node6d.resolvedMargin, 0)
		XCTAssertEqual(node6d.resolvedBorder, 0)
		XCTAssertEqual(node6d.resolvedPadding, 0)
		XCTAssertEqual(node6d.invalidate, 1)
		XCTAssertEqual(node6d.layoutBegan, 0)
		XCTAssertEqual(node6d.layoutEnded, 0)
	}

	func testWrappedNodeCallbackCountWithRelayout() {

		let containerd = DisplayNodeDelegateCounter()

		let node1d = DisplayNodeDelegateCounter()
		let node2d = DisplayNodeDelegateCounter()
		let node3d = DisplayNodeDelegateCounter()

		let node4d = DisplayNodeDelegateCounter()
		let node5d = DisplayNodeDelegateCounter()
		let node6d = DisplayNodeDelegateCounter()

		let container = DisplayNode(display: self.display)
		container.id = "CONTAINER"
		container.delegate = containerd
		container.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		container.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 20);
		container.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 20);
		container.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 20);
		container.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: 20);

		let node1 = DisplayNode(display: self.display)
		node1.delegate = node1d
		node1.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		node1.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)

		let node2 = DisplayNode(display: self.display)
		node2.delegate = node2d
		node2.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		node2.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)

		let node3 = DisplayNode(display: self.display)
		node3.delegate = node3d
		node3.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
		node3.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)

		let node4 = DisplayNode(display: self.display)
		node4.delegate = node4d
		node4.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node4.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		let node5 = DisplayNode(display: self.display)
		node5.delegate = node5d
		node5.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node5.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		let node6 = DisplayNode(display: self.display)
		node6.delegate = node6d
		node6.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)
		node6.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: 200)

		container.appendChild(node1)
		container.appendChild(node2)
		container.appendChild(node3)

		node1.appendChild(node4)
		node2.appendChild(node5)
		node3.appendChild(node6)

		self.window.appendChild(container)
		self.window.resolve()

		XCTAssertEqual(container.measuredTop, 0)
		XCTAssertEqual(container.measuredLeft, 0)
		XCTAssertEqual(container.measuredWidth, 200 + 20 + 20)
		XCTAssertEqual(container.measuredHeight, 600 + 20 + 20)

		XCTAssertEqual(node1.measuredTop, 0 + 20)
		XCTAssertEqual(node1.measuredLeft, 0 + 20)
		XCTAssertEqual(node1.measuredWidth, 200)
		XCTAssertEqual(node1.measuredHeight, 200)

		XCTAssertEqual(node2.measuredTop, 200 + 20)
		XCTAssertEqual(node2.measuredLeft, 0 + 20)
		XCTAssertEqual(node2.measuredWidth, 200)
		XCTAssertEqual(node2.measuredHeight, 200)

		XCTAssertEqual(node3.measuredTop, 400 + 20)
		XCTAssertEqual(node3.measuredLeft, 0 + 20)
		XCTAssertEqual(node3.measuredWidth, 200)
		XCTAssertEqual(node3.measuredHeight, 200)

		XCTAssertEqual(node4.measuredTop, 0)
		XCTAssertEqual(node4.measuredLeft, 0)
		XCTAssertEqual(node4.measuredWidth, 200)
		XCTAssertEqual(node4.measuredHeight, 200)

		XCTAssertEqual(node5.measuredTop, 0)
		XCTAssertEqual(node5.measuredLeft, 0)
		XCTAssertEqual(node5.measuredWidth, 200)
		XCTAssertEqual(node5.measuredHeight, 200)

		XCTAssertEqual(node6.measuredTop, 0)
		XCTAssertEqual(node6.measuredLeft, 0)
		XCTAssertEqual(node6.measuredWidth, 200)
		XCTAssertEqual(node6.measuredHeight, 200)

		XCTAssertEqual(containerd.measured, 1)
		XCTAssertEqual(containerd.resolvedSize, 1)
		XCTAssertEqual(containerd.resolvedOrigin, 1)
		XCTAssertEqual(containerd.resolvedInnerSize, 1)
		XCTAssertEqual(containerd.resolvedContentSize, 2) // Called by auto content size
		XCTAssertEqual(containerd.resolvedMargin, 0)
		XCTAssertEqual(containerd.resolvedBorder, 0)
		XCTAssertEqual(containerd.resolvedPadding, 1)
		XCTAssertEqual(containerd.invalidate, 1)
		XCTAssertEqual(containerd.layoutBegan, 2)
		XCTAssertEqual(containerd.layoutEnded, 2)

		XCTAssertEqual(node1d.measured, 1)
		XCTAssertEqual(node1d.resolvedSize, 1)
		XCTAssertEqual(node1d.resolvedOrigin, 2)
		XCTAssertEqual(node1d.resolvedInnerSize, 1)
		XCTAssertEqual(node1d.resolvedContentSize, 1)
		XCTAssertEqual(node1d.resolvedMargin, 0)
		XCTAssertEqual(node1d.resolvedBorder, 0)
		XCTAssertEqual(node1d.resolvedPadding, 0)
		XCTAssertEqual(node1d.invalidate, 1)
		XCTAssertEqual(node1d.layoutBegan, 1)
		XCTAssertEqual(node1d.layoutEnded, 1)

		XCTAssertEqual(node2d.measured, 1)
		XCTAssertEqual(node2d.resolvedSize, 1)
		XCTAssertEqual(node2d.resolvedOrigin, 2)
		XCTAssertEqual(node2d.resolvedInnerSize, 1)
		XCTAssertEqual(node2d.resolvedContentSize, 1)
		XCTAssertEqual(node2d.resolvedMargin, 0)
		XCTAssertEqual(node2d.resolvedBorder, 0)
		XCTAssertEqual(node2d.resolvedPadding, 0)
		XCTAssertEqual(node2d.invalidate, 1)
		XCTAssertEqual(node2d.layoutBegan, 1)
		XCTAssertEqual(node2d.layoutEnded, 1)

		XCTAssertEqual(node3d.measured, 1)
		XCTAssertEqual(node3d.resolvedSize, 1)
		XCTAssertEqual(node3d.resolvedOrigin, 2)
		XCTAssertEqual(node3d.resolvedInnerSize, 1)
		XCTAssertEqual(node3d.resolvedContentSize, 1)
		XCTAssertEqual(node3d.resolvedMargin, 0)
		XCTAssertEqual(node3d.resolvedBorder, 0)
		XCTAssertEqual(node3d.resolvedPadding, 0)
		XCTAssertEqual(node3d.invalidate, 1)
		XCTAssertEqual(node3d.layoutBegan, 1)
		XCTAssertEqual(node3d.layoutEnded, 1)

		XCTAssertEqual(node4d.measured, 0)
		XCTAssertEqual(node4d.resolvedSize, 1)
		XCTAssertEqual(node4d.resolvedOrigin, 1)
		XCTAssertEqual(node4d.resolvedInnerSize, 1)
		XCTAssertEqual(node4d.resolvedContentSize, 1)
		XCTAssertEqual(node4d.resolvedMargin, 0)
		XCTAssertEqual(node4d.resolvedBorder, 0)
		XCTAssertEqual(node4d.resolvedPadding, 0)
		XCTAssertEqual(node4d.invalidate, 1)
		XCTAssertEqual(node4d.layoutBegan, 0)
		XCTAssertEqual(node4d.layoutEnded, 0)

		XCTAssertEqual(node5d.measured, 0)
		XCTAssertEqual(node5d.resolvedSize, 1)
		XCTAssertEqual(node5d.resolvedOrigin, 1)
		XCTAssertEqual(node5d.resolvedInnerSize, 1)
		XCTAssertEqual(node5d.resolvedContentSize, 1)
		XCTAssertEqual(node5d.resolvedMargin, 0)
		XCTAssertEqual(node5d.resolvedBorder, 0)
		XCTAssertEqual(node5d.resolvedPadding, 0)
		XCTAssertEqual(node5d.invalidate, 1)
		XCTAssertEqual(node5d.layoutBegan, 0)
		XCTAssertEqual(node5d.layoutEnded, 0)

		XCTAssertEqual(node6d.measured, 0)
		XCTAssertEqual(node6d.resolvedSize, 1)
		XCTAssertEqual(node6d.resolvedOrigin, 1)
		XCTAssertEqual(node6d.resolvedInnerSize, 1)
		XCTAssertEqual(node6d.resolvedContentSize, 1)
		XCTAssertEqual(node6d.resolvedMargin, 0)
		XCTAssertEqual(node6d.resolvedBorder, 0)
		XCTAssertEqual(node6d.resolvedPadding, 0)
		XCTAssertEqual(node6d.invalidate, 1)
		XCTAssertEqual(node6d.layoutBegan, 0)
		XCTAssertEqual(node6d.layoutEnded, 0)
	}
}
