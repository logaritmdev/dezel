package ca.logaritm.dezel.layout

import android.util.SizeF
import ca.logaritm.dezel.core.Property
import ca.logaritm.dezel.core.PropertyType
import ca.logaritm.dezel.core.PropertyUnit
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.toValidFloat
import ca.logaritm.dezel.view.graphic.Convert

/**
 * Manages and resolves the layoutNode of a node within a hierarchy.
 * @class LayoutNode
 * @since 0.1.0
 */
open class LayoutNode(layout: Layout) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The layoutNode node's delegate.
	 * @property listener
	 * @since 0.1.0
	 */
	open var listener: LayoutNodeListener? = null

	/**
	 * @property id
	 * @since 0.1.0
	 */
	open var id: String by Delegates.OnSet("") { value ->
		LayoutNodeExternal.setId(this.handle, value)
	}

	/**
	 * @property visible
	 * @since 0.1.0
	 * @hidden
	 */
	open var visible: Boolean by Delegates.OnSet(true) { value ->
		LayoutNodeExternal.setVisible(this.handle, value)
	}

	/**
	 * @property measuredTop
	 * @since 0.1.0
	 */
	open var measuredTop: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredTop(this.handle)

	/**
	 * @property measuredLeft
	 * @since 0.1.0
	 */
	open var measuredLeft: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredLeft(this.handle)

	/**
	 * @property measuredRight
	 * @since 0.1.0
	 */
	open var measuredRight: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredRight(this.handle)

	/**
	 * @property measuredBottom
	 * @since 0.1.0
	 */
	open var measuredBottom: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredBottom(this.handle)

	/**
	 * @property measuredWidth
	 * @since 0.1.0
	 */
	open var measuredWidth: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredWidth(this.handle)

	/**
	 * @property measuredHeight
	 * @since 0.1.0
	 */
	open var measuredHeight: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredHeight(this.handle)

	/**
	 * @property measuredInnerWidth
	 * @since 0.1.0
	 */
	open var measuredInnerWidth: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredInnerWidth(this.handle)

	/**
	 * @property measuredInnerHeight
	 * @since 0.1.0
	 */
	open var measuredInnerHeight: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredInnerHeight(this.handle)

	/**
	 * @property measuredContentWidth
	 * @since 0.1.0
	 */
	open var measuredContentWidth: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredContentWidth(this.handle)

	/**
	 * @property measuredContentHeight
	 * @since 0.1.0
	 */
	open var measuredContentHeight: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredContentHeight(this.handle)

	/**
	 * @property measuredMarginTop
	 * @since 0.1.0
	 */
	open var measuredMarginTop: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredMarginTop(this.handle)

	/**
	 * @property measuredMarginLeft
	 * @since 0.1.0
	 */
	open var measuredMarginLeft: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredMarginLeft(this.handle)

	/**
	 * @property measuredMarginRight
	 * @since 0.1.0
	 */
	open var measuredMarginRight: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredMarginRight(this.handle)

	/**
	 * @property measuredMarginBottom
	 * @since 0.1.0
	 */
	open var measuredMarginBottom: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredMarginBottom(this.handle)

	/**
	 * @property measuredPaddingTop
	 * @since 0.1.0
	 */
	open var measuredPaddingTop: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredPaddingTop(this.handle)

	/**
	 * @property measuredBorderTop
	 * @since 0.1.0
	 */
	open var measuredBorderTop: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredBorderTop(this.handle)

	/**
	 * @property measuredBorderLeft
	 * @since 0.1.0
	 */
	open var measuredBorderLeft: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredBorderLeft(this.handle)

	/**
	 * @property measuredBorderRight
	 * @since 0.1.0
	 */
	open var measuredBorderRight: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredBorderRight(this.handle)

	/**
	 * @property measuredBorderBottom
	 * @since 0.1.0
	 */
	open var measuredBorderBottom: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredBorderBottom(this.handle)

	/**
	 * @property measuredPaddingLeft
	 * @since 0.1.0
	 */
	open var measuredPaddingLeft: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredPaddingLeft(this.handle)

	/**
	 * @property measuredPaddingRight
	 * @since 0.1.0
	 */
	open var measuredPaddingRight: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredPaddingRight(this.handle)

	/**
	 * @property measuredPaddingBottom
	 * @since 0.1.0
	 */
	open var measuredPaddingBottom: Double = 0.0
		get() = LayoutNodeExternal.getMeasuredPaddingBottom(this.handle)

	/**
	 * @property viewportWidth
	 * @since 0.1.0
	 */
	open var viewportWidth: Double = 0.0
		get() = LayoutNodeExternal.getViewportWidth(this.handle)

	/**
	 * @property viewportHeight
	 * @since 0.1.0
	 */
	open var viewportHeight: Double = 0.0
		get() = LayoutNodeExternal.getViewportHeight(this.handle)

	/**
	 * @property fillsParentWidth
	 * @since 0.1.0
	 */
	open var fillsParentWidth: Boolean = true
		get() = LayoutNodeExternal.fillsParentWidth(this.handle)

	/**
	 * @property fillsParentHeight
	 * @since 0.1.0
	 */
	open var fillsParentHeight: Boolean = true
		get() = LayoutNodeExternal.fillsParentHeight(this.handle)

	/**
	 * @property wrapsContentWidth
	 * @since 0.1.0
	 */
	open var wrapsContentWidth: Boolean = true
		get() = LayoutNodeExternal.wrapsContentWidth(this.handle)

	/**
	 * @property wrapsContentHeight
	 * @since 0.1.0
	 */
	open var wrapsContentHeight: Boolean = true
		get() = LayoutNodeExternal.wrapsContentHeight(this.handle)

	/**
	 * @property hasInvalidSize
	 * @since 0.2.0
	 */
	open var hasInvalidSize: Boolean = false
		get() = LayoutNodeExternal.hasInvalidSize(this.handle)

	/**
	 * @property hasInvalidPosition
	 * @since 0.2.0
	 */
	open var hasInvalidPosition: Boolean = false
		get() = LayoutNodeExternal.hasInvalidPosition(this.handle)

	/**
	 * @property hasInvalidLayout
	 * @since 0.1.0
	 */
	open var hasInvalidLayout: Boolean = false
		get() = LayoutNodeExternal.hasInvalidLayout(this.handle)

	/**
	 * @property handle
	 * @since 0.1.0
	 * @hidden
	 */
	public var handle: Long = 0
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init {
		this.handle = LayoutNodeExternal.create(this)
		LayoutNodeExternal.setLayout(this.handle, layout.handle)
		LayoutNodeReference.register(this)
	}

	/**
	 * @method anchorTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun anchorTop(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"top"    -> this.anchorTop(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, 0.0)
				"center" -> this.anchorTop(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, 50.0)
				"bottom" -> this.anchorTop(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, 100.0)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PC -> this.anchorTop(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, value.number)
				else            -> this.anchorTop(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, value.number * 100)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method anchorTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun anchorTop(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setAnchorTop(this.handle, type, unit, length)
	}

	/**
	 * @method anchorLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun anchorLeft(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"left"   -> this.anchorLeft(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, 0.0)
				"center" -> this.anchorLeft(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, 50.0)
				"right"  -> this.anchorLeft(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, 100.0)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PC -> this.anchorLeft(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, value.number)
				else            -> this.anchorLeft(kDLLayoutAnchorTypeLength, kDLLayoutAnchorUnitPC, value.number * 100)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method anchorLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun anchorLeft(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setAnchorLeft(this.handle, type, unit, length)
	}

	/**
	 * @method top
	 * @since 0.1.0
	 * @hidden
	 */
	public fun top(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"auto" -> this.top(kDLLayoutPositionTypeAuto, kDLLayoutPositionUnitNone, 0.0)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, value.number)
				PropertyUnit.PC -> this.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, value.number)
				PropertyUnit.VW -> this.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, value.number)
				PropertyUnit.VH -> this.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, value.number)
				PropertyUnit.PW -> this.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPW, value.number)
				PropertyUnit.PH -> this.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPH, value.number)
				PropertyUnit.CW -> this.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCW, value.number)
				PropertyUnit.CH -> this.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCH, value.number)
				else            -> this.top(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method top
	 * @since 0.1.0
	 * @hidden
	 */
	public fun top(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setTop(this.handle, type, unit, length)
	}

	/**
	 * @method minTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minTop(min: Double) {
		LayoutNodeExternal.setMinTop(this.handle, min)
	}

	/**
	 * @method maxTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxTop(max: Double) {
		LayoutNodeExternal.setMaxTop(this.handle, max)
	}

	/**
	 * @method left
	 * @since 0.1.0
	 * @hidden
	 */
	public fun left(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"auto" -> this.left(kDLLayoutPositionTypeAuto, kDLLayoutPositionUnitNone, 0.0)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, value.number)
				PropertyUnit.PC -> this.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, value.number)
				PropertyUnit.VW -> this.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, value.number)
				PropertyUnit.VH -> this.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, value.number)
				PropertyUnit.PW -> this.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPW, value.number)
				PropertyUnit.PH -> this.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPH, value.number)
				PropertyUnit.CW -> this.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCW, value.number)
				PropertyUnit.CH -> this.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCH, value.number)
				else            -> this.left(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method left
	 * @since 0.1.0
	 * @hidden
	 */
	public fun left(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setLeft(this.handle, type, unit, length)
	}

	/**
	 * @method minLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minLeft(min: Double) {
		LayoutNodeExternal.setMinLeft(this.handle, min)
	}

	/**
	 * @method maxLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxLeft(max: Double) {
		LayoutNodeExternal.setMaxLeft(this.handle, max)
	}

	/**
	 * @method right
	 * @since 0.1.0
	 * @hidden
	 */
	public fun right(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"auto" -> this.right(kDLLayoutPositionTypeAuto, kDLLayoutPositionUnitNone, 0.0)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, value.number)
				PropertyUnit.PC -> this.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, value.number)
				PropertyUnit.VW -> this.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, value.number)
				PropertyUnit.VH -> this.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, value.number)
				PropertyUnit.PW -> this.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPW, value.number)
				PropertyUnit.PH -> this.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPH, value.number)
				PropertyUnit.CW -> this.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCW, value.number)
				PropertyUnit.CH -> this.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCH, value.number)
				else            -> this.right(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method right
	 * @since 0.1.0
	 * @hidden
	 */
	public fun right(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setRight(this.handle, type, unit, length)
	}

	/**
	 * @method minRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minRight(min: Double) {
		LayoutNodeExternal.setMinRight(this.handle, min)
	}

	/**
	 * @method maxRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxRight(max: Double) {
		LayoutNodeExternal.setMaxRight(this.handle, max)
	}

	/**
	 * @method bottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun bottom(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"auto" -> this.bottom(kDLLayoutPositionTypeAuto, kDLLayoutPositionUnitNone, 0.0)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, value.number)
				PropertyUnit.PC -> this.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPC, value.number)
				PropertyUnit.VW -> this.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVW, value.number)
				PropertyUnit.VH -> this.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitVH, value.number)
				PropertyUnit.PW -> this.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPW, value.number)
				PropertyUnit.PH -> this.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPH, value.number)
				PropertyUnit.CW -> this.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCW, value.number)
				PropertyUnit.CH -> this.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitCH, value.number)
				else            -> this.bottom(kDLLayoutPositionTypeLength, kDLLayoutPositionUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method bottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun bottom(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setBottom(this.handle, type, unit, length)
	}

	/**
	 * @method minBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minBottom(min: Double) {
		LayoutNodeExternal.setMinBottom(this.handle, min)
	}

	/**
	 * @method maxBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxBottom(max: Double) {
		LayoutNodeExternal.setMaxBottom(this.handle, max)
	}

	/**
	 * @method width
	 * @since 0.1.0
	 * @hidden
	 */
	public fun width(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"fill" -> this.width(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)
				"wrap" -> this.width(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, value.number)
				PropertyUnit.PC -> this.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, value.number)
				PropertyUnit.VW -> this.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitVW, value.number)
				PropertyUnit.VH -> this.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitVH, value.number)
				PropertyUnit.PW -> this.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPW, value.number)
				PropertyUnit.PH -> this.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPH, value.number)
				PropertyUnit.CW -> this.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitCW, value.number)
				PropertyUnit.CH -> this.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitCH, value.number)
				else            -> this.width(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method width
	 * @since 0.1.0
	 * @hidden
	 */
	public fun width(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setWidth(this.handle, type, unit, length)
	}

	/**
	 * @method minWidth
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minWidth(min: Double) {
		LayoutNodeExternal.setMinWidth(this.handle, min)
	}

	/**
	 * @method maxWidth
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxWidth(max: Double) {
		LayoutNodeExternal.setMaxWidth(this.handle, max)
	}

	/**
	 * @method height
	 * @since 0.1.0
	 * @hidden
	 */
	public fun height(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"fill" -> this.height(kDLLayoutSizeTypeFill, kDLLayoutSizeUnitNone, 0.0)
				"wrap" -> this.height(kDLLayoutSizeTypeWrap, kDLLayoutSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, value.number)
				PropertyUnit.PC -> this.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPC, value.number)
				PropertyUnit.VW -> this.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitVW, value.number)
				PropertyUnit.VH -> this.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitVH, value.number)
				PropertyUnit.PW -> this.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPW, value.number)
				PropertyUnit.PH -> this.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPH, value.number)
				PropertyUnit.CW -> this.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitCW, value.number)
				PropertyUnit.CH -> this.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitCH, value.number)
				else            -> this.height(kDLLayoutSizeTypeLength, kDLLayoutSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method height
	 * @since 0.1.0
	 * @hidden
	 */
	public fun height(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setHeight(this.handle, type, unit, length)
	}

	/**
	 * @method minHeight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minHeight(min: Double) {
		LayoutNodeExternal.setMinHeight(this.handle, min)
	}

	/**
	 * @method maxHeight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxHeight(max: Double) {
		LayoutNodeExternal.setMaxHeight(this.handle, max)
	}

	/**
	 * @method contentOrientation
	 * @since 0.1.0
	 * @hidden
	 */
	public fun contentOrientation(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"horizontal" -> this.contentOrientation(kDLLayoutContentOrientationHorizontal)
				"vertical"   -> this.contentOrientation(kDLLayoutContentOrientationVertical)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method contentOrientation
	 * @since 0.1.0
	 * @hidden
	 */
	public fun contentOrientation(direction: Int) {
		LayoutNodeExternal.setContentOrientation(this.handle, direction)
	}

	/**
	 * @method contentDisposition
	 * @since 0.1.0
	 * @hidden
	 */
	public fun contentDisposition(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"center"        -> this.contentDisposition(kDLLayoutContentDispositionCenter)
				"start"         -> this.contentDisposition(kDLLayoutContentDispositionStart)
				"end"           -> this.contentDisposition(kDLLayoutContentDispositionEnd)
				"space-around"  -> this.contentDisposition(kDLLayoutContentDispositionSpaceAround)
				"space-evenly"  -> this.contentDisposition(kDLLayoutContentDispositionSpaceEvenly)
				"space-between" -> this.contentDisposition(kDLLayoutContentDispositionSpaceBetween)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method contentDisposition
	 * @since 0.1.0
	 * @hidden
	 */
	public fun contentDisposition(contentDisposition: Int) {
		LayoutNodeExternal.setContentDisposition(this.handle, contentDisposition)
	}

	/**
	 * @method contentArrangement
	 * @since 0.1.0
	 * @hidden
	 */
	public fun contentArrangement(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"center" -> this.contentArrangement(kDLLayoutContentArrangementCenter)
				"start"  -> this.contentArrangement(kDLLayoutContentArrangementStart)
				"end"    -> this.contentArrangement(kDLLayoutContentArrangementEnd)

			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method contentArrangement
	 * @since 0.1.0
	 * @hidden
	 */
	public fun contentArrangement(contentArrangement: Int) {
		LayoutNodeExternal.setContentArrangement(this.handle, contentArrangement)
	}

	/**
	 * @method contentTop
	 * @since 0.1.0
	 */
	open fun contentTop(value: Property) {

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.contentTop(kDLLayoutContentPositionTypeLength, kDLLayoutContentPositionUnitPX, value.number)
				else            -> this.contentTop(kDLLayoutContentPositionTypeLength, kDLLayoutContentPositionUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method contentTop
	 * @since 0.1.0
	 */
	open fun contentTop(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setContentTop(this.handle, type, unit, length)
	}

	/**
	 * @method contentLeft
	 * @since 0.1.0
	 */
	open fun contentLeft(value: Property) {

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.contentLeft(kDLLayoutContentPositionTypeLength, kDLLayoutContentPositionUnitPX, value.number)
				else            -> this.contentLeft(kDLLayoutContentPositionTypeLength, kDLLayoutContentPositionUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method contentLeft
	 * @since 0.1.0
	 */
	open fun contentLeft(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setContentLeft(this.handle, type, unit, length)
	}

	/**
	 * @method contentWidth
	 * @since 0.1.0
	 * @hidden
	 */
	public fun contentWidth(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"auto" -> this.contentWidth(kDLLayoutContentSizeTypeAuto, kDLLayoutContentSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, value.number)
				PropertyUnit.PC -> this.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPC, value.number)
				PropertyUnit.VW -> this.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitVW, value.number)
				PropertyUnit.VH -> this.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitVH, value.number)
				PropertyUnit.PW -> this.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPW, value.number)
				PropertyUnit.PH -> this.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPH, value.number)
				PropertyUnit.CW -> this.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitCW, value.number)
				PropertyUnit.CH -> this.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitCH, value.number)
				else            -> this.contentWidth(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method contentWidth
	 * @since 0.1.0
	 * @hidden
	 */
	public fun contentWidth(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setContentWidth(this.handle, type, unit, length)
	}

	/**
	 * @method contentHeight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun contentHeight(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"auto" -> this.contentHeight(kDLLayoutContentSizeTypeAuto, kDLLayoutContentSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, value.number)
				PropertyUnit.PC -> this.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPC, value.number)
				PropertyUnit.VW -> this.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitVW, value.number)
				PropertyUnit.VH -> this.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitVH, value.number)
				PropertyUnit.PW -> this.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPW, value.number)
				PropertyUnit.PH -> this.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPH, value.number)
				PropertyUnit.CW -> this.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitCW, value.number)
				PropertyUnit.CH -> this.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitCH, value.number)
				else            -> this.contentHeight(kDLLayoutContentSizeTypeLength, kDLLayoutContentSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method contentHeight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun contentHeight(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setContentHeight(this.handle, type, unit, length)
	}

	/**
	 * @method borderTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun borderTop(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"thin" -> this.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, value.number)
				PropertyUnit.PC -> this.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPC, value.number)
				PropertyUnit.VW -> this.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVW, value.number)
				PropertyUnit.VH -> this.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVH, value.number)
				PropertyUnit.PW -> this.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPW, value.number)
				PropertyUnit.PH -> this.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPH, value.number)
				PropertyUnit.CW -> this.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCW, value.number)
				PropertyUnit.CH -> this.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCH, value.number)
				else            -> this.borderTop(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method borderTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun borderTop(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setBorderTop(this.handle, type, unit, length)
	}

	/**
	 * @method borderLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun borderLeft(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"thin" -> this.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, value.number)
				PropertyUnit.PC -> this.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPC, value.number)
				PropertyUnit.VW -> this.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVW, value.number)
				PropertyUnit.VH -> this.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVH, value.number)
				PropertyUnit.PW -> this.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPW, value.number)
				PropertyUnit.PH -> this.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPH, value.number)
				PropertyUnit.CW -> this.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCW, value.number)
				PropertyUnit.CH -> this.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCH, value.number)
				else            -> this.borderLeft(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method borderLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun borderLeft(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setBorderLeft(this.handle, type, unit, length)
	}

	/**
	 * @method borderRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun borderRight(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"thin" -> this.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, value.number)
				PropertyUnit.PC -> this.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPC, value.number)
				PropertyUnit.VW -> this.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVW, value.number)
				PropertyUnit.VH -> this.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVH, value.number)
				PropertyUnit.PW -> this.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPW, value.number)
				PropertyUnit.PH -> this.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPH, value.number)
				PropertyUnit.CW -> this.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCW, value.number)
				PropertyUnit.CH -> this.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCH, value.number)
				else            -> this.borderRight(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method borderRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun borderRight(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setBorderRight(this.handle, type, unit, length)
	}

	/**
	 * @method borderBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun borderBottom(value: Property) {

		if (value.type == PropertyType.STRING) {

			when (value.string) {
				"thin" -> this.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, value.number)
				PropertyUnit.PC -> this.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPC, value.number)
				PropertyUnit.VW -> this.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVW, value.number)
				PropertyUnit.VH -> this.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitVH, value.number)
				PropertyUnit.PW -> this.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPW, value.number)
				PropertyUnit.PH -> this.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPH, value.number)
				PropertyUnit.CW -> this.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCW, value.number)
				PropertyUnit.CH -> this.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitCH, value.number)
				else            -> this.borderBottom(kDLLayoutBorderTypeLength, kDLLayoutBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method borderBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun borderBottom(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setBorderBottom(this.handle, type, unit, length)
	}

	/**
	 * @method marginTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun marginTop(value: Property) {

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, value.number)
				PropertyUnit.PC -> this.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPC, value.number)
				PropertyUnit.VW -> this.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVW, value.number)
				PropertyUnit.VH -> this.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVH, value.number)
				PropertyUnit.PW -> this.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPW, value.number)
				PropertyUnit.PH -> this.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPH, value.number)
				PropertyUnit.CW -> this.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCW, value.number)
				PropertyUnit.CH -> this.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCH, value.number)
				else            -> this.marginTop(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method marginTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun marginTop(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setMarginTop(this.handle, type, unit, length)
	}

	/**
	 * @method marginLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun marginLeft(value: Property) {

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, value.number)
				PropertyUnit.PC -> this.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPC, value.number)
				PropertyUnit.VW -> this.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVW, value.number)
				PropertyUnit.VH -> this.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVH, value.number)
				PropertyUnit.PW -> this.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPW, value.number)
				PropertyUnit.PH -> this.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPH, value.number)
				PropertyUnit.CW -> this.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCW, value.number)
				PropertyUnit.CH -> this.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCH, value.number)
				else            -> this.marginLeft(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method marginLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun marginLeft(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setMarginLeft(this.handle, type, unit, length)
	}

	/**
	 * @method marginRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun marginRight(value: Property) {

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, value.number)
				PropertyUnit.PC -> this.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPC, value.number)
				PropertyUnit.VW -> this.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVW, value.number)
				PropertyUnit.VH -> this.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVH, value.number)
				PropertyUnit.PW -> this.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPW, value.number)
				PropertyUnit.PH -> this.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPH, value.number)
				PropertyUnit.CW -> this.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCW, value.number)
				PropertyUnit.CH -> this.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCH, value.number)
				else            -> this.marginRight(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method marginRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun marginRight(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setMarginRight(this.handle, type, unit, length)
	}

	/**
	 * @method marginBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun marginBottom(value: Property) {

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, value.number)
				PropertyUnit.PC -> this.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPC, value.number)
				PropertyUnit.VW -> this.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVW, value.number)
				PropertyUnit.VH -> this.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitVH, value.number)
				PropertyUnit.PW -> this.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPW, value.number)
				PropertyUnit.PH -> this.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPH, value.number)
				PropertyUnit.CW -> this.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCW, value.number)
				PropertyUnit.CH -> this.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitCH, value.number)
				else            -> this.marginBottom(kDLLayoutMarginTypeLength, kDLLayoutMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method marginBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun marginBottom(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setMarginBottom(this.handle, type, unit, length)
	}

	/**
	 * @method minMarginTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minMarginTop(min: Double) {
		LayoutNodeExternal.setMinMarginTop(this.handle, min)
	}

	/**
	 * @method maxMarginTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxMarginTop(max: Double) {
		LayoutNodeExternal.setMaxMarginTop(this.handle, max)
	}

	/**
	 * @method minMarginLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minMarginLeft(min: Double) {
		LayoutNodeExternal.setMinMarginLeft(this.handle, min)
	}

	/**
	 * @method maxMarginLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxMarginLeft(max: Double) {
		LayoutNodeExternal.setMaxMarginLeft(this.handle, max)
	}

	/**
	 * @method minMarginRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minMarginRight(min: Double) {
		LayoutNodeExternal.setMinMarginRight(this.handle, min)
	}

	/**
	 * @method maxMarginRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxMarginRight(max: Double) {
		LayoutNodeExternal.setMaxMarginRight(this.handle, max)
	}

	/**
	 * @method minMarginBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minMarginBottom(min: Double) {
		LayoutNodeExternal.setMinMarginBottom(this.handle, min)
	}

	/**
	 * @method maxMarginBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxMarginBottom(max: Double) {
		LayoutNodeExternal.setMaxMarginBottom(this.handle, max)
	}

	/**
	 * @method paddingTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun paddingTop(value: Property) {

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, value.number)
				PropertyUnit.PC -> this.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPC, value.number)
				PropertyUnit.VW -> this.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVW, value.number)
				PropertyUnit.VH -> this.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVH, value.number)
				PropertyUnit.PW -> this.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPW, value.number)
				PropertyUnit.PH -> this.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPH, value.number)
				PropertyUnit.CW -> this.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCW, value.number)
				PropertyUnit.CH -> this.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCH, value.number)
				else            -> this.paddingTop(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method paddingTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun paddingTop(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setPaddingTop(this.handle, type, unit, length)
	}

	/**
	 * @method paddingLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun paddingLeft(value: Property) {

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, value.number)
				PropertyUnit.PC -> this.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPC, value.number)
				PropertyUnit.VW -> this.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVW, value.number)
				PropertyUnit.VH -> this.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVH, value.number)
				PropertyUnit.PW -> this.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPW, value.number)
				PropertyUnit.PH -> this.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPH, value.number)
				PropertyUnit.CW -> this.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCW, value.number)
				PropertyUnit.CH -> this.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCH, value.number)
				else            -> this.paddingLeft(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method paddingLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun paddingLeft(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setPaddingLeft(this.handle, type, unit, length)
	}

	/**
	 * @method paddingRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun paddingRight(value: Property) {

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, value.number)
				PropertyUnit.PC -> this.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPC, value.number)
				PropertyUnit.VW -> this.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVW, value.number)
				PropertyUnit.VH -> this.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVH, value.number)
				PropertyUnit.PW -> this.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPW, value.number)
				PropertyUnit.PH -> this.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPH, value.number)
				PropertyUnit.CW -> this.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCW, value.number)
				PropertyUnit.CH -> this.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCH, value.number)
				else            -> this.paddingRight(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method paddingRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun paddingRight(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setPaddingRight(this.handle, type, unit, length)
	}

	/**
	 * @method paddingBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun paddingBottom(value: Property) {

		if (value.type == PropertyType.NUMBER) {

			when (value.unit) {
				PropertyUnit.PX -> this.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, value.number)
				PropertyUnit.PC -> this.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPC, value.number)
				PropertyUnit.VW -> this.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVW, value.number)
				PropertyUnit.VH -> this.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitVH, value.number)
				PropertyUnit.PW -> this.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPW, value.number)
				PropertyUnit.PH -> this.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPH, value.number)
				PropertyUnit.CW -> this.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCW, value.number)
				PropertyUnit.CH -> this.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitCH, value.number)
				else            -> this.paddingBottom(kDLLayoutPaddingTypeLength, kDLLayoutPaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method paddingBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun paddingBottom(type: Int, unit: Int, length: Double) {
		LayoutNodeExternal.setPaddingBottom(this.handle, type, unit, length)
	}

	/**
	 * @method minPaddingTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minPaddingTop(min: Double) {
		LayoutNodeExternal.setMinPaddingTop(this.handle, min)
	}

	/**
	 * @method maxPaddingTop
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxPaddingTop(max: Double) {
		LayoutNodeExternal.setMaxPaddingTop(this.handle, max)
	}

	/**
	 * @method minPaddingLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minPaddingLeft(min: Double) {
		LayoutNodeExternal.setMinPaddingLeft(this.handle, min)
	}

	/**
	 * @method maxPaddingLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxPaddingLeft(max: Double) {
		LayoutNodeExternal.setMaxPaddingLeft(this.handle, max)
	}

	/**
	 * @method minPaddingRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minPaddingRight(min: Double) {
		LayoutNodeExternal.setMinPaddingRight(this.handle, min)
	}

	/**
	 * @method maxPaddingRight
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxPaddingRight(max: Double) {
		LayoutNodeExternal.setMaxPaddingRight(this.handle, max)
	}

	/**
	 * @method minPaddingBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun minPaddingBottom(min: Double) {
		LayoutNodeExternal.setMinPaddingBottom(this.handle, min)
	}

	/**
	 * @method maxPaddingBottom
	 * @since 0.1.0
	 * @hidden
	 */
	public fun maxPaddingBottom(max: Double) {
		LayoutNodeExternal.setMaxPaddingBottom(this.handle, max)
	}

	/**
	 * @method expand
	 * @since 0.1.0
	 * @hidden
	 */
	public fun expand(ratio: Double) {
		LayoutNodeExternal.setExpand(this.handle, ratio)
	}

	/**
	 * @method shrink
	 * @since 0.1.0
	 * @hidden
	 */
	public fun shrink(ratio: Double) {
		LayoutNodeExternal.setShrink(this.handle, ratio)
	}

	/**
	 * @method invalidate
	 * @since 0.1.0
	 * @hidden
	 */
	public fun invalidate() {
		LayoutNodeExternal.invalidate(this.handle)
	}

	/**
	 * @method invalidateSize
	 * @since 0.1.0
	 * @hidden
	 */
	public fun invalidateSize() {
		LayoutNodeExternal.invalidateSize(this.handle)
	}

	/**
	 * @method invalidatePosition
	 * @since 0.1.0
	 * @hidden
	 */
	public fun invalidatePosition() {
		LayoutNodeExternal.invalidatePosition(this.handle)
	}

	/**
	 * @method resolve
	 * @since 0.1.0
	 * @hidden
	 */
	public fun resolve() {
		LayoutNodeExternal.resolve(this.handle)
	}

	/**
	 * @method measure
	 * @since 0.1.0
	 * @hidden
	 */
	public fun measure() {
		LayoutNodeExternal.measure(this.handle)
	}

	/**
	 * @method appendChild
	 * @since 0.1.0
	 * @hidden
	 */
	public fun appendChild(node: LayoutNode) {
		LayoutNodeExternal.appendChild(this.handle, node.handle)
	}

	/**
	 * @method insertChild
	 * @since 0.1.0
	 * @hidden
	 */
	public fun insertChild(node: LayoutNode, at: Int) {
		LayoutNodeExternal.insertChild(this.handle, node.handle, at)
	}

	/**
	 * @method removeChild
	 * @since 0.1.0
	 * @hidden
	 */
	public fun removeChild(node: LayoutNode) {
		LayoutNodeExternal.removeChild(this.handle, node.handle)
	}

	//-------------------------------------------------------------------------
	// Private API
	//-------------------------------------------------------------------------

	/**
	 * @method prepareCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun prepareCallback() {
		this.listener?.prepareLayoutNode(this)
	}

	/**
	 * @method measureCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun measureCallback(w: Double, h: Double, minw: Double, maxw: Double, minh: Double, maxh: Double): SizeF {

		val area = SizeF(w.toValidFloat(), h.toValidFloat())
		val min = SizeF(minw.toValidFloat(), minh.toValidFloat())
		val max = SizeF(maxw.toValidFloat(), maxh.toValidFloat())

		val size = this.listener?.measureLayoutNode(this, area, min, max)
		if (size == null) {
			return SizeF(-1f, -1f)
		}

		return size
	}

	/**
	 * @method resolveSizeCallback
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun resolveSizeCallback() {
		this.listener?.onResolveSize(this)
	}

	/**
	 * @method resolvePositionCallback
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun resolvePositionCallback() {
		this.listener?.onResolvePosition(this)
	}

	/**
	 * @method resolveInnerSizeCallback
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun resolveInnerSizeCallback() {
		this.listener?.onResolveInnerSize(this)
	}

	/**
	 * @method resolveContentSizeCallback
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun resolveContentSizeCallback() {
		this.listener?.onResolveContentSize(this)
	}

	/**
	 * @method resolveMarginCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun resolveMarginCallback() {
		this.listener?.onResolveMargin(this)
	}

	/**
	 * @method resolveBorderCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun resolveBorderCallback() {
		this.listener?.onResolveBorder(this)
	}

	/**
	 * @method resolvePaddingCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun resolvePaddingCallback() {
		this.listener?.onResolvePadding(this)
	}

	/**
	 * @method invalidateCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun invalidateCallback() {
		this.listener?.onInvalidateLayout(this)
	}

	/**
	 * @method layoutBeganCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun layoutBeganCallback() {
		this.listener?.onBeginLayout(this)
	}

	/**
	 * @method layoutEndedCallback
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun layoutEndedCallback() {
		this.listener?.onFinishLayout(this)
	}
}