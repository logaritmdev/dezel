package ca.logaritm.dezel.view.display

import android.util.Log
import android.util.SizeF
import ca.logaritm.dezel.core.JavaScriptProperty
import ca.logaritm.dezel.core.JavaScriptPropertyType
import ca.logaritm.dezel.core.JavaScriptPropertyUnit
import ca.logaritm.dezel.extension.core.reset
import ca.logaritm.dezel.extension.type.toValidFloat
import ca.logaritm.dezel.view.display.external.DisplayNodeExternal
import ca.logaritm.dezel.view.display.external.PropertyExternal
import ca.logaritm.dezel.view.display.value.ValueList
import ca.logaritm.dezel.view.graphic.Convert

/**
 * @class DisplayNode
 * @since 0.7.0
 */
public class DisplayNode(display: Display) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property listener
	 * @since 0.7.0
	 */
	public var listener: DisplayNodeListener? = null

	/**
	 * @property display
	 * @since 0.7.0
	 */
	public var display: Display = display
		private set

	/**
	 * @property measuredTop
	 * @since 0.7.0
	 */
	public val measuredTop: Double
		get() = DisplayNodeExternal.getMeasuredTop(this.handle)

	/**
	 * @property measuredLeft
	 * @since 0.7.0
	 */
	public val measuredLeft: Double
		get() = DisplayNodeExternal.getMeasuredLeft(this.handle)

	/**
	 * @property measuredRight
	 * @since 0.7.0
	 */
	public val measuredRight: Double
		get() = DisplayNodeExternal.getMeasuredRight(this.handle)

	/**
	 * @property measuredBottom
	 * @since 0.7.0
	 */
	public val measuredBottom: Double
		get() = DisplayNodeExternal.getMeasuredBottom(this.handle)

	/**
	 * @property measuredWidth
	 * @since 0.7.0
	 */
	public val measuredWidth: Double
		get() = DisplayNodeExternal.getMeasuredWidth(this.handle)

	/**
	 * @property measuredHeight
	 * @since 0.7.0
	 */
	public val measuredHeight: Double
		get() = DisplayNodeExternal.getMeasuredHeight(this.handle)

	/**
	 * @property measuredInnerWidth
	 * @since 0.7.0
	 */
	public val measuredInnerWidth: Double
		get() = DisplayNodeExternal.getMeasuredInnerWidth(this.handle)

	/**
	 * @property measuredInnerHeight
	 * @since 0.7.0
	 */
	public val measuredInnerHeight: Double
		get() = DisplayNodeExternal.getMeasuredInnerHeight(this.handle)

	/**
	 * @property measuredContentWidth
	 * @since 0.7.0
	 */
	public val measuredContentWidth: Double
		get() = DisplayNodeExternal.getMeasuredContentWidth(this.handle)

	/**
	 * @property measuredContentHeight
	 * @since 0.7.0
	 */
	public val measuredContentHeight: Double
		get() = DisplayNodeExternal.getMeasuredContentHeight(this.handle)

	/**
	 * @property measuredMarginTop
	 * @since 0.7.0
	 */
	public val measuredMarginTop: Double
		get() = DisplayNodeExternal.getMeasuredMarginTop(this.handle)

	/**
	 * @property measuredMarginLeft
	 * @since 0.7.0
	 */
	public val measuredMarginLeft: Double
		get() = DisplayNodeExternal.getMeasuredMarginLeft(this.handle)

	/**
	 * @property measuredMarginRight
	 * @since 0.7.0
	 */
	public val measuredMarginRight: Double
		get() = DisplayNodeExternal.getMeasuredMarginRight(this.handle)

	/**
	 * @property measuredMarginBottom
	 * @since 0.7.0
	 */
	public val measuredMarginBottom: Double
		get() = DisplayNodeExternal.getMeasuredMarginBottom(this.handle)

	/**
	 * @property measuredBorderTop
	 * @since 0.7.0
	 */
	public val measuredBorderTop: Double
		get() = DisplayNodeExternal.getMeasuredBorderTop(this.handle)

	/**
	 * @property measuredBorderLeft
	 * @since 0.7.0
	 */
	public val measuredBorderLeft: Double
		get() = DisplayNodeExternal.getMeasuredBorderLeft(this.handle)

	/**
	 * @property measuredBorderRight
	 * @since 0.7.0
	 */
	public val measuredBorderRight: Double
		get() = DisplayNodeExternal.getMeasuredBorderRight(this.handle)

	/**
	 * @property measuredBorderBottom
	 * @since 0.7.0
	 */
	public val measuredBorderBottom: Double
		get() = DisplayNodeExternal.getMeasuredBorderBottom(this.handle)

	/**
	 * @property measuredPaddingTop
	 * @since 0.7.0
	 */
	public val measuredPaddingTop: Double
		get() = DisplayNodeExternal.getMeasuredPaddingTop(this.handle)

	/**
	 * @property measuredPaddingLeft
	 * @since 0.7.0
	 */
	public val measuredPaddingLeft: Double
		get() = DisplayNodeExternal.getMeasuredPaddingLeft(this.handle)

	/**
	 * @property measuredPaddingRight
	 * @since 0.7.0
	 */
	public val measuredPaddingRight: Double
		get() = DisplayNodeExternal.getMeasuredPaddingRight(this.handle)

	/**
	 * @property measuredPaddingBottom
	 * @since 0.7.0
	 */
	public val measuredPaddingBottom: Double
		get() = DisplayNodeExternal.getMeasuredPaddingBottom(this.handle)

	/**
	 * @property isFillingParentWidth
	 * @since 0.7.0
	 */
	public val isFillingParentWidth: Boolean
		get() = DisplayNodeExternal.isFillingParentWidth(this.handle)

	/**
	 * @property isFillingParentHeight
	 * @since 0.7.0
	 */
	public val isFillingParentHeight: Boolean
		get() = DisplayNodeExternal.isFillingParentHeight(this.handle)

	/**
	 * @property isWrappingContentWidth
	 * @since 0.7.0
	 */
	public val isWrappingContentWidth: Boolean
		get() = DisplayNodeExternal.isWrappingContentWidth(this.handle)

	/**
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
	 * @method setOpaque
	 * @since 0.7.0
	 */
	public fun setOpaque() {
		DisplayNodeExternal.setOpaque(this.handle)
	}

	/**
	 * @method setName
	 * @since 0.7.0
	 */
	public fun setName(name: String) {
		DisplayNodeExternal.setName(this.handle, name)
	}

	/**
	 * @method setType
	 * @since 0.7.0
	 */
	public fun setType(type: String) {
		DisplayNodeExternal.setType(this.handle, type)
	}

	/**
	 * @method appendStyle
	 * @since 0.7.0
	 */
	public fun appendStyle(style: String) {
		DisplayNodeExternal.appendStyle(this.handle, style)
	}

	/**
	 * @method removeStyle
	 * @since 0.7.0
	 */
	public fun removeStyle(style: String) {
		DisplayNodeExternal.removeStyle(this.handle, style)
	}

	/**
	 * @method hasStyle
	 * @since 0.7.0
	 */
	public fun hasStyle(style: String): Boolean {
		return DisplayNodeExternal.hasStyle(this.handle, style)
	}

	/**
	 * @method appendState
	 * @since 0.7.0
	 */
	public fun appendState(state: String) {
		DisplayNodeExternal.appendState(this.handle, state)
	}

	/**
	 * @method removeState
	 * @since 0.7.0
	 */
	public fun removeState(state: String) {
		DisplayNodeExternal.removeState(this.handle, state)
	}

	/**
	 * @method hasState
	 * @since 0.7.0
	 */
	public fun hasState(state: String): Boolean {
		return DisplayNodeExternal.hasState(this.handle, state)
	}
	
	/**
	 * @method setAnchorTop
	 * @since 0.7.0
	 */
	public fun setAnchorTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"top"    -> this.setAnchorTop(kAnchorTypeLength, kAnchorUnitPC, 0.0)
				"center" -> this.setAnchorTop(kAnchorTypeLength, kAnchorUnitPC, 50.0)
				"bottom" -> this.setAnchorTop(kAnchorTypeLength, kAnchorUnitPC, 100.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PC -> this.setAnchorTop(kAnchorTypeLength, kAnchorUnitPC, value.number)
				else                      -> this.setAnchorTop(kAnchorTypeLength, kAnchorUnitPC, value.number * 100)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setAnchorTop
	 * @since 0.7.0
	 */
	public fun setAnchorTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setAnchorTop(this.handle, type, unit, length)
	}

	/**
	 * @method setAnchorLeft
	 * @since 0.7.0
	 */
	public fun setAnchorLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"left"   -> this.setAnchorLeft(kAnchorTypeLength, kAnchorUnitPC, 0.0)
				"center" -> this.setAnchorLeft(kAnchorTypeLength, kAnchorUnitPC, 50.0)
				"right"  -> this.setAnchorLeft(kAnchorTypeLength, kAnchorUnitPC, 100.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PC -> this.setAnchorLeft(kAnchorTypeLength, kAnchorUnitPC, value.number)
				else                      -> this.setAnchorLeft(kAnchorTypeLength, kAnchorUnitPC, value.number * 100)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setAnchorLeft
	 * @since 0.7.0
	 */
	public fun setAnchorLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setAnchorLeft(this.handle, type, unit, length)
	}

	/**
	 * @method setTop
	 * @since 0.7.0
	 */
	public fun setTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setTop(kOriginTypeAuto, kOriginUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setTop(kOriginTypeLength, kOriginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setTop(kOriginTypeLength, kOriginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setTop(kOriginTypeLength, kOriginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setTop(kOriginTypeLength, kOriginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setTop(kOriginTypeLength, kOriginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setTop(kOriginTypeLength, kOriginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setTop(kOriginTypeLength, kOriginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setTop(kOriginTypeLength, kOriginUnitCH, value.number)
				else                      -> this.setTop(kOriginTypeLength, kOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type ${value.type} ${value.string}.")
	}

	/**
	 * @method setTop
	 * @since 0.7.0
	 */
	public fun setTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setTop(this.handle, type, unit, length)
	}

	/**
	 * @method setMinTop
	 * @since 0.7.0
	 */
	public fun setMinTop(min: Double) {
		DisplayNodeExternal.setMinTop(this.handle, min)
	}

	/**
	 * @method setMaxTop
	 * @since 0.7.0
	 */
	public fun setMaxTop(max: Double) {
		DisplayNodeExternal.setMaxTop(this.handle, max)
	}

	/**
	 * @method setLeft
	 * @since 0.7.0
	 */
	public fun setLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setLeft(kOriginTypeAuto, kOriginUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setLeft(kOriginTypeLength, kOriginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setLeft(kOriginTypeLength, kOriginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setLeft(kOriginTypeLength, kOriginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setLeft(kOriginTypeLength, kOriginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setLeft(kOriginTypeLength, kOriginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setLeft(kOriginTypeLength, kOriginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setLeft(kOriginTypeLength, kOriginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setLeft(kOriginTypeLength, kOriginUnitCH, value.number)
				else                      -> this.setLeft(kOriginTypeLength, kOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setLeft
	 * @since 0.7.0
	 */
	public fun setLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setLeft(this.handle, type, unit, length)
	}

	/**
	 * @method setMinLeft
	 * @since 0.7.0
	 */
	public fun setMinLeft(min: Double) {
		DisplayNodeExternal.setMinLeft(this.handle, min)
	}

	/**
	 * @method setMaxLeft
	 * @since 0.7.0
	 */
	public fun setMaxLeft(max: Double) {
		DisplayNodeExternal.setMaxLeft(this.handle, max)
	}

	/**
	 * @method setRight
	 * @since 0.7.0
	 */
	public fun setRight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setRight(kOriginTypeAuto, kOriginUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setRight(kOriginTypeLength, kOriginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setRight(kOriginTypeLength, kOriginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setRight(kOriginTypeLength, kOriginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setRight(kOriginTypeLength, kOriginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setRight(kOriginTypeLength, kOriginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setRight(kOriginTypeLength, kOriginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setRight(kOriginTypeLength, kOriginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setRight(kOriginTypeLength, kOriginUnitCH, value.number)
				else                      -> this.setRight(kOriginTypeLength, kOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setRight
	 * @since 0.7.0
	 */
	public fun setRight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setRight(this.handle, type, unit, length)
	}

	/**
	 * @method setMinRight
	 * @since 0.7.0
	 */
	public fun setMinRight(min: Double) {
		DisplayNodeExternal.setMinRight(this.handle, min)
	}

	/**
	 * @method setMaxRight
	 * @since 0.7.0
	 */
	public fun setMaxRight(max: Double) {
		DisplayNodeExternal.setMaxRight(this.handle, max)
	}

	/**
	 * @method setBottom
	 * @since 0.7.0
	 */
	public fun setBottom(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setBottom(kOriginTypeAuto, kOriginUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setBottom(kOriginTypeLength, kOriginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setBottom(kOriginTypeLength, kOriginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setBottom(kOriginTypeLength, kOriginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setBottom(kOriginTypeLength, kOriginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setBottom(kOriginTypeLength, kOriginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setBottom(kOriginTypeLength, kOriginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setBottom(kOriginTypeLength, kOriginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setBottom(kOriginTypeLength, kOriginUnitCH, value.number)
				else                      -> this.setBottom(kOriginTypeLength, kOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setBottom
	 * @since 0.7.0
	 */
	public fun setBottom(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setBottom(this.handle, type, unit, length)
	}

	/**
	 * @method setMinBottom
	 * @since 0.7.0
	 */
	public fun setMinBottom(min: Double) {
		DisplayNodeExternal.setMinBottom(this.handle, min)
	}

	/**
	 * @method setMaxBottom
	 * @since 0.7.0
	 */
	public fun setMaxBottom(max: Double) {
		DisplayNodeExternal.setMaxBottom(this.handle, max)
	}

	/**
	 * @method setWidth
	 * @since 0.7.0
	 */
	public fun setWidth(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"fill" -> this.setWidth(kSizeTypeFill, kSizeUnitNone, 0.0)
				"wrap" -> this.setWidth(kSizeTypeWrap, kSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setWidth(kSizeTypeLength, kSizeUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setWidth(kSizeTypeLength, kSizeUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setWidth(kSizeTypeLength, kSizeUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setWidth(kSizeTypeLength, kSizeUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setWidth(kSizeTypeLength, kSizeUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setWidth(kSizeTypeLength, kSizeUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setWidth(kSizeTypeLength, kSizeUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setWidth(kSizeTypeLength, kSizeUnitCH, value.number)
				else                      -> this.setWidth(kSizeTypeLength, kSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setWidth
	 * @since 0.7.0
	 */
	public fun setWidth(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setWidth(this.handle, type, unit, length)
	}

	/**
	 * @method setMinWidth
	 * @since 0.7.0
	 */
	public fun setMinWidth(min: Double) {
		DisplayNodeExternal.setMinWidth(this.handle, min)
	}

	/**
	 * @method setMaxWidth
	 * @since 0.7.0
	 */
	public fun setMaxWidth(max: Double) {
		DisplayNodeExternal.setMaxWidth(this.handle, max)
	}

	/**
	 * @method setHeight
	 * @since 0.7.0
	 */
	public fun setHeight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"fill" -> this.setHeight(kSizeTypeFill, kSizeUnitNone, 0.0)
				"wrap" -> this.setHeight(kSizeTypeWrap, kSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setHeight(kSizeTypeLength, kSizeUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setHeight(kSizeTypeLength, kSizeUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setHeight(kSizeTypeLength, kSizeUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setHeight(kSizeTypeLength, kSizeUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setHeight(kSizeTypeLength, kSizeUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setHeight(kSizeTypeLength, kSizeUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setHeight(kSizeTypeLength, kSizeUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setHeight(kSizeTypeLength, kSizeUnitCH, value.number)
				else                      -> this.setHeight(kSizeTypeLength, kSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setHeight
	 * @since 0.7.0
	 */
	public fun setHeight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setHeight(this.handle, type, unit, length)
	}

	/**
	 * @method setMinHeight
	 * @since 0.7.0
	 */
	public fun setMinHeight(min: Double) {
		DisplayNodeExternal.setMinHeight(this.handle, min)
	}

	/**
	 * @method setMaxHeight
	 * @since 0.7.0
	 */
	public fun setMaxHeight(max: Double) {
		DisplayNodeExternal.setMaxHeight(this.handle, max)
	}

	/**
	 * @method setContentDirection
	 * @since 0.7.0
	 */
	public fun setContentDirection(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"horizontal" -> this.setContentDirection(kContentDirectionHorizontal)
				"vertical"   -> this.setContentDirection(kContentDirectionVertical)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setContentDirection
	 * @since 0.7.0
	 */
	public fun setContentDirection(direction: Int) {
		DisplayNodeExternal.setContentDirection(this.handle, direction)
	}

	/**
	 * @method setContentAlignment
	 * @since 0.7.0
	 */
	public fun setContentAlignment(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"center" -> this.setContentAlignment(kContentAlignmentCenter)
				"start"  -> this.setContentAlignment(kContentAlignmentStart)
				"end"    -> this.setContentAlignment(kContentAlignmentEnd)

			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setContentAlignment
	 * @since 0.7.0
	 */
	public fun setContentAlignment(setContentAlignment: Int) {
		DisplayNodeExternal.setContentAlignment(this.handle, setContentAlignment)
	}

	/**
	 * @method setContentDisposition
	 * @since 0.7.0
	 */
	public fun setContentDisposition(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"center"        -> this.setContentDisposition(kContentDispositionCenter)
				"start"         -> this.setContentDisposition(kContentDispositionStart)
				"end"           -> this.setContentDisposition(kContentDispositionEnd)
				"space-around"  -> this.setContentDisposition(kContentDispositionSpaceAround)
				"space-evenly"  -> this.setContentDisposition(kContentDispositionSpaceEvenly)
				"space-between" -> this.setContentDisposition(kContentDispositionSpaceBetween)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setContentDisposition
	 * @since 0.7.0
	 */
	public fun setContentDisposition(setContentDisposition: Int) {
		DisplayNodeExternal.setContentDisposition(this.handle, setContentDisposition)
	}

	/**
	 * @method setContentTop
	 * @since 0.7.0
	 */
	public fun setContentTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setContentTop(kContentOriginTypeLength, kContentOriginUnitPX, value.number)
				else                      -> this.setContentTop(kContentOriginTypeLength, kContentOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setContentTop
	 * @since 0.7.0
	 */
	public fun setContentTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setContentTop(this.handle, type, unit, length)
	}

	/**
	 * @method setContentLeft
	 * @since 0.7.0
	 */
	public fun setContentLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setContentLeft(kContentOriginTypeLength, kContentOriginUnitPX, value.number)
				else                      -> this.setContentLeft(kContentOriginTypeLength, kContentOriginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setContentLeft
	 * @since 0.7.0
	 */
	public fun setContentLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setContentLeft(this.handle, type, unit, length)
	}

	/**
	 * @method setContentWidth
	 * @since 0.7.0
	 */
	public fun setContentWidth(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setContentWidth(kContentSizeTypeAuto, kContentSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setContentWidth(kContentSizeTypeLength, kContentSizeUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setContentWidth(kContentSizeTypeLength, kContentSizeUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setContentWidth(kContentSizeTypeLength, kContentSizeUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setContentWidth(kContentSizeTypeLength, kContentSizeUnitCH, value.number)
				else                      -> this.setContentWidth(kContentSizeTypeLength, kContentSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setContentWidth
	 * @since 0.7.0
	 */
	public fun setContentWidth(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setContentWidth(this.handle, type, unit, length)
	}

	/**
	 * @method setContentHeight
	 * @since 0.7.0
	 */
	public fun setContentHeight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"auto" -> this.setContentHeight(kContentSizeTypeAuto, kContentSizeUnitNone, 0.0)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setContentHeight(kContentSizeTypeLength, kContentSizeUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setContentHeight(kContentSizeTypeLength, kContentSizeUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setContentHeight(kContentSizeTypeLength, kContentSizeUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setContentHeight(kContentSizeTypeLength, kContentSizeUnitCH, value.number)
				else                      -> this.setContentHeight(kContentSizeTypeLength, kContentSizeUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setContentHeight
	 * @since 0.7.0
	 */
	public fun setContentHeight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setContentHeight(this.handle, type, unit, length)
	}

	/**
	 * @method setBorderTop
	 * @since 0.7.0
	 */
	public fun setBorderTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"thin" -> this.setBorderTop(kBorderTypeLength, kBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setBorderTop(kBorderTypeLength, kBorderUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setBorderTop(kBorderTypeLength, kBorderUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setBorderTop(kBorderTypeLength, kBorderUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setBorderTop(kBorderTypeLength, kBorderUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setBorderTop(kBorderTypeLength, kBorderUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setBorderTop(kBorderTypeLength, kBorderUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setBorderTop(kBorderTypeLength, kBorderUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setBorderTop(kBorderTypeLength, kBorderUnitCH, value.number)
				else                      -> this.setBorderTop(kBorderTypeLength, kBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setBorderTop
	 * @since 0.7.0
	 */
	public fun setBorderTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setBorderTop(this.handle, type, unit, length)
	}

	/**
	 * @method setBorderLeft
	 * @since 0.7.0
	 */
	public fun setBorderLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"thin" -> this.setBorderLeft(kBorderTypeLength, kBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setBorderLeft(kBorderTypeLength, kBorderUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setBorderLeft(kBorderTypeLength, kBorderUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setBorderLeft(kBorderTypeLength, kBorderUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setBorderLeft(kBorderTypeLength, kBorderUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setBorderLeft(kBorderTypeLength, kBorderUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setBorderLeft(kBorderTypeLength, kBorderUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setBorderLeft(kBorderTypeLength, kBorderUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setBorderLeft(kBorderTypeLength, kBorderUnitCH, value.number)
				else                      -> this.setBorderLeft(kBorderTypeLength, kBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setBorderLeft
	 * @since 0.7.0
	 */
	public fun setBorderLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setBorderLeft(this.handle, type, unit, length)
	}

	/**
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public fun setBorderRight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"thin" -> this.setBorderRight(kBorderTypeLength, kBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setBorderRight(kBorderTypeLength, kBorderUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setBorderRight(kBorderTypeLength, kBorderUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setBorderRight(kBorderTypeLength, kBorderUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setBorderRight(kBorderTypeLength, kBorderUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setBorderRight(kBorderTypeLength, kBorderUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setBorderRight(kBorderTypeLength, kBorderUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setBorderRight(kBorderTypeLength, kBorderUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setBorderRight(kBorderTypeLength, kBorderUnitCH, value.number)
				else                      -> this.setBorderRight(kBorderTypeLength, kBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public fun setBorderRight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setBorderRight(this.handle, type, unit, length)
	}

	/**
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public fun setBorderBottom(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.STRING) {

			when (value.string) {
				"thin" -> this.setBorderBottom(kBorderTypeLength, kBorderUnitPX, 1.0 / Convert.density)
			}

			return
		}

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setBorderBottom(kBorderTypeLength, kBorderUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setBorderBottom(kBorderTypeLength, kBorderUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setBorderBottom(kBorderTypeLength, kBorderUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setBorderBottom(kBorderTypeLength, kBorderUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setBorderBottom(kBorderTypeLength, kBorderUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setBorderBottom(kBorderTypeLength, kBorderUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setBorderBottom(kBorderTypeLength, kBorderUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setBorderBottom(kBorderTypeLength, kBorderUnitCH, value.number)
				else                      -> this.setBorderBottom(kBorderTypeLength, kBorderUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public fun setBorderBottom(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setBorderBottom(this.handle, type, unit, length)
	}

	/**
	 * @method setMarginTop
	 * @since 0.7.0
	 */
	public fun setMarginTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setMarginTop(kMarginTypeLength, kMarginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setMarginTop(kMarginTypeLength, kMarginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setMarginTop(kMarginTypeLength, kMarginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setMarginTop(kMarginTypeLength, kMarginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setMarginTop(kMarginTypeLength, kMarginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setMarginTop(kMarginTypeLength, kMarginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setMarginTop(kMarginTypeLength, kMarginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setMarginTop(kMarginTypeLength, kMarginUnitCH, value.number)
				else                      -> this.setMarginTop(kMarginTypeLength, kMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setMarginTop
	 * @since 0.7.0
	 */
	public fun setMarginTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setMarginTop(this.handle, type, unit, length)
	}

	/**
	 * @method setMarginLeft
	 * @since 0.7.0
	 */
	public fun setMarginLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setMarginLeft(kMarginTypeLength, kMarginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setMarginLeft(kMarginTypeLength, kMarginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setMarginLeft(kMarginTypeLength, kMarginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setMarginLeft(kMarginTypeLength, kMarginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setMarginLeft(kMarginTypeLength, kMarginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setMarginLeft(kMarginTypeLength, kMarginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setMarginLeft(kMarginTypeLength, kMarginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setMarginLeft(kMarginTypeLength, kMarginUnitCH, value.number)
				else                      -> this.setMarginLeft(kMarginTypeLength, kMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setMarginLeft
	 * @since 0.7.0
	 */
	public fun setMarginLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setMarginLeft(this.handle, type, unit, length)
	}

	/**
	 * @method setMarginRight
	 * @since 0.7.0
	 */
	public fun setMarginRight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setMarginRight(kMarginTypeLength, kMarginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setMarginRight(kMarginTypeLength, kMarginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setMarginRight(kMarginTypeLength, kMarginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setMarginRight(kMarginTypeLength, kMarginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setMarginRight(kMarginTypeLength, kMarginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setMarginRight(kMarginTypeLength, kMarginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setMarginRight(kMarginTypeLength, kMarginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setMarginRight(kMarginTypeLength, kMarginUnitCH, value.number)
				else                      -> this.setMarginRight(kMarginTypeLength, kMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setMarginRight
	 * @since 0.7.0
	 */
	public fun setMarginRight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setMarginRight(this.handle, type, unit, length)
	}

	/**
	 * @method setMarginBottom
	 * @since 0.7.0
	 */
	public fun setMarginBottom(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setMarginBottom(kMarginTypeLength, kMarginUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setMarginBottom(kMarginTypeLength, kMarginUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setMarginBottom(kMarginTypeLength, kMarginUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setMarginBottom(kMarginTypeLength, kMarginUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setMarginBottom(kMarginTypeLength, kMarginUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setMarginBottom(kMarginTypeLength, kMarginUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setMarginBottom(kMarginTypeLength, kMarginUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setMarginBottom(kMarginTypeLength, kMarginUnitCH, value.number)
				else                      -> this.setMarginBottom(kMarginTypeLength, kMarginUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setMarginBottom
	 * @since 0.7.0
	 */
	public fun setMarginBottom(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setMarginBottom(this.handle, type, unit, length)
	}

	/**
	 * @method setMinMarginTop
	 * @since 0.7.0
	 */
	public fun setMinMarginTop(min: Double) {
		DisplayNodeExternal.setMinMarginTop(this.handle, min)
	}

	/**
	 * @method setMaxMarginTop
	 * @since 0.7.0
	 */
	public fun setMaxMarginTop(max: Double) {
		DisplayNodeExternal.setMaxMarginTop(this.handle, max)
	}

	/**
	 * @method setMinMarginLeft
	 * @since 0.7.0
	 */
	public fun setMinMarginLeft(min: Double) {
		DisplayNodeExternal.setMinMarginLeft(this.handle, min)
	}

	/**
	 * @method setMaxMarginLeft
	 * @since 0.7.0
	 */
	public fun setMaxMarginLeft(max: Double) {
		DisplayNodeExternal.setMaxMarginLeft(this.handle, max)
	}

	/**
	 * @method setMinMarginRight
	 * @since 0.7.0
	 */
	public fun setMinMarginRight(min: Double) {
		DisplayNodeExternal.setMinMarginRight(this.handle, min)
	}

	/**
	 * @method setMaxMarginRight
	 * @since 0.7.0
	 */
	public fun setMaxMarginRight(max: Double) {
		DisplayNodeExternal.setMaxMarginRight(this.handle, max)
	}

	/**
	 * @method setMinMarginBottom
	 * @since 0.7.0
	 */
	public fun setMinMarginBottom(min: Double) {
		DisplayNodeExternal.setMinMarginBottom(this.handle, min)
	}

	/**
	 * @method setMaxMarginBottom
	 * @since 0.7.0
	 */
	public fun setMaxMarginBottom(max: Double) {
		DisplayNodeExternal.setMaxMarginBottom(this.handle, max)
	}

	/**
	 * @method setPaddingTop
	 * @since 0.7.0
	 */
	public fun setPaddingTop(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setPaddingTop(kPaddingTypeLength, kPaddingUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setPaddingTop(kPaddingTypeLength, kPaddingUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setPaddingTop(kPaddingTypeLength, kPaddingUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setPaddingTop(kPaddingTypeLength, kPaddingUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setPaddingTop(kPaddingTypeLength, kPaddingUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setPaddingTop(kPaddingTypeLength, kPaddingUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setPaddingTop(kPaddingTypeLength, kPaddingUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setPaddingTop(kPaddingTypeLength, kPaddingUnitCH, value.number)
				else                      -> this.setPaddingTop(kPaddingTypeLength, kPaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setPaddingTop
	 * @since 0.7.0
	 */
	public fun setPaddingTop(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setPaddingTop(this.handle, type, unit, length)
	}

	/**
	 * @method setPaddingLeft
	 * @since 0.7.0
	 */
	public fun setPaddingLeft(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setPaddingLeft(kPaddingTypeLength, kPaddingUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setPaddingLeft(kPaddingTypeLength, kPaddingUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setPaddingLeft(kPaddingTypeLength, kPaddingUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setPaddingLeft(kPaddingTypeLength, kPaddingUnitCH, value.number)
				else                      -> this.setPaddingLeft(kPaddingTypeLength, kPaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setPaddingLeft
	 * @since 0.7.0
	 */
	public fun setPaddingLeft(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setPaddingLeft(this.handle, type, unit, length)
	}

	/**
	 * @method setPaddingRight
	 * @since 0.7.0
	 */
	public fun setPaddingRight(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setPaddingRight(kPaddingTypeLength, kPaddingUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setPaddingRight(kPaddingTypeLength, kPaddingUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setPaddingRight(kPaddingTypeLength, kPaddingUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setPaddingRight(kPaddingTypeLength, kPaddingUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setPaddingRight(kPaddingTypeLength, kPaddingUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setPaddingRight(kPaddingTypeLength, kPaddingUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setPaddingRight(kPaddingTypeLength, kPaddingUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setPaddingRight(kPaddingTypeLength, kPaddingUnitCH, value.number)
				else                      -> this.setPaddingRight(kPaddingTypeLength, kPaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setPaddingRight
	 * @since 0.7.0
	 */
	public fun setPaddingRight(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setPaddingRight(this.handle, type, unit, length)
	}

	/**
	 * @method setPaddingBottom
	 * @since 0.7.0
	 */
	public fun setPaddingBottom(value: JavaScriptProperty) {

		if (value.type == JavaScriptPropertyType.NUMBER) {

			when (value.unit) {
				JavaScriptPropertyUnit.PX -> this.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPX, value.number)
				JavaScriptPropertyUnit.PC -> this.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPC, value.number)
				JavaScriptPropertyUnit.VW -> this.setPaddingBottom(kPaddingTypeLength, kPaddingUnitVW, value.number)
				JavaScriptPropertyUnit.VH -> this.setPaddingBottom(kPaddingTypeLength, kPaddingUnitVH, value.number)
				JavaScriptPropertyUnit.PW -> this.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPW, value.number)
				JavaScriptPropertyUnit.PH -> this.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPH, value.number)
				JavaScriptPropertyUnit.CW -> this.setPaddingBottom(kPaddingTypeLength, kPaddingUnitCW, value.number)
				JavaScriptPropertyUnit.CH -> this.setPaddingBottom(kPaddingTypeLength, kPaddingUnitCH, value.number)
				else                      -> this.setPaddingBottom(kPaddingTypeLength, kPaddingUnitPX, value.number)
			}

			return
		}

		throw Exception("Invalid property type.")
	}

	/**
	 * @method setPaddingBottom
	 * @since 0.7.0
	 */
	public fun setPaddingBottom(type: Int, unit: Int, length: Double) {
		DisplayNodeExternal.setPaddingBottom(this.handle, type, unit, length)
	}

	/**
	 * @method setMinPaddingTop
	 * @since 0.7.0
	 */
	public fun setMinPaddingTop(min: Double) {
		DisplayNodeExternal.setMinPaddingTop(this.handle, min)
	}

	/**
	 * @method setMaxPaddingTop
	 * @since 0.7.0
	 */
	public fun setMaxPaddingTop(max: Double) {
		DisplayNodeExternal.setMaxPaddingTop(this.handle, max)
	}

	/**
	 * @method setMinPaddingLeft
	 * @since 0.7.0
	 */
	public fun setMinPaddingLeft(min: Double) {
		DisplayNodeExternal.setMinPaddingLeft(this.handle, min)
	}

	/**
	 * @method setMaxPaddingLeft
	 * @since 0.7.0
	 */
	public fun setMaxPaddingLeft(max: Double) {
		DisplayNodeExternal.setMaxPaddingLeft(this.handle, max)
	}

	/**
	 * @method setMinPaddingRight
	 * @since 0.7.0
	 */
	public fun setMinPaddingRight(min: Double) {
		DisplayNodeExternal.setMinPaddingRight(this.handle, min)
	}

	/**
	 * @method setMaxPaddingRight
	 * @since 0.7.0
	 */
	public fun setMaxPaddingRight(max: Double) {
		DisplayNodeExternal.setMaxPaddingRight(this.handle, max)
	}

	/**
	 * @method setMinPaddingBottom
	 * @since 0.7.0
	 */
	public fun setMinPaddingBottom(min: Double) {
		DisplayNodeExternal.setMinPaddingBottom(this.handle, min)
	}

	/**
	 * @method setMaxPaddingBottom
	 * @since 0.7.0
	 */
	public fun setMaxPaddingBottom(max: Double) {
		DisplayNodeExternal.setMaxPaddingBottom(this.handle, max)
	}

	/**
	 * @method setExpandFactor
	 * @since 0.7.0
	 */
	public fun setExpandFactor(factor: Double) {
		DisplayNodeExternal.setExpandFactor(this.handle, factor)
	}

	/**
	 * @method setShrinkFactor
	 * @since 0.7.0
	 */
	public fun setShrinkFactor(factor: Double) {
		DisplayNodeExternal.setShrinkFactor(this.handle, factor)
	}

	/**
	 * @method setVisible
	 * @since 0.7.0
	 */
	public fun setVisible(value: Boolean) {
		DisplayNodeExternal.setVisible(this.handle, value)
	}

	/**
	 * @method invalidateSize
	 * @since 0.7.0
	 */
	public fun invalidateSize() {
		DisplayNodeExternal.invalidateSize(this.handle)
	}

	/**
	 * @method invalidateOrigin
	 * @since 0.7.0
	 */
	public fun invalidateOrigin() {
		DisplayNodeExternal.invalidateOrigin(this.handle)
	}

	/**
	 * @method invalidateLayout
	 * @since 0.7.0
	 */
	public fun invalidateLayout() {
		DisplayNodeExternal.invalidateLayout(this.handle)
	}

	/**
	 * @method resolve
	 * @since 0.7.0
	 */
	public fun resolve() {
		DisplayNodeExternal.resolve(this.handle)
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	public fun measure() {
		DisplayNodeExternal.measure(this.handle)
	}

	/**
	 * @method appendChild
	 * @since 0.7.0
	 */
	public fun appendChild(node: DisplayNode) {
		DisplayNodeExternal.appendChild(this.handle, node.handle)
	}

	/**
	 * @method insertChild
	 * @since 0.7.0
	 */
	public fun insertChild(node: DisplayNode, at: Int) {
		DisplayNodeExternal.insertChild(this.handle, node.handle, at)
	}

	/**
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
	 * @method onPrepareLayout
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun onPrepareLayout() {
		this.listener?.onPrepareLayout(this)
	}

	/**
	 * @method onResolveLayout
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun onResolveLayout() {
		this.listener?.onResolveLayout(this)
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	@Suppress("unused")
	private fun measure(w: Double, h: Double, minw: Double, maxw: Double, minh: Double, maxh: Double): SizeF {

		return this.listener?.measure(this,
			SizeF(w.toValidFloat(), h.toValidFloat()),
			SizeF(minw.toValidFloat(), minh.toValidFloat()),
			SizeF(maxw.toValidFloat(), maxh.toValidFloat())
		) ?: SizeF(-1f, -1f)

	}

	/**
	 * @method update
	 * @since 0.7.0
	 */
	@Suppress("unused")
	private fun update(name: String, property: Long) {

		val holder = this.listener?.resolve(this, name)
		if (holder == null) {
			return
		}

		if (property == 0L) {
			holder.reset(lock = null, initial = true)
			return
		}

		holder.reset(ValueList(PropertyExternal.getValues(property)), lock = null)
	}
}
