package ca.logaritm.dezel.view

import ca.logaritm.dezel.view.display.*
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class DisplayNodeRelativeLayoutTest {

	companion object {
		init {
			System.loadLibrary("dezel")
		}
	}

	lateinit var display: Display
	lateinit var window: DisplayNode

	@Before
	fun beforeTest() {

		this.display = Display()
		this.display.setViewportWidth(320.0f)
		this.display.setViewportHeight(480.0f)

		this.window = DisplayNode(this.display)
		this.window.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 320.0)
		this.window.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 480.0)
		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 320.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 480.0)
		this.window.id = "Window"

		this.display.setWindow(this.window)
	}

	@Test
	fun testWindowSize() {

		this.window.resolve()

		Assert.assertEquals(this.window.measuredTop, 0.0, 0.0)
		Assert.assertEquals(this.window.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(this.window.measuredRight, 0.0, 0.0)
		Assert.assertEquals(this.window.measuredBottom, 0.0, 0.0)

		Assert.assertEquals(this.window.measuredWidth, 320.0, 0.0)
		Assert.assertEquals(this.window.measuredHeight, 480.0, 0.0)
		Assert.assertEquals(this.window.measuredInnerWidth, 320.0, 0.0)
		Assert.assertEquals(this.window.measuredInnerHeight, 480.0, 0.0)
		Assert.assertEquals(this.window.measuredContentWidth, 320.0, 0.0)
		Assert.assertEquals(this.window.measuredContentHeight, 480.0, 0.0)
	}

	@Test
	fun testNodeMarginInPX() {

		val node = DisplayNode(this.display)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 40.0)
		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 20.0 - 30.0, 0.0)
		Assert.assertEquals(node.measuredHeight, 40.0, 0.0)

		Assert.assertEquals(node.measuredTop, 10.0, 0.0)
		Assert.assertEquals(node.measuredLeft, 20.0, 0.0)
		Assert.assertEquals(node.measuredRight, 30.0, 0.0)
		Assert.assertEquals(node.measuredBottom, 480.0 - 40.0 - 10.0, 0.0)

		Assert.assertEquals(node.measuredMarginTop, 10.0, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 20.0, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 30.0, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 40.0, 0.0)
	}

	@Test
	fun testNodeMarginInPC() {

		val node = DisplayNode(this.display)
		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPC, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPC, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPC, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 480.0 * 0.4, 0.0)

		Assert.assertEquals(node.measuredTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 480.0 * 0.4, 0.0)

		Assert.assertEquals(node.measuredWidth, 320.0 * (0.2 + 0.3), 0.0)
		Assert.assertEquals(node.measuredHeight, 480.0 * (0.1 + 0.4), 0.0)
	}

	@Test
	fun testNodeMarginInVW() {

		val node = DisplayNode(this.display)
		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 320.0 * 0.4, 0.0)

		Assert.assertEquals(node.measuredTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 320.0 * 0.4, 0.0)
	}

	@Test
	fun testNodeMarginInVH() {

		val node = DisplayNode(this.display)
		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 480.0 * 0.4, 0.0)

		Assert.assertEquals(node.measuredTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 480.0 * 0.4, 0.0)
	}

	@Test
	fun testNodeWidthInPX() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 100.0, 0.0)
	}

	@Test
	fun testNodeWidthInPC() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPC, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInVW() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitVW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInVH() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitVH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 480.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthUsingFill() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
		node.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0, 0.0)
	}

	@Test
	fun testNodeHeightUsingFill() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
		node.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0, 0.0)
	}

	@Test
	fun testNodeBorderInPX() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 150.0)

		node.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 10.0)
		node.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 20.0)
		node.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 30.0)
		node.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 10.0, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 20.0, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 30.0, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 40.0, 0.0)
	}

	@Test
	fun testNodeBorderInPC() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 150.0)

		node.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, 10.0)
		node.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, 20.0)
		node.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, 30.0)
		node.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 150.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 100.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 100.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 150.0 * 0.4, 0.0)
	}

	@Test
	fun testNodeBorderInVW() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 150.0)

		node.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVW, 10.0)
		node.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVW, 20.0)
		node.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVW, 30.0)
		node.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 320.0 * 0.4, 0.0)
	}

	@Test
	fun testNodeBorderInVH() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 150.0)
		node.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVH, 10.0)
		node.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVH, 20.0)
		node.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVH, 30.0)
		node.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 480.0 * 0.4, 0.0)
	}

	@Test
	fun testNodePaddingInPX() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 150.0)

		node.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 10.0)
		node.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 20.0)
		node.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 30.0)
		node.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 10.0, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 20.0, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 30.0, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 40.0, 0.0)
	}

	@Test
	fun testNodePaddingInPC() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 150.0)

		node.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, 10.0)
		node.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, 20.0)
		node.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, 30.0)
		node.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 150.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 100.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 100.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 150.0 * 0.4, 0.0)
	}

	@Test
	fun testNodePaddingInVW() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 150.0)

		node.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, 10.0)
		node.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, 20.0)
		node.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, 30.0)
		node.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 320.0 * 0.4, 0.0)
	}

	@Test
	fun testNodePaddingInVH() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 150.0)

		node.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, 10.0)
		node.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, 20.0)
		node.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, 30.0)
		node.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 480.0 * 0.4, 0.0)
	}

	@Test
	fun testAnchorInPC() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		node.setAnchorTop(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, 50.0)
		node.setAnchorLeft(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, -100.0, 0.0)
		Assert.assertEquals(node.measuredLeft, -100.0, 0.0)
	}

	@Test
	fun testScaling() {

		val node = DisplayNode(this.display)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPC, 33.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPC, 33.0)

		this.display.setScale(2f)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node.measuredWidth, 105.5, 0.0)
		Assert.assertEquals(node.measuredHeight, 158.5, 0.0)
	}

	@Test
	fun testPositionInVerticalLayout() {

		val node1 = DisplayNode(this.display)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)

		val node2 = DisplayNode(this.display)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		this.window.appendChild(node1)
		this.window.appendChild(node2)
		this.window.resolve()

		Assert.assertEquals(node1.measuredWidth, 320.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 100.0, 0.0)
		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredRight, 0.0, 0.0)
		Assert.assertEquals(node1.measuredBottom, 480.0 - 100.0, 0.0)

		Assert.assertEquals(node2.measuredWidth, 320.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
		Assert.assertEquals(node2.measuredTop, 100.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredRight, 0.0, 0.0)
		Assert.assertEquals(node2.measuredBottom, 480.0 - 200.0 - 100.0, 0.0)
	}

	@Test
	fun testPositionInHorizontalLayout() {

		val node1 = DisplayNode(this.display)
		node1.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)

		val node2 = DisplayNode(this.display)
		node2.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		this.window.setContentDirection(kDisplayNodeContentDirectionHorizontal)
		this.window.appendChild(node1)
		this.window.appendChild(node2)
		this.window.resolve()

		Assert.assertEquals(node1.measuredWidth, 100.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 480.0, 0.0)
		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredRight, 320.0 - 100.0, 0.0)
		Assert.assertEquals(node1.measuredBottom, 0.0, 0.0)

		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 480.0, 0.0)
		Assert.assertEquals(node2.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 100.0, 0.0)
		Assert.assertEquals(node2.measuredRight, 320.0 - 200.0 - 100.0, 0.0)
		Assert.assertEquals(node2.measuredBottom, 0.0, 0.0)
	}

	@Test
	fun testPercentageCarrying() {

		this.window.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 320.0)
		this.window.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 485.0)

		this.display.setViewportWidth(320f)
		this.display.setViewportHeight(480f)
		this.display.setScale(2f)

		val node1 = DisplayNode(this.display)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPC, 33.3333)

		val node2 = DisplayNode(this.display)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPC, 33.3333)

		val node3 = DisplayNode(this.display)
		node3.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPC, 33.3333)

		this.window.appendChild(node1)
		this.window.appendChild(node2)
		this.window.appendChild(node3)
		this.window.resolve()

		Assert.assertEquals(node1.measuredHeight, 161.5, 0.0)
		Assert.assertEquals(node2.measuredHeight, 162.0, 0.0)
		Assert.assertEquals(node3.measuredHeight, 161.5, 0.0)
	}

	@Test
	fun testContentSizeAutoMeasurement() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitNone, 200.0)
		container.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitNone, 200.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredContentWidth, 200.0, 0.0)
		Assert.assertEquals(container.measuredContentHeight, 400.0, 0.0)

	}

	@Test
	fun testWrappingFromContentSize() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0, 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappingFromContentSizeWithMin() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setMinWidth(250.0)
		container.setMinHeight(450.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 250.0, 0.0)
		Assert.assertEquals(container.measuredHeight, 450.0, 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappingFromContentSizeWithMax() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setMaxWidth(150.0)
		container.setMaxHeight(350.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 150.0, 0.0)
		Assert.assertEquals(container.measuredHeight, 350.0, 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappingFromContentSizeAndPadding() {

		val container = DisplayNode(this.display)

		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 10.0)
		container.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 20.0)
		container.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 30.0)
		container.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 40.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + 20.0 + 30.0, 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + 10.0 + 40.0, 0.0)

		Assert.assertEquals(node1.measuredTop, 10.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 20.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 10.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 20.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappingFromContentSizeAndMargin() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 30.0)
		node1.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 20.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 50.0)
		node2.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 40.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + 50.0, 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + 20.0 + 40.0, 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 20.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodePaddingInPX() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 20.0)
		container.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 40.0)
		container.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 60.0)
		container.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredPaddingTop, 20.0, 0.0)
		Assert.assertEquals(container.measuredPaddingLeft, 40.0, 0.0)
		Assert.assertEquals(container.measuredPaddingRight, 60.0, 0.0)
		Assert.assertEquals(container.measuredPaddingBottom, 80.0, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + 40.0 + 60.0, 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + 20.0 + 80.0, 0.0)

		Assert.assertEquals(node1.measuredTop, 20.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 40.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 20.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 40.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodePaddingInPC() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, 20.0)
		container.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, 40.0)
		container.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, 60.0)
		container.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredPaddingTop, 400.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredPaddingLeft, 200.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredPaddingRight, 200.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredPaddingBottom, 400.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (200.0 * 0.4) + (200.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (400.0 * 0.2) + (400.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 400.0 * 0.2, 0.0)
		Assert.assertEquals(node1.measuredLeft, 200.0 * 0.4, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 400.0 * 0.2, 0.0)
		Assert.assertEquals(node2.measuredLeft, 200.0 * 0.4, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodePaddingInVW() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, 20.0)
		container.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, 40.0)
		container.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, 60.0)
		container.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredPaddingTop, 320.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredPaddingLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredPaddingRight, 320.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredPaddingBottom, 320.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (320.0 * 0.4) + (320.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (320.0 * 0.2) + (320.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node1.measuredLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 320.0 * 0.2, 0.0)
		Assert.assertEquals(node2.measuredLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodePaddingInVH() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, 20.0)
		container.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, 40.0)
		container.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, 60.0)
		container.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredPaddingTop, 480.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredPaddingLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredPaddingRight, 480.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredPaddingBottom, 480.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (480.0 * 0.4) + (480.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (480.0 * 0.2) + (480.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node1.measuredLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 480.0 * 0.2, 0.0)
		Assert.assertEquals(node2.measuredLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodePaddingInPW() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, 20.0)
		container.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, 40.0)
		container.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, 60.0)
		container.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredPaddingTop, 320.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredPaddingLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredPaddingRight, 320.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredPaddingBottom, 320.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (320.0 * 0.4) + (320.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (320.0 * 0.2) + (320.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node1.measuredLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 320.0 * 0.2, 0.0)
		Assert.assertEquals(node2.measuredLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodePaddingInPH() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, 20.0)
		container.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, 40.0)
		container.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, 60.0)
		container.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredPaddingTop, 480.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredPaddingLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredPaddingRight, 480.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredPaddingBottom, 480.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (480.0 * 0.4) + (480.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (480.0 * 0.2) + (480.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node1.measuredLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 480.0 * 0.2, 0.0)
		Assert.assertEquals(node2.measuredLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodePaddingInCW() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, 20.0)
		container.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, 40.0)
		container.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, 60.0)
		container.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredPaddingTop, 320.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredPaddingLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredPaddingRight, 320.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredPaddingBottom, 320.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (320.0 * 0.4) + (320.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (320.0 * 0.2) + (320.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node1.measuredLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 320.0 * 0.2, 0.0)
		Assert.assertEquals(node2.measuredLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodePaddingInCH() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, 20.0)
		container.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, 40.0)
		container.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, 60.0)
		container.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredPaddingTop, 480.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredPaddingLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredPaddingRight, 480.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredPaddingBottom, 480.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (480.0 * 0.4) + (480.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (480.0 * 0.2) + (480.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node1.measuredLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 480.0 * 0.2, 0.0)
		Assert.assertEquals(node2.measuredLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodeBorderInPX() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 20.0)
		container.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 40.0)
		container.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 60.0)
		container.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredBorderTop, 20.0, 0.0)
		Assert.assertEquals(container.measuredBorderLeft, 40.0, 0.0)
		Assert.assertEquals(container.measuredBorderRight, 60.0, 0.0)
		Assert.assertEquals(container.measuredBorderBottom, 80.0, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + 40.0 + 60.0, 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + 20.0 + 80.0, 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodeBorderInPC() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, 20.0)
		container.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, 40.0)
		container.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, 60.0)
		container.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredBorderTop, 400.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredBorderLeft, 200.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredBorderRight, 200.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredBorderBottom, 400.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (200.0 * 0.4) + (200.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (400.0 * 0.2) + (400.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodeBorderInPW() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, 20.0)
		container.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, 40.0)
		container.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, 60.0)
		container.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredBorderTop, 320.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredBorderLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredBorderRight, 320.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredBorderBottom, 320.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (320.0 * 0.4) + (320.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (320.0 * 0.2) + (320.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodeBorderInPH() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, 20.0)
		container.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, 40.0)
		container.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, 60.0)
		container.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredBorderTop, 480.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredBorderLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredBorderRight, 480.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredBorderBottom, 480.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (480.0 * 0.4) + (480.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (480.0 * 0.2) + (480.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodeBorderInCW() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, 20.0)
		container.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, 40.0)
		container.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, 60.0)
		container.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredBorderTop, 320.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredBorderLeft, 320.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredBorderRight, 320.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredBorderBottom, 320.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (320.0 * 0.4) + (320.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (320.0 * 0.2) + (320.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodeBorderInCH() {

		val container = DisplayNode(this.display)
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, 20.0)
		container.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, 40.0)
		container.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, 60.0)
		container.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, 80.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredBorderTop, 480.0 * 0.2, 0.0)
		Assert.assertEquals(container.measuredBorderLeft, 480.0 * 0.4, 0.0)
		Assert.assertEquals(container.measuredBorderRight, 480.0 * 0.6, 0.0)
		Assert.assertEquals(container.measuredBorderBottom, 480.0 * 0.8, 0.0)

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + (480.0 * 0.4) + (480.0 * 0.6), 0.0)
		Assert.assertEquals(container.measuredHeight, 400.0 + (480.0 * 0.2) + (480.0 * 0.8), 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)
	}

	@Test
	fun testWrappedNodeCallbackCount() {

		val containerd = DisplayNodeListenerCounter()

		val node1d = DisplayNodeListenerCounter()
		val node2d = DisplayNodeListenerCounter()
		val node3d = DisplayNodeListenerCounter()

		val node4d = DisplayNodeListenerCounter()
		val node5d = DisplayNodeListenerCounter()
		val node6d = DisplayNodeListenerCounter()

		val container = DisplayNode(this.display)
		container.listener = containerd
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)

		val node1 = DisplayNode(this.display)
		node1.listener = node1d
		node1.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		node1.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)

		val node2 = DisplayNode(this.display)
		node2.listener = node2d
		node2.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		node2.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)

		val node3 = DisplayNode(this.display)
		node3.listener = node3d
		node3.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		node3.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)

		val node4 = DisplayNode(this.display)
		node4.listener = node4d
		node4.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node4.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node5 = DisplayNode(this.display)
		node5.listener = node5d
		node5.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node5.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node6 = DisplayNode(this.display)
		node6.listener = node6d
		node6.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node6.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)
		container.appendChild(node3)

		node1.appendChild(node4)
		node2.appendChild(node5)
		node3.appendChild(node6)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(container.measuredHeight, 600.0, 0.0)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node3.measuredTop, 400.0, 0.0)
		Assert.assertEquals(node3.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node3.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node3.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node4.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node4.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node4.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node4.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node5.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node5.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node5.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node5.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node6.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node6.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node6.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node6.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(containerd.measured, 1)
		Assert.assertEquals(containerd.resolvedSize, 1)
		Assert.assertEquals(containerd.resolvedOrigin, 1)
		Assert.assertEquals(containerd.resolvedInnerSize, 1)
		Assert.assertEquals(containerd.resolvedContentSize, 1)
		Assert.assertEquals(containerd.resolvedMargin, 0)
		Assert.assertEquals(containerd.resolvedBorder, 0)
		Assert.assertEquals(containerd.resolvedPadding, 0)
		Assert.assertEquals(containerd.invalidate, 1)
		Assert.assertEquals(containerd.layoutBegan, 1)
		Assert.assertEquals(containerd.layoutEnded, 1)

		Assert.assertEquals(node1d.measured, 1)
		Assert.assertEquals(node1d.resolvedSize, 1)
		Assert.assertEquals(node1d.resolvedOrigin, 1)
		Assert.assertEquals(node1d.resolvedInnerSize, 1)
		Assert.assertEquals(node1d.resolvedContentSize, 1)
		Assert.assertEquals(node1d.resolvedMargin, 0)
		Assert.assertEquals(node1d.resolvedBorder, 0)
		Assert.assertEquals(node1d.resolvedPadding, 0)
		Assert.assertEquals(node1d.invalidate, 1)
		Assert.assertEquals(node1d.layoutBegan, 1)
		Assert.assertEquals(node1d.layoutEnded, 1)

		Assert.assertEquals(node2d.measured, 1)
		Assert.assertEquals(node2d.resolvedSize, 1)
		Assert.assertEquals(node2d.resolvedOrigin, 1)
		Assert.assertEquals(node2d.resolvedInnerSize, 1)
		Assert.assertEquals(node2d.resolvedContentSize, 1)
		Assert.assertEquals(node2d.resolvedMargin, 0)
		Assert.assertEquals(node2d.resolvedBorder, 0)
		Assert.assertEquals(node2d.resolvedPadding, 0)
		Assert.assertEquals(node2d.invalidate, 1)
		Assert.assertEquals(node2d.layoutBegan, 1)
		Assert.assertEquals(node2d.layoutEnded, 1)

		Assert.assertEquals(node3d.measured, 1)
		Assert.assertEquals(node3d.resolvedSize, 1)
		Assert.assertEquals(node3d.resolvedOrigin, 1)
		Assert.assertEquals(node3d.resolvedInnerSize, 1)
		Assert.assertEquals(node3d.resolvedContentSize, 1)
		Assert.assertEquals(node3d.resolvedMargin, 0)
		Assert.assertEquals(node3d.resolvedBorder, 0)
		Assert.assertEquals(node3d.resolvedPadding, 0)
		Assert.assertEquals(node3d.invalidate, 1)
		Assert.assertEquals(node3d.layoutBegan, 1)
		Assert.assertEquals(node3d.layoutEnded, 1)

		Assert.assertEquals(node4d.measured, 0)
		Assert.assertEquals(node4d.resolvedSize, 1)
		Assert.assertEquals(node4d.resolvedOrigin, 1)
		Assert.assertEquals(node4d.resolvedInnerSize, 1)
		Assert.assertEquals(node4d.resolvedContentSize, 1)
		Assert.assertEquals(node4d.resolvedMargin, 0)
		Assert.assertEquals(node4d.resolvedBorder, 0)
		Assert.assertEquals(node4d.resolvedPadding, 0)
		Assert.assertEquals(node4d.invalidate, 1)
		Assert.assertEquals(node4d.layoutBegan, 0)
		Assert.assertEquals(node4d.layoutEnded, 0)

		Assert.assertEquals(node5d.measured, 0)
		Assert.assertEquals(node5d.resolvedSize, 1)
		Assert.assertEquals(node5d.resolvedOrigin, 1)
		Assert.assertEquals(node5d.resolvedInnerSize, 1)
		Assert.assertEquals(node5d.resolvedContentSize, 1)
		Assert.assertEquals(node5d.resolvedMargin, 0)
		Assert.assertEquals(node5d.resolvedBorder, 0)
		Assert.assertEquals(node5d.resolvedPadding, 0)
		Assert.assertEquals(node5d.invalidate, 1)
		Assert.assertEquals(node5d.layoutBegan, 0)
		Assert.assertEquals(node5d.layoutEnded, 0)

		Assert.assertEquals(node6d.measured, 0)
		Assert.assertEquals(node6d.resolvedSize, 1)
		Assert.assertEquals(node6d.resolvedOrigin, 1)
		Assert.assertEquals(node6d.resolvedInnerSize, 1)
		Assert.assertEquals(node6d.resolvedContentSize, 1)
		Assert.assertEquals(node6d.resolvedMargin, 0)
		Assert.assertEquals(node6d.resolvedBorder, 0)
		Assert.assertEquals(node6d.resolvedPadding, 0)
		Assert.assertEquals(node6d.invalidate, 1)
		Assert.assertEquals(node6d.layoutBegan, 0)
		Assert.assertEquals(node6d.layoutEnded, 0)
	}

	@Test
	fun testWrappedNodeCallbackCountWithRelayout() {

		val containerd = DisplayNodeListenerCounter()

		val node1d = DisplayNodeListenerCounter()
		val node2d = DisplayNodeListenerCounter()
		val node3d = DisplayNodeListenerCounter()

		val node4d = DisplayNodeListenerCounter()
		val node5d = DisplayNodeListenerCounter()
		val node6d = DisplayNodeListenerCounter()

		val container = DisplayNode(this.display)
		container.id = "CONTAINER"
		container.listener = containerd
		container.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		container.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 20.0)
		container.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 20.0)
		container.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 20.0)
		container.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, 20.0)

		val node1 = DisplayNode(this.display)
		node1.listener = node1d
		node1.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		node1.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)

		val node2 = DisplayNode(this.display)
		node2.listener = node2d
		node2.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		node2.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)

		val node3 = DisplayNode(this.display)
		node3.listener = node3d
		node3.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
		node3.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)

		val node4 = DisplayNode(this.display)
		node4.listener = node4d
		node4.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node4.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node5 = DisplayNode(this.display)
		node5.listener = node5d
		node5.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node5.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		val node6 = DisplayNode(this.display)
		node6.listener = node6d
		node6.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node6.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)
		container.appendChild(node3)

		node1.appendChild(node4)
		node2.appendChild(node5)
		node3.appendChild(node6)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.0)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(container.measuredWidth, 200.0 + 20.0 + 20.0, 0.0)
		Assert.assertEquals(container.measuredHeight, 600.0 + 20.0 + 20.0, 0.0)

		Assert.assertEquals(node1.measuredTop, 0 + 20.0, 0.0)
		Assert.assertEquals(node1.measuredLeft, 0 + 20.0, 0.0)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node2.measuredTop, 200.0 + 20.0, 0.0)
		Assert.assertEquals(node2.measuredLeft, 0 + 20.0, 0.0)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node3.measuredTop, 400.0 + 20.0, 0.0)
		Assert.assertEquals(node3.measuredLeft, 0 + 20.0, 0.0)
		Assert.assertEquals(node3.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node3.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node4.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node4.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node4.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node4.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node5.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node5.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node5.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node5.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(node6.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node6.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node6.measuredWidth, 200.0, 0.0)
		Assert.assertEquals(node6.measuredHeight, 200.0, 0.0)

		Assert.assertEquals(containerd.measured, 1)
		Assert.assertEquals(containerd.resolvedSize, 1)
		Assert.assertEquals(containerd.resolvedOrigin, 1)
		Assert.assertEquals(containerd.resolvedInnerSize, 1)
		Assert.assertEquals(containerd.resolvedContentSize, 2) // Called by auto content size
		Assert.assertEquals(containerd.resolvedMargin, 0)
		Assert.assertEquals(containerd.resolvedBorder, 0)
		Assert.assertEquals(containerd.resolvedPadding, 1)
		Assert.assertEquals(containerd.invalidate, 1)
		Assert.assertEquals(containerd.layoutBegan, 2)
		Assert.assertEquals(containerd.layoutEnded, 2)

		Assert.assertEquals(node1d.measured, 1)
		Assert.assertEquals(node1d.resolvedSize, 1)
		Assert.assertEquals(node1d.resolvedOrigin, 2)
		Assert.assertEquals(node1d.resolvedInnerSize, 1)
		Assert.assertEquals(node1d.resolvedContentSize, 1)
		Assert.assertEquals(node1d.resolvedMargin, 0)
		Assert.assertEquals(node1d.resolvedBorder, 0)
		Assert.assertEquals(node1d.resolvedPadding, 0)
		Assert.assertEquals(node1d.invalidate, 1)
		Assert.assertEquals(node1d.layoutBegan, 1)
		Assert.assertEquals(node1d.layoutEnded, 1)

		Assert.assertEquals(node2d.measured, 1)
		Assert.assertEquals(node2d.resolvedSize, 1)
		Assert.assertEquals(node2d.resolvedOrigin, 2)
		Assert.assertEquals(node2d.resolvedInnerSize, 1)
		Assert.assertEquals(node2d.resolvedContentSize, 1)
		Assert.assertEquals(node2d.resolvedMargin, 0)
		Assert.assertEquals(node2d.resolvedBorder, 0)
		Assert.assertEquals(node2d.resolvedPadding, 0)
		Assert.assertEquals(node2d.invalidate, 1)
		Assert.assertEquals(node2d.layoutBegan, 1)
		Assert.assertEquals(node2d.layoutEnded, 1)

		Assert.assertEquals(node3d.measured, 1)
		Assert.assertEquals(node3d.resolvedSize, 1)
		Assert.assertEquals(node3d.resolvedOrigin, 2)
		Assert.assertEquals(node3d.resolvedInnerSize, 1)
		Assert.assertEquals(node3d.resolvedContentSize, 1)
		Assert.assertEquals(node3d.resolvedMargin, 0)
		Assert.assertEquals(node3d.resolvedBorder, 0)
		Assert.assertEquals(node3d.resolvedPadding, 0)
		Assert.assertEquals(node3d.invalidate, 1)
		Assert.assertEquals(node3d.layoutBegan, 1)
		Assert.assertEquals(node3d.layoutEnded, 1)

		Assert.assertEquals(node4d.measured, 0)
		Assert.assertEquals(node4d.resolvedSize, 1)
		Assert.assertEquals(node4d.resolvedOrigin, 1)
		Assert.assertEquals(node4d.resolvedInnerSize, 1)
		Assert.assertEquals(node4d.resolvedContentSize, 1)
		Assert.assertEquals(node4d.resolvedMargin, 0)
		Assert.assertEquals(node4d.resolvedBorder, 0)
		Assert.assertEquals(node4d.resolvedPadding, 0)
		Assert.assertEquals(node4d.invalidate, 1)
		Assert.assertEquals(node4d.layoutBegan, 0)
		Assert.assertEquals(node4d.layoutEnded, 0)

		Assert.assertEquals(node5d.measured, 0)
		Assert.assertEquals(node5d.resolvedSize, 1)
		Assert.assertEquals(node5d.resolvedOrigin, 1)
		Assert.assertEquals(node5d.resolvedInnerSize, 1)
		Assert.assertEquals(node5d.resolvedContentSize, 1)
		Assert.assertEquals(node5d.resolvedMargin, 0)
		Assert.assertEquals(node5d.resolvedBorder, 0)
		Assert.assertEquals(node5d.resolvedPadding, 0)
		Assert.assertEquals(node5d.invalidate, 1)
		Assert.assertEquals(node5d.layoutBegan, 0)
		Assert.assertEquals(node5d.layoutEnded, 0)

		Assert.assertEquals(node6d.measured, 0)
		Assert.assertEquals(node6d.resolvedSize, 1)
		Assert.assertEquals(node6d.resolvedOrigin, 1)
		Assert.assertEquals(node6d.resolvedInnerSize, 1)
		Assert.assertEquals(node6d.resolvedContentSize, 1)
		Assert.assertEquals(node6d.resolvedMargin, 0)
		Assert.assertEquals(node6d.resolvedBorder, 0)
		Assert.assertEquals(node6d.resolvedPadding, 0)
		Assert.assertEquals(node6d.invalidate, 1)
		Assert.assertEquals(node6d.layoutBegan, 0)
		Assert.assertEquals(node6d.layoutEnded, 0)
	}
}