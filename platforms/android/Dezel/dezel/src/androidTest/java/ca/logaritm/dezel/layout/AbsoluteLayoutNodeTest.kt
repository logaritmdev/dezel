package ca.logaritm.dezel.layout

import ca.logaritm.dezel.view.display.*
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class AbsoluteDisplayNodeTest {

	lateinit var display: Display
	lateinit var window: DisplayNode

	@Before
	fun beforeTest() {

		this.display = Display()

		this.window = DisplayNode(this.display)
		this.window.setWidth(kSizeTypeLength, kSizeUnitPX, 320.0)
		this.window.setHeight(kSizeTypeLength, kSizeUnitPX, 480.0)

		this.display.window = this.window
		this.display.viewportWidth = 320.0
		this.display.viewportHeight = 480.0
	}
			
	@Test
	fun testNodePositionInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 10.0, 0.001)
		Assert.assertEquals(node.measuredLeft, 20.0, 0.001)
		Assert.assertEquals(node.measuredRight, 30.0, 0.001)
		Assert.assertEquals(node.measuredBottom, 40.0, 0.001)
	}
	
	@Test
	fun testNodePositionInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPC, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPC, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPC, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitVW, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitVW, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitVW, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitVH, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitVH, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitVH, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPW, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPW, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPW, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInPH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPH, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPH, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPH, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInCW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitCW, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitCW, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitCW, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitCW, 40.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 3200 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 3200 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 3200 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 3200 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInCH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitCH, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitCH, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitCH, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitCH, 40.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 4800 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 4800 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 4800 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 4800 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)

		node.setMarginTop(kMarginTypeLength, kMarginUnitPX, 10.0)
		node.setMarginLeft(kMarginTypeLength, kMarginUnitPX, 20.0)
		node.setMarginRight(kMarginTypeLength, kMarginUnitPX, 30.0)
		node.setMarginBottom(kMarginTypeLength, kMarginUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 10.0, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 20.0, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 30.0, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 40.0, 0.001)

		Assert.assertEquals(node.measuredTop, 10 + 10.0, 0.001)
		Assert.assertEquals(node.measuredLeft, 20 + 20.0, 0.001)
		Assert.assertEquals(node.measuredRight, 30 + 30.0, 0.001)
		Assert.assertEquals(node.measuredBottom, 40 + 40.0, 0.001)
	}

	@Test
	fun testNodeMarginInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)

		node.setMarginTop(kMarginTypeLength, kMarginUnitPC, 10.0)
		node.setMarginLeft(kMarginTypeLength, kMarginUnitPC, 20.0)
		node.setMarginRight(kMarginTypeLength, kMarginUnitPC, 30.0)
		node.setMarginBottom(kMarginTypeLength, kMarginUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 480 * 0.4, 0.001)

		Assert.assertEquals(node.measuredTop, 10 + 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 20 + 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 30 + 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 40 + 480 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)

		node.setMarginTop(kMarginTypeLength, kMarginUnitVW, 10.0)
		node.setMarginLeft(kMarginTypeLength, kMarginUnitVW, 20.0)
		node.setMarginRight(kMarginTypeLength, kMarginUnitVW, 30.0)
		node.setMarginBottom(kMarginTypeLength, kMarginUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 10 + 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 20 + 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 30 + 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 40 + 320 * 0.4, 0.001)

		Assert.assertEquals(node.measuredMarginTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)

		node.setMarginTop(kMarginTypeLength, kMarginUnitVH, 10.0)
		node.setMarginLeft(kMarginTypeLength, kMarginUnitVH, 20.0)
		node.setMarginRight(kMarginTypeLength, kMarginUnitVH, 30.0)
		node.setMarginBottom(kMarginTypeLength, kMarginUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 10 + 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 20 + 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 30 + 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 40 + 480 * 0.4, 0.001)

		Assert.assertEquals(node.measuredMarginTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setMarginTop(kMarginTypeLength, kMarginUnitPW, 10.0)
		node.setMarginLeft(kMarginTypeLength, kMarginUnitPW, 20.0)
		node.setMarginRight(kMarginTypeLength, kMarginUnitPW, 30.0)
		node.setMarginBottom(kMarginTypeLength, kMarginUnitPW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInPH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setMarginTop(kMarginTypeLength, kMarginUnitPH, 10.0)
		node.setMarginLeft(kMarginTypeLength, kMarginUnitPH, 20.0)
		node.setMarginRight(kMarginTypeLength, kMarginUnitPH, 30.0)
		node.setMarginBottom(kMarginTypeLength, kMarginUnitPH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInCW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setMarginTop(kMarginTypeLength, kMarginUnitCW, 10.0)
		node.setMarginLeft(kMarginTypeLength, kMarginUnitCW, 20.0)
		node.setMarginRight(kMarginTypeLength, kMarginUnitCW, 30.0)
		node.setMarginBottom(kMarginTypeLength, kMarginUnitCW, 40.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 3200 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 3200 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 3200 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 3200 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInCH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setMarginTop(kMarginTypeLength, kMarginUnitCH, 10.0)
		node.setMarginLeft(kMarginTypeLength, kMarginUnitCH, 20.0)
		node.setMarginRight(kMarginTypeLength, kMarginUnitCH, 30.0)
		node.setMarginBottom(kMarginTypeLength, kMarginUnitCH, 40.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 4800 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 4800 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 4800 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 4800 * 0.4, 0.001)
	}

	@Test
	fun testNodeWidthInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 100.0, 0.001)
	}

	@Test
	fun testNodeWidthInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPC, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitVW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitVH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInPH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInCW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitCW, 50.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 3200 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInCH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitCH, 50.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 4800 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthUsingFill() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0, 0.001)
	}

	@Test
	fun testNodeWidthUsingFillAndLeftPosition() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 10.0, 0.001)
	}

	@Test
	fun testNodeWidthUsingFillAndRightPosition() {

		val node = DisplayNode(this.display)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 30.0, 0.001)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPX() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 20 - 30.0, 0.001)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPC() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitPC, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPC, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - (320 * 0.2) - (320 * 0.3), 0.001)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInVW() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitVW, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitVW, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - (320 * 0.2) - (320 * 0.3), 0.001)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInVH() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitVH, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitVH, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - (480 * 0.2) - (480 * 0.3), 0.001)
	}

	@Test
	fun testNodeWidthtShouldBeMeasuredFromLeftAndRightInsteadOfLength() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 20 - 30.0, 0.001)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPXIncludingNegativeMargins() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setMarginLeft(kMarginTypeLength, kMarginUnitPX, -20.0)
		node.setMarginRight(kMarginTypeLength, kMarginUnitPX, -30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 50 + 50.0, 0.001) // 320 - (20 + 30.0) + (20 + 30.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPXIncludingPositiveMargins() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setMarginLeft(kMarginTypeLength, kMarginUnitPX, 20.0)
		node.setMarginRight(kMarginTypeLength, kMarginUnitPX, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 50 - 50.0, 0.001) // 320 - (20 + 30.0) - (20 + 30.0)
	}

	@Test
	fun testNodeHeightInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 100.0, 0.001)
	}

	@Test
	fun testNodeHeightInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPC, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitVW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitVH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInPH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInCW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitCW, 50.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 3200 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInCH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitCH, 50.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 4800 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightUsingFill() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingFillAndTopPosition() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 10.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingFillAndBottomPosition() {

		val node = DisplayNode(this.display)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 40.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 10 - 40.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPC, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - (480 * 0.1) - (480 * 0.4), 0.001)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitVW, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - (320 * 0.1) - (320 * 0.4), 0.001)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitVH, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - (480 * 0.1) - (480 * 0.4), 0.001)
	}

	@Test
	fun testNodeHeightShouldBeMeasuredFromTopAndBottomInsteadOfLength() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 150.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 10 - 40.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPXIncludingNegativeMargins() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)
		node.setMarginTop(kMarginTypeLength, kMarginUnitPX, -10.0)
		node.setMarginBottom(kMarginTypeLength, kMarginUnitPX, -40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 50 + 50.0, 0.001) // 480 - (10 + 40.0) + (10 + 40.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPXIncludingPositiveMargins() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)
		node.setMarginTop(kMarginTypeLength, kMarginUnitPX, 10.0)
		node.setMarginBottom(kMarginTypeLength, kMarginUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 50 - 50.0, 0.001) // 480 - (10 + 40.0) - (10 + 40.0)
	}

	@Test
	fun testNodeBorderInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 150.0)

		node.setBorderTop(kBorderTypeLength, kBorderUnitPX, 10.0)
		node.setBorderLeft(kBorderTypeLength, kBorderUnitPX, 20.0)
		node.setBorderRight(kBorderTypeLength, kBorderUnitPX, 30.0)
		node.setBorderBottom(kBorderTypeLength, kBorderUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 10.0, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 20.0, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 30.0, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 40.0, 0.001)
	}

	@Test
	fun testNodeBorderInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 150.0)

		node.setBorderTop(kBorderTypeLength, kBorderUnitPC, 10.0)
		node.setBorderLeft(kBorderTypeLength, kBorderUnitPC, 20.0)
		node.setBorderRight(kBorderTypeLength, kBorderUnitPC, 30.0)
		node.setBorderBottom(kBorderTypeLength, kBorderUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 150 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 100 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 100 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 150 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 150.0)

		node.setBorderTop(kBorderTypeLength, kBorderUnitVW, 10.0)
		node.setBorderLeft(kBorderTypeLength, kBorderUnitVW, 20.0)
		node.setBorderRight(kBorderTypeLength, kBorderUnitVW, 30.0)
		node.setBorderBottom(kBorderTypeLength, kBorderUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 150.0)

		node.setBorderTop(kBorderTypeLength, kBorderUnitVH, 10.0)
		node.setBorderLeft(kBorderTypeLength, kBorderUnitVH, 20.0)
		node.setBorderRight(kBorderTypeLength, kBorderUnitVH, 30.0)
		node.setBorderBottom(kBorderTypeLength, kBorderUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setBorderTop(kBorderTypeLength, kBorderUnitPW, 10.0)
		node.setBorderLeft(kBorderTypeLength, kBorderUnitPW, 20.0)
		node.setBorderRight(kBorderTypeLength, kBorderUnitPW, 30.0)
		node.setBorderBottom(kBorderTypeLength, kBorderUnitPW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInPH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setBorderTop(kBorderTypeLength, kBorderUnitPH, 10.0)
		node.setBorderLeft(kBorderTypeLength, kBorderUnitPH, 20.0)
		node.setBorderRight(kBorderTypeLength, kBorderUnitPH, 30.0)
		node.setBorderBottom(kBorderTypeLength, kBorderUnitPH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInCW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setBorderTop(kBorderTypeLength, kBorderUnitCW, 10.0)
		node.setBorderLeft(kBorderTypeLength, kBorderUnitCW, 20.0)
		node.setBorderRight(kBorderTypeLength, kBorderUnitCW, 30.0)
		node.setBorderBottom(kBorderTypeLength, kBorderUnitCW, 40.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 3200 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 3200 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 3200 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 3200 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInCH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setBorderTop(kBorderTypeLength, kBorderUnitCH, 10.0)
		node.setBorderLeft(kBorderTypeLength, kBorderUnitCH, 20.0)
		node.setBorderRight(kBorderTypeLength, kBorderUnitCH, 30.0)
		node.setBorderBottom(kBorderTypeLength, kBorderUnitCH, 40.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 4800 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 4800 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 4800 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 4800 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 150.0)

		node.setPaddingTop(kPaddingTypeLength, kPaddingUnitPX, 10.0)
		node.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPX, 20.0)
		node.setPaddingRight(kPaddingTypeLength, kPaddingUnitPX, 30.0)
		node.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 10.0, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 20.0, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 30.0, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 40.0, 0.001)
	}

	@Test
	fun testNodePaddingInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 150.0)

		node.setPaddingTop(kPaddingTypeLength, kPaddingUnitPC, 10.0)
		node.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPC, 20.0)
		node.setPaddingRight(kPaddingTypeLength, kPaddingUnitPC, 30.0)
		node.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 150 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 100 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 100 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 150 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 150.0)

		node.setPaddingTop(kPaddingTypeLength, kPaddingUnitVW, 10.0)
		node.setPaddingLeft(kPaddingTypeLength, kPaddingUnitVW, 20.0)
		node.setPaddingRight(kPaddingTypeLength, kPaddingUnitVW, 30.0)
		node.setPaddingBottom(kPaddingTypeLength, kPaddingUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 150.0)

		node.setPaddingTop(kPaddingTypeLength, kPaddingUnitVH, 10.0)
		node.setPaddingLeft(kPaddingTypeLength, kPaddingUnitVH, 20.0)
		node.setPaddingRight(kPaddingTypeLength, kPaddingUnitVH, 30.0)
		node.setPaddingBottom(kPaddingTypeLength, kPaddingUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 480 * 0.4, 0.001)
	}


	@Test
	fun testNodePaddingInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setPaddingTop(kPaddingTypeLength, kPaddingUnitPW, 10.0)
		node.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPW, 20.0)
		node.setPaddingRight(kPaddingTypeLength, kPaddingUnitPW, 30.0)
		node.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInPH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setPaddingTop(kPaddingTypeLength, kPaddingUnitPH, 10.0)
		node.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPH, 20.0)
		node.setPaddingRight(kPaddingTypeLength, kPaddingUnitPH, 30.0)
		node.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInCW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setPaddingTop(kPaddingTypeLength, kPaddingUnitCW, 10.0)
		node.setPaddingLeft(kPaddingTypeLength, kPaddingUnitCW, 20.0)
		node.setPaddingRight(kPaddingTypeLength, kPaddingUnitCW, 30.0)
		node.setPaddingBottom(kPaddingTypeLength, kPaddingUnitCW, 40.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 3200 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 3200 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 3200 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 3200 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInCH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 0.0)

		node.setPaddingTop(kPaddingTypeLength, kPaddingUnitCH, 10.0)
		node.setPaddingLeft(kPaddingTypeLength, kPaddingUnitCH, 20.0)
		node.setPaddingRight(kPaddingTypeLength, kPaddingUnitCH, 30.0)
		node.setPaddingBottom(kPaddingTypeLength, kPaddingUnitCH, 40.0)

		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 4800 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 4800 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 4800 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 4800 * 0.4, 0.001)
	}

	@Test
	fun testAnchorInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)

		node.setAnchorTop(kAnchorTypeLength, kAnchorUnitPC, 50.0)
		node.setAnchorLeft(kAnchorTypeLength, kAnchorUnitPC, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, -100.0, 0.001)
		Assert.assertEquals(node.measuredLeft, -100.0, 0.001)
	}

	@Test
	fun testScaling() {

		// TODO: Test other properites
		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPC, 33.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPC, 33.0)

		this.display.scale = 2.0
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 0.0, 0.001)
		Assert.assertEquals(node.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node.measuredWidth, 105.5, 0.001)
		Assert.assertEquals(node.measuredHeight, 158.5, 0.001)
	}

	@Test
	fun testWrappingFromContentSize() {

		val container = DisplayNode(this.display)
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node1.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node2.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.001)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(container.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(container.measuredHeight, 400.0, 0.001)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.001)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.001)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.001)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.001)
	}

	@Test
	fun testWrappingFromContentSizeWithMin() {

		val container = DisplayNode(this.display)
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setMinWidth(250.0)
		container.setMinHeight(450.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node1.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node2.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.001)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(container.measuredWidth, 250.0, 0.001)
		Assert.assertEquals(container.measuredHeight, 450.0, 0.001)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.001)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.001)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.001)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.001)
	}

	@Test
	fun testWrappingFromContentSizeWithMax() {

		val container = DisplayNode(this.display)
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setMaxWidth(150.0)
		container.setMaxHeight(350.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node1.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node2.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.001)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(container.measuredWidth, 150.0, 0.001)
		Assert.assertEquals(container.measuredHeight, 350.0, 0.001)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.001)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.001)

		Assert.assertEquals(node2.measuredTop, 200.0, 0.001)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.001)
	}

	@Test
	fun testWrappingFromContentSizeAndPadding() {

		val container = DisplayNode(this.display)
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setPaddingTop(kPaddingTypeLength, kPaddingUnitPX, 10.0)
		container.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPX, 20.0)
		container.setPaddingRight(kPaddingTypeLength, kPaddingUnitPX, 30.0)
		container.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPX, 40.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node1.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node2.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.001)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(container.measuredWidth, 200 + 20 + 30.0, 0.001)
		Assert.assertEquals(container.measuredHeight, 400 + 10 + 40.0, 0.001)

		Assert.assertEquals(node1.measuredTop, 10.0, 0.001)
		Assert.assertEquals(node1.measuredLeft, 20.0, 0.001)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.001)

		Assert.assertEquals(node2.measuredTop, 200 + 10.0, 0.001)
		Assert.assertEquals(node2.measuredLeft, 20.0, 0.001)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.001)
	}

	@Test
	fun testWrappingFromContentSizeAndMargin() {

		val container = DisplayNode(this.display)
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)

		val node1 = DisplayNode(this.display)
		node1.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node1.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)
		node1.setMarginRight(kMarginTypeLength, kMarginUnitPX, 30.0)
		node1.setMarginBottom(kMarginTypeLength, kMarginUnitPX, 20.0)

		val node2 = DisplayNode(this.display)
		node2.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node2.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)
		node2.setMarginRight(kMarginTypeLength, kMarginUnitPX, 50.0)
		node2.setMarginBottom(kMarginTypeLength, kMarginUnitPX, 40.0)

		container.appendChild(node1)
		container.appendChild(node2)

		this.window.appendChild(container)
		this.window.resolve()

		Assert.assertEquals(container.measuredTop, 0.0, 0.001)
		Assert.assertEquals(container.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(container.measuredWidth, 200 + 50.0, 0.001)
		Assert.assertEquals(container.measuredHeight, 400 + 20 + 40.0, 0.001)

		Assert.assertEquals(node1.measuredTop, 0.0, 0.001)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node1.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node1.measuredHeight, 200.0, 0.001)

		Assert.assertEquals(node2.measuredTop, 200 + 20.0, 0.001)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node2.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.001)
	}
}