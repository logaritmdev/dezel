package ca.logaritm.dezel.layout

import android.util.SizeF
import ca.logaritm.dezel.core.Finalizer
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class AbsoluteLayoutNodeTest {

	lateinit var layout: Layout
	lateinit var window: LayoutNode

	@Before
	fun beforeTest() {

		this.layout = Layout()

		this.window = LayoutNode(this.layout)
		this.window.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 320.0)
		this.window.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 480.0)

		this.layout.root = this.window
		this.layout.viewportWidth = 320f
		this.layout.viewportHeight = 480f
	}
	
	@Test
	fun testLayoutState() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		this.window.appendChild(node)

		Assert.assertTrue(this.window.hasInvalidLayout)
		Assert.assertTrue(node.hasInvalidPosition)

		this.window.resolve()

		Assert.assertFalse(this.window.hasInvalidLayout)
		Assert.assertFalse(node.hasInvalidPosition)
	}
	
	@Test
	fun testNodePositionInPX() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 10.0, 0.001)
		Assert.assertEquals(node.measuredLeft, 20.0, 0.001)
		Assert.assertEquals(node.measuredRight, 30.0, 0.001)
		Assert.assertEquals(node.measuredBottom, 40.0, 0.001)
	}
	
	@Test
	fun testNodePositionInPC() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInVW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInVH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInPW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPW, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPW, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPW, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInPH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPH, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPH, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPH, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInCW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCW, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCW, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCW, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCW, 40.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 3200 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 3200 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 3200 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 3200 * 0.4, 0.001)
	}

	@Test
	fun testNodePositionInCH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCH, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCH, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCH, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCH, 40.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 4800 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 4800 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 4800 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 4800 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInPX() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 40.0)

		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 10.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 30.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 40.0)

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

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 40.0)

		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPC, 10.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPC, 20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPC, 30.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPC, 40.0)

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

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 40.0)

		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVW, 10.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVW, 20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVW, 30.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVW, 40.0)

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

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 30.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 40.0)

		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVH, 10.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVH, 20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVH, 30.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVH, 40.0)

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

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPW, 10.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPW, 20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPW, 30.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInPH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPH, 10.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPH, 20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPH, 30.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInCW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCW, 10.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCW, 20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCW, 30.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCW, 40.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 3200 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 3200 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 3200 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 3200 * 0.4, 0.001)
	}

	@Test
	fun testNodeMarginInCH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCH, 10.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCH, 20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCH, 30.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCH, 40.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredMarginTop, 4800 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 4800 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 4800 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 4800 * 0.4, 0.001)
	}

	@Test
	fun testNodeWidthInPX() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 100.0, 0.001)
	}

	@Test
	fun testNodeWidthInPC() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInVW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitVW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInVH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitVH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInPW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInPH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInCW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitCW, 50.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 3200 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInCH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitCH, 50.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 4800 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthUsingFill() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)
		node.height(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0, 0.001)
	}

	@Test
	fun testNodeWidthUsingFillAndLeftPosition() {

		val node = LayoutNode(this.layout)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.width(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)
		node.height(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 10.0, 0.001)
	}

	@Test
	fun testNodeWidthUsingFillAndRightPosition() {

		val node = LayoutNode(this.layout)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 30.0)
		node.width(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)
		node.height(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 30.0, 0.001)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPX() {

		val node = LayoutNode(this.layout)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 20 - 30.0, 0.001)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPC() {

		val node = LayoutNode(this.layout)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - (320 * 0.2) - (320 * 0.3), 0.001)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInVW() {

		val node = LayoutNode(this.layout)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - (320 * 0.2) - (320 * 0.3), 0.001)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInVH() {

		val node = LayoutNode(this.layout)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - (480 * 0.2) - (480 * 0.3), 0.001)
	}

	@Test
	fun testNodeWidthtShouldBeMeasuredFromLeftAndRightInsteadOfLength() {

		val node = LayoutNode(this.layout)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 30.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 20 - 30.0, 0.001)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPXIncludingNegativeMargins() {

		val node = LayoutNode(this.layout)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 30.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, -20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, -30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 50 + 50.0, 0.001) // 320 - (20 + 30.0) + (20 + 30.0)
	}

	@Test
	fun testNodeWidthUsingLeftAndRightPositionInPXIncludingPositiveMargins() {

		val node = LayoutNode(this.layout)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 20.0)
		node.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 30.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 30.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 50 - 50.0, 0.001) // 320 - (20 + 30.0) - (20 + 30.0)
	}

	@Test
	fun testNodeHeightInPX() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 100.0, 0.001)
	}

	@Test
	fun testNodeHeightInPC() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInVW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitVW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInVH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitVH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInPW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInPH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInCW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitCW, 50.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 3200 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightInCH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitCH, 50.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 4800 * 0.5, 0.001)
	}

	@Test
	fun testNodeHeightUsingFill() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)
		node.height(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingFillAndTopPosition() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.width(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)
		node.height(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 10.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingFillAndBottomPosition() {

		val node = LayoutNode(this.layout)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 40.0)
		node.width(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)
		node.height(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 40.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPX() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 10 - 40.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPC() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, 10.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - (480 * 0.1) - (480 * 0.4), 0.001)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInVW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, 10.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - (320 * 0.1) - (320 * 0.4), 0.001)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInVH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, 10.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - (480 * 0.1) - (480 * 0.4), 0.001)
	}

	@Test
	fun testNodeHeightShouldBeMeasuredFromTopAndBottomInsteadOfLength() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 40.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 150.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 10 - 40.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPXIncludingNegativeMargins() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 40.0)
		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, -10.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, -40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 50 + 50.0, 0.001) // 480 - (10 + 40.0) + (10 + 40.0)
	}

	@Test
	fun testNodeHeightUsingTopAndBottomPositionInPXIncludingPositiveMargins() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 10.0)
		node.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 40.0)
		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 10.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480 - 50 - 50.0, 0.001) // 480 - (10 + 40.0) - (10 + 40.0)
	}

	@Test
	fun testNodeBorderInPX() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 150.0)

		node.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, 10.0)
		node.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, 20.0)
		node.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, 30.0)
		node.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 10.0, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 20.0, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 30.0, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 40.0, 0.001)
	}

	@Test
	fun testNodeBorderInPC() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 150.0)

		node.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPC, 10.0)
		node.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPC, 20.0)
		node.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPC, 30.0)
		node.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 150 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 100 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 100 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 150 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInVW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 150.0)

		node.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVW, 10.0)
		node.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVW, 20.0)
		node.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVW, 30.0)
		node.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInVH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 150.0)

		node.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVH, 10.0)
		node.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVH, 20.0)
		node.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVH, 30.0)
		node.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInPW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPW, 10.0)
		node.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPW, 20.0)
		node.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPW, 30.0)
		node.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInPH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPH, 10.0)
		node.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPH, 20.0)
		node.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPH, 30.0)
		node.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInCW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCW, 10.0)
		node.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCW, 20.0)
		node.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCW, 30.0)
		node.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCW, 40.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 3200 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 3200 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 3200 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 3200 * 0.4, 0.001)
	}

	@Test
	fun testNodeBorderInCH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCH, 10.0)
		node.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCH, 20.0)
		node.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCH, 30.0)
		node.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCH, 40.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredBorderTop, 4800 * 0.1, 0.001)
		Assert.assertEquals(node.measuredBorderLeft, 4800 * 0.2, 0.001)
		Assert.assertEquals(node.measuredBorderRight, 4800 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBorderBottom, 4800 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInPX() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 150.0)

		node.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, 10.0)
		node.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, 20.0)
		node.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, 30.0)
		node.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 10.0, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 20.0, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 30.0, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 40.0, 0.001)
	}

	@Test
	fun testNodePaddingInPC() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 150.0)

		node.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPC, 10.0)
		node.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPC, 20.0)
		node.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPC, 30.0)
		node.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPC, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 150 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 100 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 100 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 150 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInVW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 150.0)

		node.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVW, 10.0)
		node.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVW, 20.0)
		node.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVW, 30.0)
		node.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInVH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 150.0)

		node.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVH, 10.0)
		node.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVH, 20.0)
		node.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVH, 30.0)
		node.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 480 * 0.4, 0.001)
	}


	@Test
	fun testNodePaddingInPW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPW, 10.0)
		node.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPW, 20.0)
		node.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPW, 30.0)
		node.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPW, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 320 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 320 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInPH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPH, 10.0)
		node.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPH, 20.0)
		node.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPH, 30.0)
		node.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPH, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 480 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 480 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 480 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInCW() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCW, 10.0)
		node.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCW, 20.0)
		node.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCW, 30.0)
		node.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCW, 40.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 3200 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 3200 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 3200 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 3200 * 0.4, 0.001)
	}

	@Test
	fun testNodePaddingInCH() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)

		node.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCH, 10.0)
		node.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCH, 20.0)
		node.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCH, 30.0)
		node.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCH, 40.0)

		this.window.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 3200.0)
		this.window.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, 4800.0)
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredPaddingTop, 4800 * 0.1, 0.001)
		Assert.assertEquals(node.measuredPaddingLeft, 4800 * 0.2, 0.001)
		Assert.assertEquals(node.measuredPaddingRight, 4800 * 0.3, 0.001)
		Assert.assertEquals(node.measuredPaddingBottom, 4800 * 0.4, 0.001)
	}

	@Test
	fun testAnchorInPC() {

		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

		node.anchorTop(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, 50.0)
		node.anchorLeft(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, -100.0, 0.001)
		Assert.assertEquals(node.measuredLeft, -100.0, 0.001)
	}

	@Test
	fun testScaling() {

		// TODO: Test other properites
		val node = LayoutNode(this.layout)
		node.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, 33.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, 33.0)

		this.layout.scale = 2f
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 0.0, 0.001)
		Assert.assertEquals(node.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node.measuredWidth, 105.5, 0.001)
		Assert.assertEquals(node.measuredHeight, 158.5, 0.001)
	}

	@Test
	fun testWrappingFromContentSize() {

		val container = LayoutNode(this.layout)
		container.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		container.width(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
		container.height(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)

		val node1 = LayoutNode(this.layout)
		node1.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node1.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

		val node2 = LayoutNode(this.layout)
		node2.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node2.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

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

		val container = LayoutNode(this.layout)
		container.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		container.width(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
		container.height(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
		container.minWidth(250.0)
		container.minHeight(450.0)

		val node1 = LayoutNode(this.layout)
		node1.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node1.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

		val node2 = LayoutNode(this.layout)
		node2.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node2.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

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

		val container = LayoutNode(this.layout)
		container.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		container.width(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
		container.height(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
		container.maxWidth(150.0)
		container.maxHeight(350.0)

		val node1 = LayoutNode(this.layout)
		node1.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node1.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

		val node2 = LayoutNode(this.layout)
		node2.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node2.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

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

		val container = LayoutNode(this.layout)
		container.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		container.width(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
		container.height(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
		container.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, 10.0)
		container.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, 20.0)
		container.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, 30.0)
		container.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, 40.0)

		val node1 = LayoutNode(this.layout)
		node1.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node1.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

		val node2 = LayoutNode(this.layout)
		node2.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node2.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

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

		val container = LayoutNode(this.layout)
		container.id = "container"
		container.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, 0.0)
		container.width(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
		container.height(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)

		val node1 = LayoutNode(this.layout)
		node1.id = "node1"
		node1.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node1.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node1.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 30.0)
		node1.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 20.0)

		val node2 = LayoutNode(this.layout)
		node2.id = "node2"
		node2.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node2.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node2.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 50.0)
		node2.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 40.0)

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