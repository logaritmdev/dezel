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
		this.window.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 320.0)
		this.window.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 480.0)
		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 320.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 480.0)
		this.window.id = "Window"

		this.display.setWindow(this.window)
	}

	@Test
	fun testNodePositionInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPW, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPW, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPW, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPW, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPH, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPH, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPH, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPH, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCW, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCW, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCW, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCW, 40.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCH, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCH, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCH, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCH, 40.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 40.0)

		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 40.0)

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

		Assert.assertEquals(node.measuredTop, 10.0 + 480.0 * 0.1, 0.0)
		Assert.assertEquals(node.measuredLeft, 20.0 + 320.0 * 0.2, 0.0)
		Assert.assertEquals(node.measuredRight, 30.0 + 320.0 * 0.3, 0.0)
		Assert.assertEquals(node.measuredBottom, 40.0 + 480.0 * 0.4, 0.0)
	}

	@Test
	fun testNodeMarginInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 40.0)

		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 30.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 40.0)

		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPW, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPW, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPW, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPW, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPH, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPH, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPH, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPH, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCW, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCW, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCW, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCW, 40.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCH, 10.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCH, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCH, 30.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCH, 40.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 100.0, 0.0)
	}

	@Test
	fun testNodeWidthInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPC, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitVW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitVH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 480.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInPH() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 480.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInCW() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitCW, 50.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 3200.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthInCH() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitCH, 50.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 4800.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeWidthUsingFill() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setWidth(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
		node.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0, 0.0)
	}

	@Test
	fun testNodeWidthUsingFillAndLeftPosition() {

		val node = DisplayNode(this.display)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setWidth(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
		node.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 10.0, 0.0)
	}

	@Test
	fun testNodeWidthUsingFillAndRightPosition() {

		val node = DisplayNode(this.display)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 30.0)
		node.setWidth(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
		node.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 30.0, 0.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPX() {

		val node = DisplayNode(this.display)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 20.0 - 30.0, 0.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPC() {

		val node = DisplayNode(this.display)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - (320.0 * 0.2) - (320.0 * 0.3), 0.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInVW() {

		val node = DisplayNode(this.display)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - (320.0 * 0.2) - (320.0 * 0.3), 0.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInVH() {

		val node = DisplayNode(this.display)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - (480.0 * 0.2) - (480.0 * 0.3), 0.0)
	}

	@Test
	fun testNodeWidthtShouldBeMeasuredFromLeftAndRightInsteadOfLength() {

		val node = DisplayNode(this.display)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 30.0)
		node.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 20.0 - 30.0, 0.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPXIncludingNegativeMargins() {

		val node = DisplayNode(this.display)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 30.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, -20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, -30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 50.0 + 50.0, 0.0) // 320.0 - (20.0 + 30.0) + (20.0 + 30.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPXIncludingPositiveMargins() {

		val node = DisplayNode(this.display)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 30.0)
		node.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 20.0)
		node.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0 - 50.0 - 50.0, 0.0) // 320.0 - (20.0 + 30.0) - (20.0 + 30.0)
	}

	@Test
	fun testNodeHeightInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 100.0, 0.0)
	}

	@Test
	fun testNodeHeightInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPC, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitVW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitVH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 320.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightInPH() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightInCW() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitCW, 50.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 3200.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightInCH() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitCH, 50.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 4800.0 * 0.5, 0.0)
	}

	@Test
	fun testNodeHeightUsingFill() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setWidth(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
		node.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0, 0.0)
	}

	@Test
	fun testNodeHeightUsingFillAndTopPosition() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setWidth(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
		node.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - 10.0, 0.0)
	}

	@Test
	fun testNodeHeightUsingFillAndBottomPosition() {

		val node = DisplayNode(this.display)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 40.0)
		node.setWidth(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
		node.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - 40.0, 0.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - 10.0 - 40.0, 0.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPC() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, 10.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - (480.0 * 0.1) - (480.0 * 0.4), 0.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInVW() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, 10.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - (320.0 * 0.1) - (320.0 * 0.4), 0.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInVH() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, 10.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - (480.0 * 0.1) - (480.0 * 0.4), 0.0)
	}

	@Test
	fun testNodeHeightShouldBeMeasuredFromTopAndBottomInsteadOfLength() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 40.0)
		node.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 150.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - 10.0 - 40.0, 0.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPXIncludingNegativeMargins() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 40.0)
		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, -10.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, -40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - 50.0 + 50.0, 0.0) // 480.0 - (10.0 + 40.0) + (10.0 + 40.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPXIncludingPositiveMargins() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 40.0)
		node.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 10.0)
		node.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0 - 50.0 - 50.0, 0.0) // 480.0 - (10.0 + 40.0) - (10.0 + 40.0)
	}

	@Test
	fun testNodeBorderInPX() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
	fun testNodeBorderInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, 10.0)
		node.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, 20.0)
		node.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, 30.0)
		node.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, 10.0)
		node.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, 20.0)
		node.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, 30.0)
		node.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, 10.0)
		node.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, 20.0)
		node.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, 30.0)
		node.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, 40.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, 10.0)
		node.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, 20.0)
		node.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, 30.0)
		node.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, 40.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
	fun testNodePaddingInPW() {

		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, 10.0)
		node.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, 20.0)
		node.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, 30.0)
		node.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, 10.0)
		node.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, 20.0)
		node.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, 30.0)
		node.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, 40.0)

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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, 10.0)
		node.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, 20.0)
		node.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, 30.0)
		node.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, 40.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
		node.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)

		node.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, 10.0)
		node.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, 20.0)
		node.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, 30.0)
		node.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, 40.0)

		this.window.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 3200.0)
		this.window.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, 4800.0)
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
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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

		// TODO: Test other properites
		val node = DisplayNode(this.display)
		node.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
	fun testWrappingFromContentSize() {

		val container = DisplayNode(this.display)
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
	fun testNodePositionAndSizeCaching() {

		val counter = DisplayNodeListenerCounter()

		val node1 = DisplayNode(this.display)
		node1.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node1.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node1.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node1.listener = counter

		val node2 = DisplayNode(this.display)
		node2.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node2.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node2.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node2.listener = counter

		this.window.appendChild(node1)
		this.window.appendChild(node2)
		this.window.resolve()

		Assert.assertEquals(counter.resolvedSize, 2)
		Assert.assertEquals(counter.resolvedOrigin, 2)

		val node3 = DisplayNode(this.display)
		node3.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 10.0)
		node3.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 20.0)
		node3.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node3.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, 200.0)
		node3.listener = counter

		this.window.appendChild(node3)
		this.window.resolve()

		Assert.assertEquals(counter.resolvedSize, 3)
		Assert.assertEquals(counter.resolvedOrigin, 3)
	}

	@Test
	fun testWrappedNodePaddingInPX() {

		val container = DisplayNode(this.display)
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
		container.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, 0.0)
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
}