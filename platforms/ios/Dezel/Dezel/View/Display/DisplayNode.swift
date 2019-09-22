import Foundation

/**
 * Manages and resolves the layout and styles of a display object.
 * @class DisplayNode
 * @since 0.7.0
 */
open class DisplayNode {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The display node's delegate.
	 * @property delegate
	 * @since 0.7.0
	 */
	open weak var delegate: DisplayNodeDelegate?

	/**
	 * The display node's display.
	 * @property delegate
	 * @since 0.7.0
	 */
	private(set) public var display: Display

	/**
	 * The display node's id.
	 * @property id
	 * @since 0.7.0
	 */
	public var id: String = "" {
		didSet {
			DisplayNodeSetId(self.handle, self.id)
		}
	}

	/**
	 * The display node's measured top.
	 * @property measuredTop
	 * @since 0.7.0
	 */
	public var measuredTop: Double {
		return DisplayNodeGetMeasuredTop(self.handle)
	}

	/**
	 * The display node's measured left.
	 * @property measuredLeft
	 * @since 0.7.0
	 */
	public var measuredLeft: Double {
		return DisplayNodeGetMeasuredLeft(self.handle)
	}

	/**
	 * The display node's measured right.
	 * @property measuredRight
	 * @since 0.7.0
	 */
	public var measuredRight: Double {
		return DisplayNodeGetMeasuredRight(self.handle)
	}

	/**
	 * The display node's measured bottom.
	 * @property measuredBottom
	 * @since 0.7.0
	 */
	public var measuredBottom: Double {
		return DisplayNodeGetMeasuredBottom(self.handle)
	}

	/**
	 * The display node's measured width.
	 * @property measuredWidth
	 * @since 0.7.0
	 */
	public var measuredWidth: Double {
		return DisplayNodeGetMeasuredWidth(self.handle)
	}

	/**
	 * The display node's measured height.
	 * @property measuredHeight
	 * @since 0.7.0
	 */
	public var measuredHeight: Double {
		return DisplayNodeGetMeasuredHeight(self.handle)
	}

	/**
	 * The display node's measured inner width.
	 * @property measuredInnerWidth
	 * @since 0.7.0
	 */
	public var measuredInnerWidth: Double {
		return DisplayNodeGetMeasuredInnerWidth(self.handle)
	}

	/**
	 * The display node's measured inner height.
	 * @property measuredInnerHeight
	 * @since 0.7.0
	 */
	public var measuredInnerHeight: Double {
		return DisplayNodeGetMeasuredInnerHeight(self.handle)
	}

	/**
	 * The display node's measured content width.
	 * @property measuredContentWidth
	 * @since 0.7.0
	 */
	public var measuredContentWidth: Double {
		return DisplayNodeGetMeasuredContentWidth(self.handle)
	}

	/**
	 * The display node's measured content height.
	 * @property measuredContentHeight
	 * @since 0.7.0
	 */
	public var measuredContentHeight: Double {
		return DisplayNodeGetMeasuredContentHeight(self.handle)
	}

	/**
	 * The display node's measured top margin.
	 * @property measuredMarginTop
	 * @since 0.7.0
	 */
	public var measuredMarginTop: Double {
		return DisplayNodeGetMeasuredMarginTop(self.handle)
	}

	/**
	 * The display node's measured left margin.
	 * @property measuredMarginLeft
	 * @since 0.7.0
	 */
	public var measuredMarginLeft: Double {
		return DisplayNodeGetMeasuredMarginLeft(self.handle)
	}

	/**
	 * The display node's measured right margin.
	 * @property measuredMarginRight
	 * @since 0.7.0
	 */
	public var measuredMarginRight: Double {
		return DisplayNodeGetMeasuredMarginRight(self.handle)
	}

	/**
	 * The display node's measured bottom margin.
	 * @property measuredMarginBottom
	 * @since 0.7.0
	 */
	public var measuredMarginBottom: Double {
		return DisplayNodeGetMeasuredMarginBottom(self.handle)
	}

	/**
	 * The display node's measured top border.
	 * @property measuredBorderTop
	 * @since 0.7.0
	 */
	public var measuredBorderTop: Double {
		return DisplayNodeGetMeasuredBorderTop(self.handle)
	}

	/**
	 * The display node's measured left border.
	 * @property measuredBorderLeft
	 * @since 0.7.0
	 */
	public var measuredBorderLeft: Double {
		return DisplayNodeGetMeasuredBorderLeft(self.handle)
	}

	/**
	 * The display node's measured right border.
	 * @property measuredBorderRight
	 * @since 0.7.0
	 */
	public var measuredBorderRight: Double {
		return DisplayNodeGetMeasuredBorderRight(self.handle)
	}

	/**
	 * The display node's measured bottom border.
	 * @property measuredBorderBottom
	 * @since 0.7.0
	 */
	public var measuredBorderBottom: Double {
		return DisplayNodeGetMeasuredBorderBottom(self.handle)
	}

	/**
	 * The display node's measured top padding.
	 * @property measuredPaddingTop
	 * @since 0.7.0
	 */
	public var measuredPaddingTop: Double {
		return DisplayNodeGetMeasuredPaddingTop(self.handle)
	}

	/**
	 * The display node's measured left padding.
	 * @property measuredPaddingLeft
	 * @since 0.7.0
	 */
	public var measuredPaddingLeft: Double {
		return DisplayNodeGetMeasuredPaddingLeft(self.handle)
	}

	/**
	 * The display node's measured right padding.
	 * @property measuredPaddingRight
	 * @since 0.7.0
	 */
	public var measuredPaddingRight: Double {
		return DisplayNodeGetMeasuredPaddingRight(self.handle)
	}

	/**
	 * The display node's measured bottom padding.
	 * @property measuredPaddingBottom
	 * @since 0.7.0
	 */
	public var measuredPaddingBottom: Double {
		return DisplayNodeGetMeasuredPaddingBottom(self.handle)
	}

	/**
	 * Whether the display node should fill the parent's width.
	 * @property isFillingParentWidth
	 * @since 0.7.0
	 */
	public var isFillingParentWidth: Bool {
		return DisplayNodeIsFillingParentWidth(self.handle)
	}

	/**
	 * Whether the display node should fill the parent's height.
	 * @property fillsParentHeight
	 * @since 0.7.0
	 */
	public var isFillingParentHeight: Bool {
		return DisplayNodeIsFillingParentHeight(self.handle)
	}

	/**
	 * Whether the display node should wraps the content width.
	 * @property isWrappingContentWidth
	 * @since 0.7.0
	 */
	public var isWrappingContentWidth: Bool {
		return DisplayNodeIsWrappingContentWidth(self.handle)
	}

	/**
	 * Whether the display node should wraps the content height.
	 * @property isWrappingContentHeight
	 * @since 0.7.0
	 */
	public var isWrappingContentHeight: Bool {
		return DisplayNodeIsWrappingContentHeight(self.handle)
	}

	/**
	 * @property handle
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) public var handle: DisplayNodeRef!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	internal init(display: Display) {

		self.display = display

		self.handle = DisplayNodeCreate()

		DisplayNodeSetDisplay(self.handle, display.handle)

		DisplayNodeSetInvalidateCallback(self.handle, invalidateCallback)
		DisplayNodeSetMeasureSizeCallback(self.handle, measureSizeCallback)
		DisplayNodeSetResolveSizeCallback(self.handle, resolveSizeCallback)
		DisplayNodeSetResolveOriginCallback(self.handle, resolveOriginCallback)
		DisplayNodeSetResolveInnerSizeCallback(self.handle, resolveInnerSizeCallback)
		DisplayNodeSetResolveContentSizeCallback(self.handle, resolveContentSizeCallback)
		DisplayNodeSetResolveMarginCallback(self.handle, resolveMarginCallback)
		DisplayNodeSetResolveBorderCallback(self.handle, resolveBorderCallback)
		DisplayNodeSetResolvePaddingCallback(self.handle, resolvePaddingCallback)
		DisplayNodeSetLayoutBeganCallback(self.handle, layoutBeganCallback)
		DisplayNodeSetLayoutEndedCallback(self.handle, layoutEndedCallback)

		DisplayNodeSetData(self.handle, UnsafeMutableRawPointer(unretained: self))
	}

	/**
	 * @destructor
	 * @since 0.7.0
	 */
	deinit {
		DisplayNodeDelete(self.handle)
	}

	/**
	 * Assigns the display node's top anchor position.
	 * @method setAnchorTop
	 * @since 0.7.0
	 */
	public func setAnchorTop(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "top":    self.setAnchorTop(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: 0)
				case "center": self.setAnchorTop(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: 50)
				case "bottom": self.setAnchorTop(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: 100)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .pc: self.setAnchorTop(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: value.number)
				default:  self.setAnchorTop(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: value.number * 100)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's top anchor position.
	 * @method setAnchorTop
	 * @since 0.7.0
	 */
	public func setAnchorTop(type: DisplayNodeAnchorType, unit: DisplayNodeAnchorUnit, length: Double) {
		DisplayNodeSetAnchorTop(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's left anchor position.
	 * @method setAnchorLeft
	 * @since 0.7.0
	 */
	public func setAnchorLeft(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "left":   self.setAnchorLeft(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: 0)
				case "center": self.setAnchorLeft(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: 50)
				case "right":  self.setAnchorLeft(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: 100)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .pc: self.setAnchorLeft(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: value.number)
				default:  self.setAnchorLeft(type: kDisplayNodeAnchorTypeLength, unit: kDisplayNodeAnchorUnitPC, length: value.number * 100)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's left anchor position.
	 * @method setAnchorLeft
	 * @since 0.7.0
	 */
	public func setAnchorLeft(type: DisplayNodeAnchorType, unit: DisplayNodeAnchorUnit, length: Double) {
		DisplayNodeSetAnchorLeft(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's top position specification.
	 * @method setTop
	 * @since 0.7.0
	 */
	public func setTop(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setTop(type: kDisplayNodeOriginTypeAuto, unit: kDisplayNodeOriginUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: value.number)
				case .pc: self.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: value.number)
				case .vw: self.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: value.number)
				case .vh: self.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: value.number)
				case .pw: self.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPW, length: value.number)
				case .ph: self.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPH, length: value.number)
				case .cw: self.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCW, length: value.number)
				case .ch: self.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCH, length: value.number)
				default:  self.setTop(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's top position specification.
	 * @method setTop
	 * @since 0.7.0
	 */
	public func setTop(type: DisplayNodeOriginType, unit: DisplayNodeOriginUnit, length: Double) {
		DisplayNodeSetTop(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum top position.
	 * @method setMinTop
	 * @since 0.7.0
	 */
	public func setMinTop(_ min: Double) {
		DisplayNodeSetMinTop(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum top position.
	 * @method setMaxTop
	 * @since 0.7.0
	 */
	public func setMaxTop(_ max: Double) {
		DisplayNodeSetMaxTop(self.handle, max)
	}

	/**
	 * Assigns the display node's left position specification.
	 * @method setLeft
	 * @since 0.7.0
	 */
	public func setLeft(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setLeft(type: kDisplayNodeOriginTypeAuto, unit: kDisplayNodeOriginUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: value.number)
				case .pc: self.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: value.number)
				case .vw: self.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: value.number)
				case .vh: self.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: value.number)
				case .pw: self.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPW, length: value.number)
				case .ph: self.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPH, length: value.number)
				case .cw: self.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCW, length: value.number)
				case .ch: self.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCH, length: value.number)
				default:  self.setLeft(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's left position specification.
	 * @method setLeft
	 * @since 0.7.0
	 */
	public func setLeft(type: DisplayNodeOriginType, unit: DisplayNodeOriginUnit, length: Double) {
		DisplayNodeSetLeft(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum left position.
	 * @method setMinLeft
	 * @since 0.7.0
	 */
	public func setMinLeft(_ min: Double) {
		DisplayNodeSetMinLeft(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum left position.
	 * @method setMaxLeft
	 * @since 0.7.0
	 */
	public func setMaxLeft(_ max: Double) {
		DisplayNodeSetMaxLeft(self.handle, max)
	}

	/**
	 * Assigns the display node's right position specification.
	 * @method setRight
	 * @since 0.7.0
	 */
	public func setRight(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setRight(type: kDisplayNodeOriginTypeAuto, unit: kDisplayNodeOriginUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: value.number)
				case .pc: self.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: value.number)
				case .vw: self.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: value.number)
				case .vh: self.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: value.number)
				case .pw: self.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPW, length: value.number)
				case .ph: self.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPH, length: value.number)
				case .cw: self.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCW, length: value.number)
				case .ch: self.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCH, length: value.number)
				default:  self.setRight(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's right position specification.
	 * @method setRight
	 * @since 0.7.0
	 */
	public func setRight(type: DisplayNodeOriginType, unit: DisplayNodeOriginUnit, length: Double) {
		DisplayNodeSetRight(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum right position.
	 * @method setMinRight
	 * @since 0.7.0
	 */
	public func setMinRight(_ min: Double) {
		DisplayNodeSetMinRight(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum right position.
	 * @method setMaxRight
	 * @since 0.7.0
	 */
	public func setMaxRight(_ max: Double) {
		DisplayNodeSetMaxRight(self.handle, max)
	}

	/**
	 * Assigns the display node's bottom position specification.
	 * @method setBottom
	 * @since 0.7.0
	 */
	public func setBottom(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setBottom(type: kDisplayNodeOriginTypeAuto, unit: kDisplayNodeOriginUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: value.number)
				case .pc: self.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPC, length: value.number)
				case .vw: self.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVW, length: value.number)
				case .vh: self.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitVH, length: value.number)
				case .pw: self.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPW, length: value.number)
				case .ph: self.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPH, length: value.number)
				case .cw: self.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCW, length: value.number)
				case .ch: self.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitCH, length: value.number)
				default:  self.setBottom(type: kDisplayNodeOriginTypeLength, unit: kDisplayNodeOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's bottom position specification.
	 * @method setBottom
	 * @since 0.7.0
	 */
	public func setBottom(type: DisplayNodeOriginType, unit: DisplayNodeOriginUnit, length: Double) {
		DisplayNodeSetBottom(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum bottom position.
	 * @method setMinBottom
	 * @since 0.7.0
	 */
	public func setMinBottom(_ min: Double) {
		DisplayNodeSetMinBottom(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum bottom position.
	 * @method setMaxBottom
	 * @since 0.7.0
	 */
	public func setMaxBottom(_ max: Double) {
		DisplayNodeSetMaxBottom(self.handle, max)
	}

	/**
	 * Assigns the display node's width specification.
	 * @method setWidth
	 * @since 0.7.0
	 */
	public func setWidth(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "fill": self.setWidth(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
				case "wrap": self.setWidth(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: value.number)
				case .pc: self.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: value.number)
				case .vw: self.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVW, length: value.number)
				case .vh: self.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVH, length: value.number)
				case .pw: self.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPW, length: value.number)
				case .ph: self.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPH, length: value.number)
				case .cw: self.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVW, length: value.number)
				case .ch: self.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVH, length: value.number)
				default:  self.setWidth(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's width specification.
	 * @method setWidth
	 * @since 0.7.0
	 */
	public func setWidth(type: DisplayNodeSizeType, unit: DisplayNodeSizeUnit, length: Double) {
		DisplayNodeSetWidth(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum width.
	 * @method setMinWidth
	 * @since 0.7.0
	 */
	public func setMinWidth(_ min: Double) {
		DisplayNodeSetMinWidth(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum width.
	 * @method setMaxWidth
	 * @since 0.7.0
	 */
	public func setMaxWidth(_ max: Double) {
		DisplayNodeSetMaxWidth(self.handle, max)
	}

	/**
	 * Assigns the display node's height specification.
	 * @method setHeight
	 * @since 0.7.0
	 */
	public func setHeight(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "fill": self.setHeight(type: kDisplayNodeSizeTypeFill, unit: kDisplayNodeSizeUnitNone, length: 0)
				case "wrap": self.setHeight(type: kDisplayNodeSizeTypeWrap, unit: kDisplayNodeSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: value.number)
				case .pc: self.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPC, length: value.number)
				case .vw: self.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVW, length: value.number)
				case .vh: self.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVH, length: value.number)
				case .pw: self.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPW, length: value.number)
				case .ph: self.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPH, length: value.number)
				case .cw: self.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVW, length: value.number)
				case .ch: self.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitVH, length: value.number)
				default:  self.setHeight(type: kDisplayNodeSizeTypeLength, unit: kDisplayNodeSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's height specification.
	 * @method setHeight
	 * @since 0.7.0
	 */
	public func setHeight(type: DisplayNodeSizeType, unit: DisplayNodeSizeUnit, length: Double) {
		DisplayNodeSetHeight(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum height.
	 * @method setMinHeight
	 * @since 0.7.0
	 */
	public func setMinHeight(_ min: Double) {
		DisplayNodeSetMinHeight(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum height.
	 * @method setMaxHeight
	 * @since 0.7.0
	 */
	public func setMaxHeight(_ max: Double) {
		DisplayNodeSetMaxHeight(self.handle, max)
	}

	/**
	 * Assigns the display node's content direction specification.
	 * @method setContentDirection
	 * @since 0.7.0
	 */
	public func setContentDirection(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "horizontal": self.setContentDirection(kDisplayNodeContentDirectionHorizontal)
				case "vertical":   self.setContentDirection(kDisplayNodeContentDirectionVertical)
				default: break
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's content direction specification.
	 * @method setContentDirection
	 * @since 0.7.0
	 */
	public func setContentDirection(_ direction: DisplayNodeContentDirection) {
		DisplayNodeSetContentDirection(self.handle, direction)
	}

	/**
	 * Assigns the display node's content alignment specification.
	 * @method setContentAlignment
	 * @since 0.7.0
	 */
	public func setContentAlignment(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "center": self.setContentAlignment(kDisplayNodeContentAlignmentCenter)
				case "start":  self.setContentAlignment(kDisplayNodeContentAlignmentStart)
				case "end":    self.setContentAlignment(kDisplayNodeContentAlignmentEnd)
				default: break
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's content alignment specification.
	 * @method setContentAlignment
	 * @since 0.7.0
	 */
	public func setContentAlignment(_ contentAlignment: DisplayNodeContentAlignment) {
		DisplayNodeSetContentAlignment(self.handle, contentAlignment)
	}

	/**
	 * Assigns the display node's content location specification.
	 * @method setContentLocation
	 * @since 0.7.0
	 */
	public func setContentLocation(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "center":        self.setContentLocation(kDisplayNodeContentLocationCenter)
				case "start":         self.setContentLocation(kDisplayNodeContentLocationStart)
				case "end":           self.setContentLocation(kDisplayNodeContentLocationEnd)
				case "space-around":  self.setContentLocation(kDisplayNodeContentLocationSpaceAround)
				case "space-evenly":  self.setContentLocation(kDisplayNodeContentLocationSpaceEvenly)
				case "space-between": self.setContentLocation(kDisplayNodeContentLocationSpaceBetween)
				default: break
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's content location specification.
	 * @method setContentLocation
	 * @since 0.7.0
	 */
	public func setContentLocation(_ contentLocation: DisplayNodeContentLocation) {
		DisplayNodeSetContentLocation(self.handle, contentLocation)
	}

	/**
	 * Assigns the display node's content top specification.
	 * @method setContentTop
	 * @since 0.7.0
	 */
	public func setContentTop(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setContentTop(type: kDisplayNodeContentOriginTypeLength, unit: kDisplayNodeContentOriginUnitPX, length: value.number)
				default:  self.setContentTop(type: kDisplayNodeContentOriginTypeLength, unit: kDisplayNodeContentOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's content top specification.
	 * @method setContentTop
	 * @since 0.7.0
	 */
	public func setContentTop(type: DisplayNodeContentOriginType, unit: DisplayNodeContentOriginUnit, length: Double) {
		DisplayNodeSetContentTop(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's content left specification.
	 * @method setContentLeft
	 * @since 0.7.0
	 */
	public func setContentLeft(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setContentLeft(type: kDisplayNodeContentOriginTypeLength, unit: kDisplayNodeContentOriginUnitPX, length: value.number)
				default:  self.setContentLeft(type: kDisplayNodeContentOriginTypeLength, unit: kDisplayNodeContentOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's content left specification.
	 * @method setContentLeft
	 * @since 0.7.0
	 */
	public func setContentLeft(type: DisplayNodeContentOriginType, unit: DisplayNodeContentOriginUnit, length: Double) {
		DisplayNodeSetContentLeft(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's content width specification.
	 * @method setContentWidth
	 * @since 0.7.0
	 */
	public func setContentWidth(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setContentWidth(type: kDisplayNodeContentSizeTypeAuto, unit: kDisplayNodeContentSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: value.number)
				case .pc: self.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPC, length: value.number)
				case .vw: self.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitVW, length: value.number)
				case .vh: self.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitVH, length: value.number)
				case .pw: self.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPW, length: value.number)
				case .ph: self.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPH, length: value.number)
				case .cw: self.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitCW, length: value.number)
				case .ch: self.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitCH, length: value.number)
				default:  self.setContentWidth(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's content width specification.
	 * @method setContentWidth
	 * @since 0.7.0
	 */
	public func setContentWidth(type: DisplayNodeContentSizeType, unit: DisplayNodeContentSizeUnit, length: Double) {
		DisplayNodeSetContentWidth(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's content height specification.
	 * @method setContentHeight
	 * @since 0.7.0
	 */
	public func setContentHeight(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setContentHeight(type: kDisplayNodeContentSizeTypeAuto, unit: kDisplayNodeContentSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: value.number)
				case .pc: self.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPC, length: value.number)
				case .vw: self.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitVW, length: value.number)
				case .vh: self.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitVH, length: value.number)
				case .pw: self.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPW, length: value.number)
				case .ph: self.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPH, length: value.number)
				case .cw: self.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitCW, length: value.number)
				case .ch: self.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitCH, length: value.number)
				default:  self.setContentHeight(type: kDisplayNodeContentSizeTypeLength, unit: kDisplayNodeContentSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's content height specification.
	 * @method setContentHeight
	 * @since 0.7.0
	 */
	public func setContentHeight(type: DisplayNodeContentSizeType, unit: DisplayNodeContentSizeUnit, length: Double) {
		DisplayNodeSetContentHeight(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's border top specification.
	 * @method setBorderTop
	 * @since 0.7.0
	 */
	public func setBorderTop(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: value.number)
				case .pc: self.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: value.number)
				case .vw: self.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: value.number)
				case .vh: self.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: value.number)
				case .pw: self.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: value.number)
				case .ph: self.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: value.number)
				case .cw: self.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: value.number)
				case .ch: self.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: value.number)
				default:  self.setBorderTop(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's border top specification.
	 * @method setBorderTop
	 * @since 0.7.0
	 */
	public func setBorderTop(type: DisplayNodeBorderType, unit: DisplayNodeBorderUnit, length: Double) {
		DisplayNodeSetBorderTop(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's border left specification.
	 * @method setBorderLeft
	 * @since 0.7.0
	 */
	public func setBorderLeft(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: value.number)
				case .pc: self.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: value.number)
				case .vw: self.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: value.number)
				case .vh: self.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: value.number)
				case .pw: self.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: value.number)
				case .ph: self.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: value.number)
				case .cw: self.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: value.number)
				case .ch: self.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: value.number)
				default:  self.setBorderLeft(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's border left specification.
	 * @method setBorderLeft
	 * @since 0.7.0
	 */
	public func setBorderLeft(type: DisplayNodeBorderType, unit: DisplayNodeBorderUnit, length: Double) {
		DisplayNodeSetBorderLeft(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's border right specification.
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public func setBorderRight(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: value.number)
				case .pc: self.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: value.number)
				case .vw: self.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: value.number)
				case .vh: self.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: value.number)
				case .pw: self.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: value.number)
				case .ph: self.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: value.number)
				case .cw: self.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: value.number)
				case .ch: self.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: value.number)
				default:  self.setBorderRight(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's border right specification.
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public func setBorderRight(type: DisplayNodeBorderType, unit: DisplayNodeBorderUnit, length: Double) {
		DisplayNodeSetBorderRight(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's border bottom specification.
	 * @method setBorderBottom
	 * @since 0.7.0
	 */
	public func setBorderBottom(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: value.number)
				case .pc: self.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPC, length: value.number)
				case .vw: self.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: value.number)
				case .vh: self.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: value.number)
				case .pw: self.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVW, length: value.number)
				case .ph: self.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitVH, length: value.number)
				case .cw: self.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCW, length: value.number)
				case .ch: self.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitCH, length: value.number)
				default:  self.setBorderBottom(type: kDisplayNodeBorderTypeLength, unit: kDisplayNodeBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's border bottom specification.
	 * @method setBorderBottom
	 * @since 0.7.0
	 */
	public func setBorderBottom(type: DisplayNodeBorderType, unit: DisplayNodeBorderUnit, length: Double) {
		DisplayNodeSetBorderBottom(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's margin top specification.
	 * @method setMarginTop
	 * @since 0.7.0
	 */
	public func setMarginTop(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: value.number)
				case .pc: self.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPC, length: value.number)
				case .vw: self.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: value.number)
				case .vh: self.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: value.number)
				case .pw: self.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPW, length: value.number)
				case .ph: self.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPH, length: value.number)
				case .cw: self.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: value.number)
				case .ch: self.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: value.number)
				default:  self.setMarginTop(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's margin top specification.
	 * @method setMarginTop
	 * @since 0.7.0
	 */
	public func setMarginTop(type: DisplayNodeMarginType, unit: DisplayNodeMarginUnit, length: Double) {
		DisplayNodeSetMarginTop(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's margin left specification.
	 * @method setMarginLeft
	 * @since 0.7.0
	 */
	public func setMarginLeft(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: value.number)
				case .pc: self.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPC, length: value.number)
				case .vw: self.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: value.number)
				case .vh: self.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: value.number)
				case .pw: self.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPW, length: value.number)
				case .ph: self.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPH, length: value.number)
				case .cw: self.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: value.number)
				case .ch: self.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: value.number)
				default:  self.setMarginLeft(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's margin left specification.
	 * @method setMarginLeft
	 * @since 0.7.0
	 */
	public func setMarginLeft(type: DisplayNodeMarginType, unit: DisplayNodeMarginUnit, length: Double) {
		DisplayNodeSetMarginLeft(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's margin right specification.
	 * @method setMarginRight
	 * @since 0.7.0
	 */
	public func setMarginRight(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: value.number)
				case .pc: self.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPC, length: value.number)
				case .vw: self.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: value.number)
				case .vh: self.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: value.number)
				case .pw: self.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPW, length: value.number)
				case .ph: self.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPH, length: value.number)
				case .cw: self.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: value.number)
				case .ch: self.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: value.number)
				default:  self.setMarginRight(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's margin right specification.
	 * @method setMarginRight
	 * @since 0.7.0
	 */
	public func setMarginRight(type: DisplayNodeMarginType, unit: DisplayNodeMarginUnit, length: Double) {
		DisplayNodeSetMarginRight(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's margin bottom specification.
	 * @method setMarginBottom
	 * @since 0.7.0
	 */
	public func setMarginBottom(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: value.number)
				case .pc: self.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPC, length: value.number)
				case .vw: self.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: value.number)
				case .vh: self.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: value.number)
				case .pw: self.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPW, length: value.number)
				case .ph: self.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPH, length: value.number)
				case .cw: self.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVW, length: value.number)
				case .ch: self.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitVH, length: value.number)
				default:  self.setMarginBottom(type: kDisplayNodeMarginTypeLength, unit: kDisplayNodeMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's margin bottom specification.
	 * @method setMarginBottom
	 * @since 0.7.0
	 */
	public func setMarginBottom(type: DisplayNodeMarginType, unit: DisplayNodeMarginUnit, length: Double) {
		DisplayNodeSetMarginBottom(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum top margin.
	 * @method setMinMarginTop
	 * @since 0.7.0
	 */
	public func setMinMarginTop(_ min: Double) {
		DisplayNodeSetMinMarginTop(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum top margin.
	 * @method setMaxMarginTop
	 * @since 0.7.0
	 */
	public func setMaxMarginTop(_ max: Double) {
		DisplayNodeSetMinMarginTop(self.handle, max)
	}

	/**
	 * Assigns the display node's minimum left margin.
	 * @method setMinMarginLeft
	 * @since 0.7.0
	 */
	public func setMinMarginLeft(_ min: Double) {
		DisplayNodeSetMinMarginLeft(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum left margin.
	 * @method setMaxMarginLeft
	 * @since 0.7.0
	 */
	public func setMaxMarginLeft(_ max: Double) {
		DisplayNodeSetMinMarginLeft(self.handle, max)
	}

	/**
	 * Assigns the display node's minimum right margin.
	 * @method setMinMarginRight
	 * @since 0.7.0
	 */
	public func setMinMarginRight(_ min: Double) {
		DisplayNodeSetMinMarginRight(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum right margin.
	 * @method setMaxMarginRight
	 * @since 0.7.0
	 */
	public func setMaxMarginRight(_ max: Double) {
		DisplayNodeSetMaxMarginRight(self.handle, max)
	}

	/**
	 * Assigns the display node's minimum bottom margin.
	 * @method setMinMarginBottom
	 * @since 0.7.0
	 */
	public func setMinMarginBottom(_ min: Double) {
		DisplayNodeSetMinMarginBottom(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum bottom margin.
	 * @method setMaxMarginBottom
	 * @since 0.7.0
	 */
	public func setMaxMarginBottom(_ max: Double) {
		DisplayNodeSetMinMarginBottom(self.handle, max)
	}

	/**
	 * Assigns the display node's padding top specification.
	 * @method setPaddingTop
	 * @since 0.7.0
	 */
	public func setPaddingTop(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: value.number)
				case .pc: self.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: value.number)
				case .vw: self.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: value.number)
				case .vh: self.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: value.number)
				case .pw: self.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: value.number)
				case .ph: self.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: value.number)
				case .cw: self.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: value.number)
				case .ch: self.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: value.number)
				default:  self.setPaddingTop(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's padding top specification.
	 * @method setPaddingTop
	 * @since 0.7.0
	 */
	public func setPaddingTop(type: DisplayNodePaddingType, unit: DisplayNodePaddingUnit, length: Double) {
		DisplayNodeSetPaddingTop(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's padding left specification.
	 * @method setPaddingLeft
	 * @since 0.7.0
	 */
	public func setPaddingLeft(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: value.number)
				case .pc: self.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: value.number)
				case .vw: self.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: value.number)
				case .vh: self.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: value.number)
				case .pw: self.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: value.number)
				case .ph: self.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: value.number)
				case .cw: self.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: value.number)
				case .ch: self.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: value.number)
				default:  self.setPaddingLeft(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's padding left specification.
	 * @method setPaddingLeft
	 * @since 0.7.0
	 */
	public func setPaddingLeft(type: DisplayNodePaddingType, unit: DisplayNodePaddingUnit, length: Double) {
		DisplayNodeSetPaddingLeft(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's padding right specification.
	 * @method setPaddingRight
	 * @since 0.7.0
	 */
	public func setPaddingRight(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: value.number)
				case .pc: self.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: value.number)
				case .vw: self.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: value.number)
				case .vh: self.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: value.number)
				case .pw: self.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: value.number)
				case .ph: self.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: value.number)
				case .cw: self.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: value.number)
				case .ch: self.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: value.number)
				default:  self.setPaddingRight(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's padding right specification.
	 * @method setPaddingRight
	 * @since 0.7.0
	 */
	public func setPaddingRight(type: DisplayNodePaddingType, unit: DisplayNodePaddingUnit, length: Double) {
		DisplayNodeSetPaddingRight(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's padding bottom specification.
	 * @method setPaddingBottom
	 * @since 0.7.0
	 */
	public func setPaddingBottom(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: value.number)
				case .pc: self.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPC, length: value.number)
				case .vw: self.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVW, length: value.number)
				case .vh: self.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitVH, length: value.number)
				case .pw: self.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPW, length: value.number)
				case .ph: self.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPH, length: value.number)
				case .cw: self.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCW, length: value.number)
				case .ch: self.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitCH, length: value.number)
				default:  self.setPaddingBottom(type: kDisplayNodePaddingTypeLength, unit: kDisplayNodePaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * Assigns the display node's padding bottom specification.
	 * @method setPaddingBottom
	 * @since 0.7.0
	 */
	public func setPaddingBottom(type: DisplayNodePaddingType, unit: DisplayNodePaddingUnit, length: Double) {
		DisplayNodeSetPaddingBottom(self.handle, type, unit, length)
	}

	/**
	 * Assigns the display node's minimum top padding.
	 * @method setMinPaddingTop
	 * @since 0.7.0
	 */
	public func setMinPaddingTop(_ min: Double) {
		DisplayNodeSetMinPaddingTop(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum top padding.
	 * @method setMaxPaddingTop
	 * @since 0.7.0
	 */
	public func setMaxPaddingTop(_ max: Double) {
		DisplayNodeSetMaxPaddingTop(self.handle, max)
	}

	/**
	 * Assigns the display node's minimum left padding.
	 * @method setMinPaddingLeft
	 * @since 0.7.0
	 */
	public func setMinPaddingLeft(_ min: Double) {
		DisplayNodeSetMinPaddingLeft(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum left padding.
	 * @method setMaxPaddingLeft
	 * @since 0.7.0
	 */
	public func setMaxPaddingLeft(_ max: Double) {
		DisplayNodeSetMaxPaddingLeft(self.handle, max)
	}

	/**
	 * Assigns the display node's minimum right padding.
	 * @method setMinPaddingRight
	 * @since 0.7.0
	 */
	public func setMinPaddingRight(_ min: Double) {
		DisplayNodeSetMinPaddingRight(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum right padding.
	 * @method setMaxPaddingRight
	 * @since 0.7.0
	 */
	public func setMaxPaddingRight(_ max: Double) {
		DisplayNodeSetMaxPaddingRight(self.handle, max)
	}

	/**
	 * Assigns the display node's minimum bottom padding.
	 * @method setMinPaddingBottom
	 * @since 0.7.0
	 */
	public func setMinPaddingBottom(_ min: Double) {
		DisplayNodeSetMinPaddingBottom(self.handle, min)
	}

	/**
	 * Assigns the display node's maximum bottom padding.
	 * @method setMaxPaddingBottom
	 * @since 0.7.0
	 */
	public func setMaxPaddingBottom(_ max: Double) {
		DisplayNodeSetMaxPaddingBottom(self.handle, max)
	}

	/**
	 * Assigns the factor by which the display node's will expand to fill remaining space.
	 * @method setExpandFactor
	 * @since 0.7.0
	 */
	public func setExpandFactor(_ factor: Double) {
		DisplayNodeSetExpandFactor(self.handle, factor)
	}

	/**
	 * Assigns the factor by which the display node's will shrink to fit available space.
	 * @method setShrinkFactor
	 * @since 0.7.0
	 */
	public func setShrinkFactor(_ factor: Double) {
		DisplayNodeSetShrinkFactor(self.handle, factor)
	}

	/**
	 * Assigns the display node's visibility status.
	 * @method setVisible
	 * @since 0.7.0
	 */
	public func setVisible(_ visible: Bool) {
		DisplayNodeSetVisible(self.handle, visible);
	}

	public func setType(_ type: String) {

	}

	public func appendStyle(_ style: String) {

	}

	public func removeStyle(_ style: String) {

	}

	public func appendState(_ state: String) {

	}

	public func removeState(_ state: String) {

	}

	public func invalidateSize() {
// TODO
	}

	public func invalidateOrigin() {
// TODO
	}

	public func invalidateLayout() {
		// TODO
	}

	/**
	 * Resolves the whole hierarchy.
	 * @method resolve
	 * @since 0.7.0
	 */
	public func resolve() {
		DisplayNodeResolve(self.handle)
	}

	/**
	 * Measures this node.
	 * @method measure
	 * @since 0.7.0
	 */
	public func measure() {
		DisplayNodeMeasure(self.handle)
	}

	/**
	 * Appends a node to the receiver's children list.
	 * @method appendChild
	 * @since 0.7.0
	 */
	public func appendChild(_ node: DisplayNode) {
		DisplayNodeAppendChild(self.handle, node.handle)
	}

	/**
	 * Inserts a node to the receiver's children list.
	 * @method insertChild
	 * @since 0.7.0
	 */
	public func insertChild(_ node: DisplayNode, at: Int) {
		DisplayNodeInsertChild(self.handle, node.handle, Int32(at))
	}

	/**
	 * Removes a node from the receiver's children list.
	 * @method removeChild
	 * @since 0.7.0
	 */
	public func removeChild(_ node: DisplayNode) {
		DisplayNodeRemoveChild(self.handle, node.handle)
	}

	/**
	 * Called when the node needs to be measured manually.
	 * @method measure
	 * @since 0.7.0
	 */
	internal func measure(in rect: CGSize, min: CGSize, max: CGSize) -> CGSize? {
		return self.delegate?.measure(node: self, in: rect, min: min, max: max)
	}

	/**
	 * @method didInvalidate
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didInvalidate() {
		self.delegate?.didInvalidate(node: self)
	}

	/**
	 * @method didResolveSize
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didResolveSize() {
		self.delegate?.didResolveSize(node: self)
	}

	/**
	 * @method didResolveOrigin
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didResolveOrigin() {
		self.delegate?.didResolveOrigin(node: self)
	}

	/**
	 * @method didResolveInnerSize
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didResolveInnerSize() {
		self.delegate?.didResolveInnerSize(node: self)
	}

	/**
	 * @method didResolveContentSize
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didResolveContentSize() {
		self.delegate?.didResolveContentSize(node: self)
	}

	/**
	 * @method didResolveMargin
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didResolveMargin() {
		self.delegate?.didResolveMargin(node: self)
	}

	/**
	 * @method didResolveBorder
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didResolveBorder() {
		self.delegate?.didResolveBorder(node: self)
	}

	/**
	 * @method didResolvePadding
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didResolvePadding() {
		self.delegate?.didResolvePadding(node: self)
	}

	/**
	 * @method layoutBegan
	 * @since 0.7.0
	 * @hidden
	 */
	internal func layoutBegan() {
		self.delegate?.layoutBegan(node: self)
	}

	/**
	 * @method layoutEnded
	 * @since 0.7.0
	 * @hidden
	 */
	internal func layoutEnded() {
		self.delegate?.layoutEnded(node: self)
	}
}

/**
 * @const measureCallback
 * @since 0.7.0
 * @hidden
 */
private let measureSizeCallback: @convention(c) (DisplayNodeRef?, UnsafeMutablePointer<DisplayNodeMeasuredSize>?, Double, Double, Double, Double, Double, Double) -> Void = { (ptr, res, w, h, minw, maxw, minh, maxh) in

	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {

		let min = CGSize(width: minw, height: minh)
		let max = CGSize(width: maxw, height: maxh)
		let bounds = CGSize(width: w, height: h)

		if let size = node.measure(in: bounds, min: min, max: max), let res = res {
			res.pointee.width = Double(size.width)
			res.pointee.height = Double(size.height)
		}
	}
}

/**
 * @const invalidateCallback
 * @since 0.7.0
 * @hidden
 */
private let invalidateCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didInvalidate()
	}
}

/**
 * @const resolveSizeCallback
 * @since 0.7.0
 * @hidden
 */
private let resolveSizeCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveSize()
	}
}

/**
 * @const resolveOriginCallback
 * @since 0.7.0
 * @hidden
 */
private let resolveOriginCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveOrigin()
	}
}

/**
 * @const resolveInnerSizeCallback
 * @since 0.7.0
 * @hidden
 */
private let resolveInnerSizeCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveInnerSize()
	}
}

/**
 * @const resolveContentSizeCallback
 * @since 0.7.0
 * @hidden
 */
private let resolveContentSizeCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveContentSize()
	}
}

/**
 * @const resolveMarginCallback
 * @since 0.7.0
 * @hidden
 */
private let resolveMarginCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveMargin()
	}
}

/**
 * @const resolveBorderCallback
 * @since 0.7.0
 * @hidden
 */
private let resolveBorderCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveBorder()
	}
}

/**
 * @const resolvePaddingCallback
 * @since 0.7.0
 * @hidden
 */
private let resolvePaddingCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolvePadding()
	}
}

/**
 * @const layoutBeganCallback
 * @since 0.7.0
 * @hidden
 */
private let layoutBeganCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.layoutBegan()
	}
}

/**
 * @const layoutEndedCallback
 * @since 0.7.0
 * @hidden
 */
private let layoutEndedCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.layoutEnded()
	}
}
