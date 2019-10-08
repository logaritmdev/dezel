package ca.logaritm.dezel.view.display

import android.util.SizeF
import ca.logaritm.dezel.core.JavaScriptProperty
import ca.logaritm.dezel.core.JavaScriptPropertyType
import ca.logaritm.dezel.core.JavaScriptPropertyUnit
import ca.logaritm.dezel.extension.type.toValidFloat
import ca.logaritm.dezel.view.graphic.Convert

public class DisplayNode(display: Display) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The display node's listener.
	 * @property listener
	 * @since 0.7.0
	 */
	public var listener: DisplayNodeListener? = null

	/**
	 * The display node's display.
	 * @property display
	 * @since 0.7.0
	 */
	public var display: Display = display
		private set

	/**
	 * The display node's id.
	 * @property id
	 * @since 0.7.0
	 */
	public var id: String = ""
		set(value) {
			DisplayNodeExternal.setId(this.handle, value)
		}

	/**
	 * The display node's measured top.
	 * @property measuredTop
	 * @since 0.7.0
	 */
	public val measuredTop: Double
		get() = DisplayNodeExternal.getMeasuredTop(this.handle)

	/**
	 * The display node's measured left.
	 * @property measuredLeft
	 * @since 0.7.0
	 */
	public val measuredLeft: Double
		get() = DisplayNodeExternal.getMeasuredLeft(this.handle)

	/**
	 * The display node's measured right.
	 * @property measuredRight
	 * @since 0.7.0
	 */
	public val measuredRight: Double
		get() = DisplayNodeExternal.getMeasuredRight(this.handle)

	/**
	 * The display node's measured bottom.
	 * @property measuredBottom
	 * @since 0.7.0
	 */
	public val measuredBottom: Double
		get() = DisplayNodeExternal.getMeasuredBottom(this.handle)

	/**
	 * The display node's measured width.
	 * @property measuredWidth
	 * @since 0.7.0
	 */
	public val measuredWidth: Double
		get() = DisplayNodeExternal.getMeasuredWidth(this.handle)

	/**
	 * The display node's measured height.
	 * @property measuredHeight
	 * @since 0.7.0
	 */
	public val measuredHeight: Double
		get() = DisplayNodeExternal.getMeasuredHeight(this.handle)

	/**
	 * The display node's measured inner width.
	 * @property measuredInnerWidth
	 * @since 0.7.0
	 */
	public val measuredInnerWidth: Double
		get() = DisplayNodeExternal.getMeasuredInnerWidth(this.handle)

	/**
	 * The display node's measured inner height.
	 * @property measuredInnerHeight
	 * @since 0.7.0
	 */
	public val measuredInnerHeight: Double
		get() = DisplayNodeExternal.getMeasuredInnerHeight(this.handle)

	/**
	 * The display node's measured content width.
	 * @property measuredContentWidth
	 * @since 0.7.0
	 */
	public val measuredContentWidth: Double
		get() = DisplayNodeExternal.getMeasuredContentWidth(this.handle)

	/**
	 * The display node's measured content height.
	 * @property measuredContentHeight
	 * @since 0.7.0
	 */
	public val measuredContentHeight: Double
		get() = DisplayNodeExternal.getMeasuredContentHeight(this.handle)

	/**
	 * The display node's measured top margin.
	 * @property measuredMarginTop
	 * @since 0.7.0
	 */
	public val measuredMarginTop: Double
		get() = DisplayNodeExternal.getMeasuredMarginTop(this.handle)

	/**
	 * The display node's measured left margin.
	 * @property measuredMarginLeft
	 * @since 0.7.0
	 */
	public val measuredMarginLeft: Double
		get() = DisplayNodeExternal.getMeasuredMarginLeft(this.handle)

	/**
	 * The display node's measured right margin.
	 * @property measuredMarginRight
	 * @since 0.7.0
	 */
	public val measuredMarginRight: Double
		get() = DisplayNodeExternal.getMeasuredMarginRight(this.handle)

	/**
	 * The display node's measured bottom margin.
	 * @property measuredMarginBottom
	 * @since 0.7.0
	 */
	public val measuredMarginBottom: Double
		get() = DisplayNodeExternal.getMeasuredMarginBottom(this.handle)

	/**
	 * The display node's measured top border.
	 * @property measuredBorderTop
	 * @since 0.7.0
	 */
	public val measuredBorderTop: Double
		get() = DisplayNodeExternal.getMeasuredBorderTop(this.handle)

	/**
	 * The display node's measured left border.
	 * @property measuredBorderLeft
	 * @since 0.7.0
	 */
	public val measuredBorderLeft: Double
		get() = DisplayNodeExternal.getMeasuredBorderLeft(this.handle)

	/**
	 * The display node's measured right border.
	 * @property measuredBorderRight
	 * @since 0.7.0
	 */
	public val measuredBorderRight: Double
		get() = DisplayNodeExternal.getMeasuredBorderRight(this.handle)

	/**
	 * The display node's measured bottom border.
	 * @property measuredBorderBottom
	 * @since 0.7.0
	 */
	public val measuredBorderBottom: Double
		get() = DisplayNodeExternal.getMeasuredBorderBottom(this.handle)

	/**
	 * The display node's measured top padding.
	 * @property measuredPaddingTop
	 * @since 0.7.0
	 */
	public val measuredPaddingTop: Double
		get() = DisplayNodeExternal.getMeasuredPaddingTop(this.handle)

	/**
	 * The display node's measured left padding.
	 * @property measuredPaddingLeft
	 * @since 0.7.0
	 */
	public val measuredPaddingLeft: Double
		get() = DisplayNodeExternal.getMeasuredPaddingLeft(this.handle)

	/**
	 * The display node's measured right padding.
	 * @property measuredPaddingRight
	 * @since 0.7.0
	 */
	public val measuredPaddingRight: Double
		get() = DisplayNodeExternal.getMeasuredPaddingRight(this.handle)

	/**
	 * The display node's measured bottom padding.
	 * @property measuredPaddingBottom
	 * @since 0.7.0
	 */
	public val measuredPaddingBottom: Double
		get() = DisplayNodeExternal.getMeasuredPaddingBottom(this.handle)

	/**
	 * Whether the display node should fill the parent's width.
	 * @property isFillingParentWidth
	 * @since 0.7.0
	 */
	public val isFillingParentWidth: Boolean
		get() = DisplayNodeExternal.isFillingParentWidth(this.handle)

	/**
	 * Whether the display node should fill the parent's height.
	 * @property isFillingParentHeight
	 * @since 0.7.0
	 */
	public val isFillingParentHeight: Boolean
		get() = DisplayNodeExternal.isFillingParentHeight(this.handle)

	/**
	 * Whether the display node should wraps the content width.
	 * @property isWrappingContentWidth
	 * @since 0.7.0
	 */
	public val isWrappingContentWidth: Boolean
		get() = DisplayNodeExternal.isWrappingContentWidth(this.handle)

	/**
	 * Whether the display node should wraps the content height.
	 * @property isWrappingContentHeight
	 * @since 0.7.0
	 */
	public val isWrappingContentHeight: Boolean
		get() = DisplayNodeExternal.isWrappingContentHeight(this.handle)

	/**
	 * @property handle
	 * @since 0.7.0
	 * @hidden
	 */
	public var handle: Long = 0
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {
		this.handle = DisplayNodeExternal.create(this)
		DisplayNodeExternal.setDisplay(this.handle, display.handle)
		DisplayNodeReference.register(this)
	}

	/**
	 * Assigns the display node's top anchor position.
	 * @method setAnchorTop
	 * @since 0.7.0
	 */
	public fun setAnchorTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"top"    -> this.setAnchorTop(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, 0.0)
				"center" -> this.setAnchorTop(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, 50.0)
				"bottom" -> this.setAnchorTop(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, 100.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PC -> this.setAnchorTop(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, value.number)
				else                      -> this.setAnchorTop(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, value.number * 100)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's top anchor position.
	 * @method setAnchorTop
	 * @since 0.7.0
	 */
	public fun setAnchorTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setAnchorTop(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's left anchor position.
	 * @method setAnchorLeft
	 * @since 0.7.0
	 */
	public fun setAnchorLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"left"   -> this.setAnchorLeft(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, 0.0)
				"center" -> this.setAnchorLeft(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, 50.0)
				"right"  -> this.setAnchorLeft(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, 100.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PC -> this.setAnchorLeft(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, value.number)
				else                      -> this.setAnchorLeft(kDisplayNodeAnchorTypeLength, kDisplayNodeAnchorUnitPC, value.number * 100)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's left anchor position.
	 * @method setAnchorLeft
	 * @since 0.7.0
	 */
	public fun setAnchorLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setAnchorLeft(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's top position specification.
	 * @method setTop
	 * @since 0.7.0
	 */
	public fun setTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setTop(kDisplayNodeOriginTypeAuto, kDisplayNodeOriginUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCH, value.number)
				else                      -> this.setTop(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's top position specification.
	 * @method setTop
	 * @since 0.7.0
	 */
	public fun setTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setTop(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum top position.
	 * @method setMinTop
	 * @since 0.7.0
	 */
	public fun setMinTop(min: Double) {
		DisplayNodeExternal.setMinTop(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum top position.
	 * @method setMaxTop
	 * @since 0.7.0
	 */
	public fun setMaxTop(max: Double) {
		DisplayNodeExternal.setMaxTop(this.handle, max)
	}

	/**
	 * Assigns the display node's left position specification.
	 * @method setLeft
	 * @since 0.7.0
	 */
	public fun setLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setLeft(kDisplayNodeOriginTypeAuto, kDisplayNodeOriginUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCH, value.number)
				else                      -> this.setLeft(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's left position specification.
	 * @method setLeft
	 * @since 0.7.0
	 */
	public fun setLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setLeft(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum left position.
	 * @method setMinLeft
	 * @since 0.7.0
	 */
	public fun setMinLeft(min: Double) {
		DisplayNodeExternal.setMinLeft(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum left position.
	 * @method setMaxLeft
	 * @since 0.7.0
	 */
	public fun setMaxLeft(max: Double) {
		DisplayNodeExternal.setMaxLeft(this.handle, max)
	}

	/**
	 * Assigns the display node's right position specification.
	 * @method setRight
	 * @since 0.7.0
	 */
	public fun setRight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setRight(kDisplayNodeOriginTypeAuto, kDisplayNodeOriginUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCH, value.number)
				else                      -> this.setRight(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setRight
	 * @since 0.7.0
	 * @hidden
	 */
	public fun setRight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setRight(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum right position.
	 * @method setMinRight
	 * @since 0.7.0
	 */
	public fun setMinRight(min: Double) {
		DisplayNodeExternal.setMinRight(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum right position.
	 * @method setMaxRight
	 * @since 0.7.0
	 */
	public fun setMaxRight(max: Double) {
		DisplayNodeExternal.setMaxRight(this.handle, max)
	}

	/**
	 * Assigns the display node's bottom position specification.
	 * @method setBottom
	 * @since 0.7.0
	 */
	public fun setBottom(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setBottom(kDisplayNodeOriginTypeAuto, kDisplayNodeOriginUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitCH, value.number)
				else                      -> this.setBottom(kDisplayNodeOriginTypeLength, kDisplayNodeOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's bottom position specification.
	 * @method setBottom
	 * @since 0.7.0
	 */
	public fun setBottom(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setBottom(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum bottom position.
	 * @method setMinBottom
	 * @since 0.7.0
	 */
	public fun setMinBottom(min: Double) {
		DisplayNodeExternal.setMinBottom(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum bottom position.
	 * @method setMaxBottom
	 * @since 0.7.0
	 */
	public fun setMaxBottom(max: Double) {
		DisplayNodeExternal.setMaxBottom(this.handle, max)
	}

	/**
	 * Assigns the display node's width specification.
	 * @method setWidth
	 * @since 0.7.0
	 */
	public fun setWidth(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"fill" -> this.setWidth(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
				"wrap" -> this.setWidth(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitCH, value.number)
				else                      -> this.setWidth(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's width specification.
	 * @method setWidth
	 * @since 0.7.0
	 */
	public fun setWidth(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setWidth(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum width.
	 * @method setMinWidth
	 * @since 0.7.0
	 */
	public fun setMinWidth(min: Double) {
		DisplayNodeExternal.setMinWidth(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum width.
	 * @method setMaxWidth
	 * @since 0.7.0
	 */
	public fun setMaxWidth(max: Double) {
		DisplayNodeExternal.setMaxWidth(this.handle, max)
	}

	/**
	 * Assigns the display node's height specification.
	 * @method setHeight
	 * @since 0.7.0
	 */
	public fun setHeight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"fill" -> this.setHeight(kDisplayNodeSizeTypeFill, kDisplayNodeSizeUnitNone, 0.0)
				"wrap" -> this.setHeight(kDisplayNodeSizeTypeWrap, kDisplayNodeSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitCH, value.number)
				else                      -> this.setHeight(kDisplayNodeSizeTypeLength, kDisplayNodeSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's height specification.
	 * @method setHeight
	 * @since 0.7.0
	 */
	public fun setHeight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setHeight(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum height.
	 * @method setMinHeight
	 * @since 0.7.0
	 */
	public fun setMinHeight(min: Double) {
		DisplayNodeExternal.setMinHeight(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum height.
	 * @method setMaxHeight
	 * @since 0.7.0
	 */
	public fun setMaxHeight(max: Double) {
		DisplayNodeExternal.setMaxHeight(this.handle, max)
	}

	/**
	 * Assigns the display node's content direction specification.
	 * @method setContentDirection
	 * @since 0.7.0
	 */
	public fun setContentDirection(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"horizontal" -> this.setContentDirection(kDisplayNodeContentDirectionHorizontal)
				"vertical"   -> this.setContentDirection(kDisplayNodeContentDirectionVertical)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's content direction specification.
	 * @method setContentDirection
	 * @since 0.7.0
	 */
	public fun setContentDirection(direction: Int) {
		DisplayNodeExternal.setContentDirection(this.handle, direction)
	}

	/**
	 * Assigns the display node's content alignment specification.
	 * @method setContentAlignment
	 * @since 0.7.0
	 */
	public fun setContentAlignment(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"center" -> this.setContentAlignment(kDisplayNodeContentAlignmentCenter)
				"start"  -> this.setContentAlignment(kDisplayNodeContentAlignmentStart)
				"end"    -> this.setContentAlignment(kDisplayNodeContentAlignmentEnd)

			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's content alignment specification.
	 * @method setContentAlignment
	 * @since 0.7.0
	 */
	public fun setContentAlignment(setContentAlignment: Int) {
		DisplayNodeExternal.setContentAlignment(this.handle, setContentAlignment)
	}

	/**
	 * Assigns the display node's content location specification.
	 * @method setContentLocation
	 * @since 0.7.0
	 */
	public fun setContentLocation(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"center"        -> this.setContentLocation(kDisplayNodeContentLocationCenter)
				"start"         -> this.setContentLocation(kDisplayNodeContentLocationStart)
				"end"           -> this.setContentLocation(kDisplayNodeContentLocationEnd)
				"space-around"  -> this.setContentLocation(kDisplayNodeContentLocationSpaceAround)
				"space-evenly"  -> this.setContentLocation(kDisplayNodeContentLocationSpaceEvenly)
				"space-between" -> this.setContentLocation(kDisplayNodeContentLocationSpaceBetween)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's content location specification.
	 * @method setContentLocation
	 * @since 0.7.0
	 */
	public fun setContentLocation(setContentLocation: Int) {
		DisplayNodeExternal.setContentLocation(this.handle, setContentLocation)
	}

	/**
	 * Assigns the display node's content top specification.
	 * @method setContentTop
	 * @since 0.7.0
	 */
	public fun setContentTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setContentTop(kDisplayNodeContentOriginTypeLength, kDisplayNodeContentOriginUnitPX, value.number)
				else                      -> this.setContentTop(kDisplayNodeContentOriginTypeLength, kDisplayNodeContentOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's content top specification.
	 * @method setContentTop
	 * @since 0.7.0
	 */
	public fun setContentTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setContentTop(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's content left specification.
	 * @method setContentLeft
	 * @since 0.7.0
	 */
	public fun setContentLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setContentLeft(kDisplayNodeContentOriginTypeLength, kDisplayNodeContentOriginUnitPX, value.number)
				else                      -> this.setContentLeft(kDisplayNodeContentOriginTypeLength, kDisplayNodeContentOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's content left specification.
	 * @method setContentLeft
	 * @since 0.7.0
	 */
	public fun setContentLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setContentLeft(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's content width specification.
	 * @method setContentWidth
	 * @since 0.7.0
	 */
	public fun setContentWidth(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setContentWidth(kDisplayNodeContentSizeTypeAuto, kDisplayNodeContentSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitCH, value.number)
				else                      -> this.setContentWidth(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's content width specification.
	 * @method setContentWidth
	 * @since 0.7.0
	 */
	public fun setContentWidth(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setContentWidth(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's content height specification.
	 * @method setContentHeight
	 * @since 0.7.0
	 */
	public fun setContentHeight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setContentHeight(kDisplayNodeContentSizeTypeAuto, kDisplayNodeContentSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitCH, value.number)
				else                      -> this.setContentHeight(kDisplayNodeContentSizeTypeLength, kDisplayNodeContentSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's content height specification.
	 * @method setContentHeight
	 * @since 0.7.0
	 */
	public fun setContentHeight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setContentHeight(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's border top specification.
	 * @method setBorderTop
	 * @since 0.7.0
	 */
	public fun setBorderTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"thin" -> this.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, value.number)
				else                      -> this.setBorderTop(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's border top specification.
	 * @method setBorderTop
	 * @since 0.7.0
	 */
	public fun setBorderTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setBorderTop(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's border left specification.
	 * @method setBorderLeft
	 * @since 0.7.0
	 */
	public fun setBorderLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"thin" -> this.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, value.number)
				else                      -> this.setBorderLeft(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's border left specification.
	 * @method setBorderLeft
	 * @since 0.7.0
	 */
	public fun setBorderLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setBorderLeft(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's border right specification.
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public fun setBorderRight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"thin" -> this.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, value.number)
				else                      -> this.setBorderRight(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's border right specification.
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public fun setBorderRight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setBorderRight(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's border right specification.
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public fun setBorderBottom(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"thin" -> this.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitCH, value.number)
				else                      -> this.setBorderBottom(kDisplayNodeBorderTypeLength, kDisplayNodeBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's border right specification.
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public fun setBorderBottom(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setBorderBottom(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's margin top specification.
	 * @method setMarginTop
	 * @since 0.7.0
	 */
	public fun setMarginTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCH, value.number)
				else                      -> this.setMarginTop(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's margin top specification.
	 * @method setMarginTop
	 * @since 0.7.0
	 */
	public fun setMarginTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setMarginTop(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's margin left specification.
	 * @method setMarginLeft
	 * @since 0.7.0
	 */
	public fun setMarginLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCH, value.number)
				else                      -> this.setMarginLeft(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's margin left specification.
	 * @method setMarginLeft
	 * @since 0.7.0
	 */
	public fun setMarginLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setMarginLeft(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's margin right specification.
	 * @method setMarginRight
	 * @since 0.7.0
	 */
	public fun setMarginRight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCH, value.number)
				else                      -> this.setMarginRight(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's margin right specification.
	 * @method setMarginRight
	 * @since 0.7.0
	 */
	public fun setMarginRight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setMarginRight(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's margin bottom specification.
	 * @method setMarginBottom
	 * @since 0.7.0
	 */
	public fun setMarginBottom(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitCH, value.number)
				else                      -> this.setMarginBottom(kDisplayNodeMarginTypeLength, kDisplayNodeMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's margin bottom specification.
	 * @method setMarginBottom
	 * @since 0.7.0
	 */
	public fun setMarginBottom(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setMarginBottom(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum top margin.
	 * @method setMinMarginTop
	 * @since 0.7.0
	 */
	public fun setMinMarginTop(min: Double) {
		DisplayNodeExternal.setMinMarginTop(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum top margin.
	 * @method setMaxMarginTop
	 * @since 0.7.0
	 */
	public fun setMaxMarginTop(max: Double) {
		DisplayNodeExternal.setMaxMarginTop(this.handle, max)
	}

	/**
	 * Assigns the display node's minimum left margin.
	 * @method setMinMarginLeft
	 * @since 0.7.0
	 */
	public fun setMinMarginLeft(min: Double) {
		DisplayNodeExternal.setMinMarginLeft(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum left margin.
	 * @method setMaxMarginLeft
	 * @since 0.7.0
	 */
	public fun setMaxMarginLeft(max: Double) {
		DisplayNodeExternal.setMaxMarginLeft(this.handle, max)
	}

	/**
	 * Assigns the display node's minimum right margin.
	 * @method setMinMarginRight
	 * @since 0.7.0
	 */
	public fun setMinMarginRight(min: Double) {
		DisplayNodeExternal.setMinMarginRight(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum right margin.
	 * @method setMaxMarginRight
	 * @since 0.7.0
	 */
	public fun setMaxMarginRight(max: Double) {
		DisplayNodeExternal.setMaxMarginRight(this.handle, max)
	}

	/**
	 * Assigns the display node's minimum bottom margin.
	 * @method setMinMarginBottom
	 * @since 0.7.0
	 */
	public fun setMinMarginBottom(min: Double) {
		DisplayNodeExternal.setMinMarginBottom(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum bottom margin.
	 * @method setMaxMarginBottom
	 * @since 0.7.0
	 */
	public fun setMaxMarginBottom(max: Double) {
		DisplayNodeExternal.setMaxMarginBottom(this.handle, max)
	}

	/**
	 * Assigns the display node's padding top specification.
	 * @method setPaddingTop
	 * @since 0.7.0
	 */
	public fun setPaddingTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, value.number)
				else                      -> this.setPaddingTop(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's padding top specification.
	 * @method setPaddingTop
	 * @since 0.7.0
	 */
	public fun setPaddingTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setPaddingTop(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's padding left specification.
	 * @method setPaddingLeft
	 * @since 0.7.0
	 */
	public fun setPaddingLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, value.number)
				else                      -> this.setPaddingLeft(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's padding left specification.
	 * @method setPaddingLeft
	 * @since 0.7.0
	 */
	public fun setPaddingLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setPaddingLeft(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's padding right specification.
	 * @method setPaddingRight
	 * @since 0.7.0
	 */
	public fun setPaddingRight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, value.number)
				else                      -> this.setPaddingRight(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's padding right specification.
	 * @method setPaddingRight
	 * @since 0.7.0
	 */
	public fun setPaddingRight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setPaddingRight(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's padding bottom specification.
	 * @method setPaddingBottom
	 * @since 0.7.0
	 */
	public fun setPaddingBottom(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitCH, value.number)
				else                      -> this.setPaddingBottom(kDisplayNodePaddingTypeLength, kDisplayNodePaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * Assigns the display node's padding bottom specification.
	 * @method setPaddingBottom
	 * @since 0.7.0
	 */
	public fun setPaddingBottom(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setPaddingBottom(this.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum top padding.
	 * @method setMinPaddingTop
	 * @since 0.7.0
	 */
	public fun setMinPaddingTop(min: Double) {
		DisplayNodeExternal.setMinPaddingTop(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum top padding.
	 * @method setMaxPaddingTop
	 * @since 0.7.0
	 */
	public fun setMaxPaddingTop(max: Double) {
		DisplayNodeExternal.setMaxPaddingTop(this.handle, max)
	}

	/**
	 * Assigns the display node's minimum left padding.
	 * @method setMinPaddingLeft
	 * @since 0.7.0
	 */
	public fun setMinPaddingLeft(min: Double) {
		DisplayNodeExternal.setMinPaddingLeft(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum left padding.
	 * @method setMaxPaddingLeft
	 * @since 0.7.0
	 */
	public fun setMaxPaddingLeft(max: Double) {
		DisplayNodeExternal.setMaxPaddingLeft(this.handle, max)
	}

	/**
	 * Assigns the display node's minimum right padding.
	 * @method setMinPaddingRight
	 * @since 0.7.0
	 */
	public fun setMinPaddingRight(min: Double) {
		DisplayNodeExternal.setMinPaddingRight(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum right padding.
	 * @method setMaxPaddingRight
	 * @since 0.7.0
	 */
	public fun setMaxPaddingRight(max: Double) {
		DisplayNodeExternal.setMaxPaddingRight(this.handle, max)
	}

	/**
	 * Assigns the display node's minimum bottom padding.
	 * @method setMinPaddingBottom
	 * @since 0.7.0
	 */
	public fun setMinPaddingBottom(min: Double) {
		DisplayNodeExternal.setMinPaddingBottom(this.handle, min)
	}

	/**
	 * Assigns the display node's maximum bottom padding.
	 * @method setMaxPaddingBottom
	 * @since 0.7.0
	 */
	public fun setMaxPaddingBottom(max: Double) {
		DisplayNodeExternal.setMaxPaddingBottom(this.handle, max)
	}

	/**
	 * Assigns the factor by which the display node's will expand to fill remaining space.
	 * @method setExpandFactor
	 * @since 0.7.0
	 */
	public fun setExpandFactor(factor: Double) {
		DisplayNodeExternal.setExpandFactor(this.handle, factor)
	}

	/**
	 * Assigns the factor by which the display node's will shrink to fit available space.
	 * @method setShrinkFactor
	 * @since 0.7.0
	 */
	public fun setShrinkFactor(factor: Double) {
		DisplayNodeExternal.setShrinkFactor(this.handle, factor)
	}

	/**
	 * Assigns the display node's visibility status.
	 * @method setVisible
	 * @since 0.7.0
	 */
	public fun setVisible(value: Boolean) {
		DisplayNodeExternal.setVisible(this.handle, value)
	}


	public fun setType(type: String) {

	}

	public fun appendStyle(style: String) {

	}

	public fun removeStyle(style: String) {

	}

	public fun appendState(state: String) {

	}

	public fun removeState(state: String) {

	}

	public fun invalidateSize() {
// TODO
	}

	public fun invalidateOrigin() {
// TODO
	}

	public fun invalidateLayout() {
		// TODO
	}

	/**
	 * Resolves the whole hierarchy.
	 * @method resolve
	 * @since 0.7.0
	 */
	public fun resolve() {
		DisplayNodeExternal.resolve(this.handle)
	}

	/**
	 * Measures this node.
	 * @method measure
	 * @since 0.7.0
	 */
	public fun measure() {
		DisplayNodeExternal.measure(this.handle)
	}

	/**
	 * Appends a node to the receiver's children list.
	 * @method appendChild
	 * @since 0.7.0
	 */
	public fun appendChild(node: DisplayNode) {
		DisplayNodeExternal.appendChild(this.handle, node.handle)
	}

	/**
	 * Inserts a node to the receiver's children list.
	 * @method insertChild
	 * @since 0.7.0
	 */
	public fun insertChild(node: DisplayNode, at: Int) {
		DisplayNodeExternal.insertChild(this.handle, node.handle, at)
	}

	/**
	 * Removes a node from the receiver's children list.
	 * @method removeChild
	 * @since 0.7.0
	 */
	public fun removeChild(node: DisplayNode) {
		DisplayNodeExternal.removeChild(this.handle, node.handle)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * Called when the node needs to be measured manually.
	 * @method measure
	 * @since 0.7.0
	 */
	@Suppress("unused")
	private fun measure(w: Double, h: Double, minw: Double, maxw: Double, minh: Double, maxh: Double): SizeF {

		val area = SizeF(w.toValidFloat(), h.toValidFloat())
		val min = SizeF(minw.toValidFloat(), minh.toValidFloat())
		val max = SizeF(maxw.toValidFloat(), maxh.toValidFloat())

		val size = this.listener?.measure(this, area, min, max)
		if (size == null) {
			return SizeF(-1f, -1f)
		}

		return size
	}

	/**
	 * @method onInvalidate
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun onInvalidate() {
		this.listener?.onInvalidate(this)
	}

	/**
	 * @method onResolveSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun onResolveSize() {
		this.listener?.onResolveSize(this)
	}

	/**
	 * @method onResolveOrigin
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun onResolveOrigin() {
		this.listener?.onResolveOrigin(this)
	}

	/**
	 * @method onResolveInnerSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun onResolveInnerSize() {
		this.listener?.onResolveInnerSize(this)
	}

	/**
	 * @method onResolveContentSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun onResolveContentSize() {
		this.listener?.onResolveContentSize(this)
	}

	/**
	 * @method onResolveMargin
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun onResolveMargin() {
		this.listener?.onResolveMargin(this)
	}

	/**
	 * @method onResolveBorder
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun onResolveBorder() {
		this.listener?.onResolveBorder(this)
	}

	/**
	 * @method onResolvePadding
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun onResolvePadding() {
		this.listener?.onResolvePadding(this)
	}

	/**
	 * @method layoutBegan
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun layoutBegan() {
		this.listener?.layoutBegan(this)
	}

	/**
	 * @method layoutEnded
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun layoutEnded() {
		this.listener?.layoutEnded(this)
	}
}

const val kDisplayNodeAnchorTypeLength = 1
const val kDisplayNodeAnchorUnitPC = 1
const val kDisplayNodeSizeTypeFill = 1
const val kDisplayNodeSizeTypeWrap = 2
const val kDisplayNodeSizeTypeLength = 3
const val kDisplayNodeSizeUnitNone = 1
const val kDisplayNodeSizeUnitPX = 2
const val kDisplayNodeSizeUnitPC = 3
const val kDisplayNodeSizeUnitVW = 4
const val kDisplayNodeSizeUnitVH = 5
const val kDisplayNodeSizeUnitPW = 6
const val kDisplayNodeSizeUnitPH = 7
const val kDisplayNodeSizeUnitCW = 8
const val kDisplayNodeSizeUnitCH = 9
const val kDisplayNodeOriginTypeAuto = 1
const val kDisplayNodeOriginTypeLength = 2
const val kDisplayNodeOriginUnitNone = 1
const val kDisplayNodeOriginUnitPX = 2
const val kDisplayNodeOriginUnitPC = 3
const val kDisplayNodeOriginUnitVW = 4
const val kDisplayNodeOriginUnitVH = 5
const val kDisplayNodeOriginUnitPW = 6
const val kDisplayNodeOriginUnitPH = 7
const val kDisplayNodeOriginUnitCW = 8
const val kDisplayNodeOriginUnitCH = 9
const val kDisplayNodeContentOriginTypeLength = 1
const val kDisplayNodeContentOriginUnitNone = 1
const val kDisplayNodeContentOriginUnitPX = 2
const val kDisplayNodeContentSizeTypeAuto = 1
const val kDisplayNodeContentSizeTypeLength = 2
const val kDisplayNodeContentSizeUnitNone = 1
const val kDisplayNodeContentSizeUnitPX = 2
const val kDisplayNodeContentSizeUnitPC = 3
const val kDisplayNodeContentSizeUnitVW = 4
const val kDisplayNodeContentSizeUnitVH = 5
const val kDisplayNodeContentSizeUnitPW = 6
const val kDisplayNodeContentSizeUnitPH = 7
const val kDisplayNodeContentSizeUnitCW = 8
const val kDisplayNodeContentSizeUnitCH = 9
const val kDisplayNodeContentDirectionVertical = 1
const val kDisplayNodeContentDirectionHorizontal = 2
const val kDisplayNodeContentAlignmentStart = 1
const val kDisplayNodeContentAlignmentCenter = 2
const val kDisplayNodeContentAlignmentEnd = 3
const val kDisplayNodeContentLocationStart = 1
const val kDisplayNodeContentLocationCenter = 2
const val kDisplayNodeContentLocationEnd = 3
const val kDisplayNodeContentLocationSpaceAround = 4
const val kDisplayNodeContentLocationSpaceBetween = 5
const val kDisplayNodeContentLocationSpaceEvenly = 6
const val kDisplayNodeBorderTypeLength = 1
const val kDisplayNodeBorderUnitPX = 1
const val kDisplayNodeBorderUnitPC = 2
const val kDisplayNodeBorderUnitVW = 3
const val kDisplayNodeBorderUnitVH = 4
const val kDisplayNodeBorderUnitPW = 5
const val kDisplayNodeBorderUnitPH = 6
const val kDisplayNodeBorderUnitCW = 7
const val kDisplayNodeBorderUnitCH = 8
const val kDisplayNodeMarginTypeLength = 1
const val kDisplayNodeMarginUnitPX = 1
const val kDisplayNodeMarginUnitPC = 2
const val kDisplayNodeMarginUnitVW = 3
const val kDisplayNodeMarginUnitVH = 4
const val kDisplayNodeMarginUnitPW = 5
const val kDisplayNodeMarginUnitPH = 6
const val kDisplayNodeMarginUnitCW = 7
const val kDisplayNodeMarginUnitCH = 8
const val kDisplayNodePaddingTypeLength = 1
const val kDisplayNodePaddingUnitPX = 1
const val kDisplayNodePaddingUnitPC = 2
const val kDisplayNodePaddingUnitVW = 3
const val kDisplayNodePaddingUnitVH = 4
const val kDisplayNodePaddingUnitPW = 5
const val kDisplayNodePaddingUnitPH = 6
const val kDisplayNodePaddingUnitCW = 7
const val kDisplayNodePaddingUnitCH = 8