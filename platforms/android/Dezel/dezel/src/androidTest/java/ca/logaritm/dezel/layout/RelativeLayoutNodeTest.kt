package ca.logaritm.dezel.layout

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class RelativeLayoutNodeTest {

	companion object {
		init {
			System.loadLibrary("dezel")
		}
	}

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
		this.window.appendChild(node)
		Assert.assertTrue(this.window.hasInvalidLayout)
		this.window.resolve()
		Assert.assertFalse(this.window.hasInvalidLayout)
	}

	@Test
	fun testNodeMarginInPX() {

		val node = LayoutNode(this.layout)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 40.0)
		node.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 10.0)
		node.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 20.0)
		node.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 30.0)
		node.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 40.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 - 20 - 30.0, 0.001)
		Assert.assertEquals(node.measuredHeight, 40.0, 0.001)

		Assert.assertEquals(node.measuredTop, 10.0, 0.001)
		Assert.assertEquals(node.measuredLeft, 20.0, 0.001)
		Assert.assertEquals(node.measuredRight, 30.0, 0.001)
		Assert.assertEquals(node.measuredBottom, 480 - 40 - 10.0, 0.001)

		Assert.assertEquals(node.measuredMarginTop, 10.0, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 20.0, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 30.0, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 40.0, 0.001)
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

		Assert.assertEquals(node.measuredTop, 10 + 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredLeft, 20 + 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredRight, 30 + 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredBottom, 40 + 480 * 0.4, 0.001)

		Assert.assertEquals(node.measuredMarginTop, 480 * 0.1, 0.001)
		Assert.assertEquals(node.measuredMarginLeft, 320 * 0.2, 0.001)
		Assert.assertEquals(node.measuredMarginRight, 320 * 0.3, 0.001)
		Assert.assertEquals(node.measuredMarginBottom, 480 * 0.4, 0.001)
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
	fun testNodeWidthInPX() {

		val node = LayoutNode(this.layout)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 100.0, 0.001)
	}

	@Test
	fun testNodeWidthInPC() {

		val node = LayoutNode(this.layout)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInVW() {

		val node = LayoutNode(this.layout)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitVW, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthInVH() {

		val node = LayoutNode(this.layout)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitVH, 50.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 480 * 0.5, 0.001)
	}

	@Test
	fun testNodeWidthUsingFill() {

		val node = LayoutNode(this.layout)
		node.width(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)
		node.height(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredWidth, 320.0, 0.001)
	}

	@Test
	fun testNodeHeightUsingFill() {

		val node = LayoutNode(this.layout)
		node.width(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)
		node.height(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)

		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredHeight, 480.0, 0.001)
	}

	@Test
	fun testNodeBorderInPX() {

		val node = LayoutNode(this.layout)
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
	fun testNodePaddingInPX() {

		val node = LayoutNode(this.layout)
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
	fun testAnchorInPC() {

		val node = LayoutNode(this.layout)
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

		val node = LayoutNode(this.layout)
		node.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, 33.0)
		node.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, 33.0)

		this.layout.scale = 2.0f
		this.window.appendChild(node)
		this.window.resolve()

		Assert.assertEquals(node.measuredTop, 0.0, 0.001)
		Assert.assertEquals(node.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node.measuredWidth, 105.5, 0.001)
		Assert.assertEquals(node.measuredHeight, 158.5, 0.001)
	}

	@Test
	fun testPositionInVerticalLayout() {

		val node1 = LayoutNode(this.layout)
		node1.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)

		val node2 = LayoutNode(this.layout)
		node2.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

		this.window.appendChild(node1)
		this.window.appendChild(node2)
		this.window.resolve()

		Assert.assertEquals(node1.measuredWidth, 320.0, 0.001)
		Assert.assertEquals(node1.measuredHeight, 100.0, 0.001)
		Assert.assertEquals(node1.measuredTop, 0.0, 0.001)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node1.measuredRight, 0.0, 0.001)
		Assert.assertEquals(node1.measuredBottom, 480 - 100.0, 0.001)

		Assert.assertEquals(node2.measuredWidth, 320.0, 0.001)
		Assert.assertEquals(node2.measuredHeight, 200.0, 0.001)
		Assert.assertEquals(node2.measuredTop, 100.0, 0.001)
		Assert.assertEquals(node2.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node2.measuredRight, 0.0, 0.001)
		Assert.assertEquals(node2.measuredBottom, 480 - 200 - 100.0, 0.001)
	}

	@Test
	fun testPositionInHorizontalLayout() {

		val node1 = LayoutNode(this.layout)
		node1.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 100.0)

		val node2 = LayoutNode(this.layout)
		node2.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)

		this.window.contentDirection(kDLLayoutContentDirectionHorizontal)
		this.window.appendChild(node1)
		this.window.appendChild(node2)
		this.window.resolve()

		Assert.assertEquals(node1.measuredWidth, 100.0, 0.001)
		Assert.assertEquals(node1.measuredHeight, 480.0, 0.001)
		Assert.assertEquals(node1.measuredTop, 0.0, 0.001)
		Assert.assertEquals(node1.measuredLeft, 0.0, 0.001)
		Assert.assertEquals(node1.measuredRight, 320 - 100.0, 0.001)
		Assert.assertEquals(node1.measuredBottom, 0.0, 0.001)

		Assert.assertEquals(node2.measuredWidth, 200.0, 0.001)
		Assert.assertEquals(node2.measuredHeight, 480.0, 0.001)
		Assert.assertEquals(node2.measuredTop, 0.0, 0.001)
		Assert.assertEquals(node2.measuredLeft, 100.0, 0.001)
		Assert.assertEquals(node2.measuredRight, 320 - 200 - 100.0, 0.001)
		Assert.assertEquals(node2.measuredBottom, 0.0, 0.001)
	}

	@Test
	fun testPercentageCarrying() {

		this.window.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 320.0)
		this.window.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 485.0)

		this.layout.viewportWidth = 320f
		this.layout.viewportHeight = 485f
		this.layout.scale = 2.0f

		val node1 = LayoutNode(this.layout)
		node1.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, 33.3333)

		val node2 = LayoutNode(this.layout)
		node2.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, 33.3333)

		val node3 = LayoutNode(this.layout)
		node3.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, 33.3333)

		this.window.appendChild(node1)
		this.window.appendChild(node2)
		this.window.appendChild(node3)
		this.window.resolve()

		Assert.assertEquals(node1.measuredHeight, 161.5, 0.001)
		Assert.assertEquals(node2.measuredHeight, 162.0, 0.001)
		Assert.assertEquals(node3.measuredHeight, 161.5, 0.001)
	}

	@Test
	fun testWrappingFromContentSize() {

		val container = LayoutNode(this.layout)
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
		container.width(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
		container.height(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)

		val node1 = LayoutNode(this.layout)
		node1.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node1.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, 200.0)
		node1.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 30.0)
		node1.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, 20.0)

		val node2 = LayoutNode(this.layout)
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