package ca.logaritm.dezel.view

import ca.logaritm.dezel.view.display.*
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class DisplayNodeAbsoluteLayoutTest {

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
		this.display.setViewportWidth(320f)
		this.display.setViewportHeight(480f)

		this.window = DisplayNode(this.display)
		this.window.setWidth(kSizeTypeLength, kSizeUnitPX, 320.0)
		this.window.setHeight(kSizeTypeLength, kSizeUnitPX, 480.0)
		this.window.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, 320.0)
		this.window.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, 480.0)
		this.window.id = "Window"

		this.display.setWindow(this.window)
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

		Assert.assertEquals(node.measuredTop, 10.0, 0.0)
		Assert.assertEquals(node.measuredLeft, 20.0, 0.0)
		Assert.assertEquals(node.measuredRight, 30.0, 0.0)
		Assert.assertEquals(node.measuredBottom, 40.0, 0.0)
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

		Assert.assertEquals(node.measuredTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 480.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 320.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 480.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 320.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 480.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredTop, 3200.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 3200.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 3200.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 3200.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredTop, 4800.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 4800.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 4800.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 4800.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredMarginTop, 10.0, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 20.0, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 30.0, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 40.0, 0.0)

		Assert.assertEquals(node.measuredTop, 10.0 + 10.0, 0.0)
		Assert.assertEquals(node.measuredLeft, 20.0 + 20.0, 0.0)
		Assert.assertEquals(node.measuredRight, 30.0 + 30.0, 0.0)
		Assert.assertEquals(node.measuredBottom, 40.0 + 40.0, 0.0)
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

		Assert.assertEquals(node.measuredMarginTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 480.0 * 0.4, 0.0)

		Assert.assertEquals(node.measuredTop, 10.0 + 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 20.0 + 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 30.0 + 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 40.0 + 480.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredTop, 10.0 + 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 20.0 + 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 30.0 + 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 40.0 + 320.0 * 0.4, 0.0)

		Assert.assertEquals(node.measuredMarginTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 320.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredTop, 10.0 + 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 20.0 + 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 30.0 + 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 40.0 + 480.0 * 0.4, 0.0)

		Assert.assertEquals(node.measuredMarginTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 480.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredMarginTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 320.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredMarginTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 480.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredMarginTop, 3200.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 3200.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 3200.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 3200.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredMarginTop, 4800.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredMarginLeft, 4800.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredMarginRight, 4800.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredMarginBottom, 4800.0 * 0.4, 0.0)
	}

	@Test
	fun testNodeWidthInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 100.0, 0.0)
	}

	@Test
	fun testNodeWidthInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPC, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitVW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitVH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 480.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInPH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 480.0 * 0.5, 0.0)
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

		Assert.assertEquals(node.measuredWidth, 3200.0 * 0.5, 0.0)
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

		Assert.assertEquals(node.measuredWidth, 4800.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthUsingFill() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0, 0.0)
	}

	@Test
	fun testNodeWidthUsingFillAndLeftPosition() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 10.0, 0.0)
	}

	@Test
	fun testNodeWidthUsingFillAndRightPosition() {

		val node = DisplayNode(this.display)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 30.0, 0.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPX() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 20.0 - 30.0, 0.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPC() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitPC, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPC, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - (320.0 * 0.2) - (320.0 * 0.3), 0.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInVW() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitVW, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitVW, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - (320.0 * 0.2) - (320.0 * 0.3), 0.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInVH() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitVH, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitVH, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - (480.0 * 0.2) - (480.0 * 0.3), 0.0)
	}

	@Test
	fun testNodeWidthtShouldBeMeasuredFromLeftAndRightInsteadOfLength() {

		val node = DisplayNode(this.display)
		node.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node.setRight(kOriginTypeLength, kOriginUnitPX, 30.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 20.0 - 30.0, 0.0)
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

		Assert.assertEquals(node.measuredWidth, 320.0 - 50.0 + 50.0, 0.0) // 320.0 - (20.0 + 30.0) + (20.0 + 30.0)
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

		Assert.assertEquals(node.measuredWidth, 320.0 - 50.0 - 50.0, 0.0) // 320.0 - (20.0 + 30.0) - (20.0 + 30.0)
	}

	@Test
	fun testNodeHeightInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 100.0, 0.0)
	}

	@Test
	fun testNodeHeightInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPC, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitVW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitVH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightInPH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 * 0.5, 0.0)
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

		Assert.assertEquals(node.measuredHeight, 3200.0 * 0.5, 0.0)
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

		Assert.assertEquals(node.measuredHeight, 4800.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightUsingFill() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0, 0.0)
	}

	@Test
	fun testNodeHeightUsingFillAndTopPosition() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - 10.0, 0.0)
	}

	@Test
	fun testNodeHeightUsingFillAndBottomPosition() {

		val node = DisplayNode(this.display)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)
		node.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
		node.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - 40.0, 0.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - 10.0 - 40.0, 0.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPC, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - (480.0 * 0.1) - (480.0 * 0.4), 0.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitVW, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - (320.0 * 0.1) - (320.0 * 0.4), 0.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitVH, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - (480.0 * 0.1) - (480.0 * 0.4), 0.0)
	}

	@Test
	fun testNodeHeightShouldBeMeasuredFromTopAndBottomInsteadOfLength() {

		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node.setBottom(kOriginTypeLength, kOriginUnitPX, 40.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPX, 150.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - 10.0 - 40.0, 0.0)
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

		Assert.assertEquals(node.measuredHeight, 480.0 - 50.0 + 50.0, 0.0) // 480.0 - (10.0 + 40.0) + (10.0 + 40.0)
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

		Assert.assertEquals(node.measuredHeight, 480.0 - 50.0 - 50.0, 0.0) // 480.0 - (10.0 + 40.0) - (10.0 + 40.0)
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

		Assert.assertEquals(node.measuredBorderTop, 10.0, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 20.0, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 30.0, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 40.0, 0.0)
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

		Assert.assertEquals(node.measuredBorderTop, 150.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 100.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 100.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 150.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredBorderTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 320.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredBorderTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 480.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredBorderTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 320.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredBorderTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 480.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredBorderTop, 3200.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 3200.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 3200.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 3200.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredBorderTop, 4800.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredBorderLeft, 4800.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredBorderRight, 4800.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBorderBottom, 4800.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredPaddingTop, 10.0, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 20.0, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 30.0, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 40.0, 0.0)
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

		Assert.assertEquals(node.measuredPaddingTop, 150.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 100.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 100.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 150.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredPaddingTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 320.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredPaddingTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 480.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredPaddingTop, 320.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 320.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredPaddingTop, 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 480.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 480.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 480.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredPaddingTop, 3200.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 3200.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 3200.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 3200.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredPaddingTop, 4800.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredPaddingLeft, 4800.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredPaddingRight, 4800.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredPaddingBottom, 4800.0 * 0.4, 0.0)
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

		Assert.assertEquals(node.measuredTop, -100.0, 0.0)
		Assert.assertEquals(node.measuredLeft, -100.0, 0.0)
	}

	@Test
	fun testScaling() {

		// TODO: Test other properites
		val node = DisplayNode(this.display)
		node.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		node.setWidth(kSizeTypeLength, kSizeUnitPC, 33.0)
		node.setHeight(kSizeTypeLength, kSizeUnitPC, 33.0)

		this.display.setScale(2f)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 0.0, 0.0)
		Assert.assertEquals(node.measuredLeft, 0.0, 0.0)
		Assert.assertEquals(node.measuredWidth, 105.5, 0.0)
		Assert.assertEquals(node.measuredHeight, 158.5, 0.0)
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
	fun testNodePositionAndSizeCaching() {

		val counter = DisplayNodeListenerCounter()

		val node1 = DisplayNode(this.display)
		node1.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node1.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node1.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node1.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)
		node1.listener = counter

		val node2 = DisplayNode(this.display)
		node2.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node2.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node2.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node2.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)
		node2.listener = counter

		this.window.appendChild(node1)
		this.window.appendChild(node2)
		this.window.resolve()

		Assert.assertEquals(counter.resolvedSize, 2)
		Assert.assertEquals(counter.resolvedOrigin, 2)

		val node3 = DisplayNode(this.display)
		node3.setTop(kOriginTypeLength, kOriginUnitPX, 10.0)
		node3.setLeft(kOriginTypeLength, kOriginUnitPX, 20.0)
		node3.setWidth(kSizeTypeLength, kSizeUnitPX, 200.0)
		node3.setHeight(kSizeTypeLength, kSizeUnitPX, 200.0)
		node3.listener = counter

		this.window.appendChild(node3)
		this.window.resolve()

		Assert.assertEquals(counter.resolvedSize, 3)
		Assert.assertEquals(counter.resolvedOrigin, 3)
	}

	@Test
	fun testWrappedNodePaddingInPX() {

		val container = DisplayNode(this.display)
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setPaddingTop(kPaddingTypeLength, kPaddingUnitPX, 20.0)
		container.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPX, 40.0)
		container.setPaddingRight(kPaddingTypeLength, kPaddingUnitPX, 60.0)
		container.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPX, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setPaddingTop(kPaddingTypeLength, kPaddingUnitPC, 20.0)
		container.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPC, 40.0)
		container.setPaddingRight(kPaddingTypeLength, kPaddingUnitPC, 60.0)
		container.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPC, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setPaddingTop(kPaddingTypeLength, kPaddingUnitVW, 20.0)
		container.setPaddingLeft(kPaddingTypeLength, kPaddingUnitVW, 40.0)
		container.setPaddingRight(kPaddingTypeLength, kPaddingUnitVW, 60.0)
		container.setPaddingBottom(kPaddingTypeLength, kPaddingUnitVW, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setPaddingTop(kPaddingTypeLength, kPaddingUnitVH, 20.0)
		container.setPaddingLeft(kPaddingTypeLength, kPaddingUnitVH, 40.0)
		container.setPaddingRight(kPaddingTypeLength, kPaddingUnitVH, 60.0)
		container.setPaddingBottom(kPaddingTypeLength, kPaddingUnitVH, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setPaddingTop(kPaddingTypeLength, kPaddingUnitPW, 20.0)
		container.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPW, 40.0)
		container.setPaddingRight(kPaddingTypeLength, kPaddingUnitPW, 60.0)
		container.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPW, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setPaddingTop(kPaddingTypeLength, kPaddingUnitPH, 20.0)
		container.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPH, 40.0)
		container.setPaddingRight(kPaddingTypeLength, kPaddingUnitPH, 60.0)
		container.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPH, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setPaddingTop(kPaddingTypeLength, kPaddingUnitCW, 20.0)
		container.setPaddingLeft(kPaddingTypeLength, kPaddingUnitCW, 40.0)
		container.setPaddingRight(kPaddingTypeLength, kPaddingUnitCW, 60.0)
		container.setPaddingBottom(kPaddingTypeLength, kPaddingUnitCW, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setPaddingTop(kPaddingTypeLength, kPaddingUnitCH, 20.0)
		container.setPaddingLeft(kPaddingTypeLength, kPaddingUnitCH, 40.0)
		container.setPaddingRight(kPaddingTypeLength, kPaddingUnitCH, 60.0)
		container.setPaddingBottom(kPaddingTypeLength, kPaddingUnitCH, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setBorderTop(kBorderTypeLength, kBorderUnitPX, 20.0)
		container.setBorderLeft(kBorderTypeLength, kBorderUnitPX, 40.0)
		container.setBorderRight(kBorderTypeLength, kBorderUnitPX, 60.0)
		container.setBorderBottom(kBorderTypeLength, kBorderUnitPX, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setBorderTop(kBorderTypeLength, kBorderUnitPC, 20.0)
		container.setBorderLeft(kBorderTypeLength, kBorderUnitPC, 40.0)
		container.setBorderRight(kBorderTypeLength, kBorderUnitPC, 60.0)
		container.setBorderBottom(kBorderTypeLength, kBorderUnitPC, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setBorderTop(kBorderTypeLength, kBorderUnitPW, 20.0)
		container.setBorderLeft(kBorderTypeLength, kBorderUnitPW, 40.0)
		container.setBorderRight(kBorderTypeLength, kBorderUnitPW, 60.0)
		container.setBorderBottom(kBorderTypeLength, kBorderUnitPW, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setBorderTop(kBorderTypeLength, kBorderUnitPH, 20.0)
		container.setBorderLeft(kBorderTypeLength, kBorderUnitPH, 40.0)
		container.setBorderRight(kBorderTypeLength, kBorderUnitPH, 60.0)
		container.setBorderBottom(kBorderTypeLength, kBorderUnitPH, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setBorderTop(kBorderTypeLength, kBorderUnitCW, 20.0)
		container.setBorderLeft(kBorderTypeLength, kBorderUnitCW, 40.0)
		container.setBorderRight(kBorderTypeLength, kBorderUnitCW, 60.0)
		container.setBorderBottom(kBorderTypeLength, kBorderUnitCW, 80.0)

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
		container.setTop(kOriginTypeLength, kOriginUnitPX, 0.0)
		container.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
		container.setBorderTop(kBorderTypeLength, kBorderUnitCH, 20.0)
		container.setBorderLeft(kBorderTypeLength, kBorderUnitCH, 40.0)
		container.setBorderRight(kBorderTypeLength, kBorderUnitCH, 60.0)
		container.setBorderBottom(kBorderTypeLength, kBorderUnitCH, 80.0)

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
}