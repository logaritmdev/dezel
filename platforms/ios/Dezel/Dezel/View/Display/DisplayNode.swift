import Foundation

/**
 * @class DisplayNode
 * @since 0.7.0
 */
open class DisplayNode {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property delegate
	 * @since 0.7.0
	 */
	open weak var delegate: DisplayNodeDelegate?

	/**
	 * @property display
	 * @since 0.7.0
	 */
	private(set) public var display: Display

	/**
	 * @property measuredTop
	 * @since 0.7.0
	 */
	public var measuredTop: Double {
		return DisplayNodeGetMeasuredTop(self.handle)
	}

	/**
	 * @property measuredLeft
	 * @since 0.7.0
	 */
	public var measuredLeft: Double {
		return DisplayNodeGetMeasuredLeft(self.handle)
	}

	/**
	 * @property measuredRight
	 * @since 0.7.0
	 */
	public var measuredRight: Double {
		return DisplayNodeGetMeasuredRight(self.handle)
	}

	/**
	 * @property measuredBottom
	 * @since 0.7.0
	 */
	public var measuredBottom: Double {
		return DisplayNodeGetMeasuredBottom(self.handle)
	}

	/**
	 * @property measuredWidth
	 * @since 0.7.0
	 */
	public var measuredWidth: Double {
		return DisplayNodeGetMeasuredWidth(self.handle)
	}

	/**
	 * @property measuredHeight
	 * @since 0.7.0
	 */
	public var measuredHeight: Double {
		return DisplayNodeGetMeasuredHeight(self.handle)
	}

	/**
	 * @property measuredInnerWidth
	 * @since 0.7.0
	 */
	public var measuredInnerWidth: Double {
		return DisplayNodeGetMeasuredInnerWidth(self.handle)
	}

	/**
	 * @property measuredInnerHeight
	 * @since 0.7.0
	 */
	public var measuredInnerHeight: Double {
		return DisplayNodeGetMeasuredInnerHeight(self.handle)
	}

	/**
	 * @property measuredContentWidth
	 * @since 0.7.0
	 */
	public var measuredContentWidth: Double {
		return DisplayNodeGetMeasuredContentWidth(self.handle)
	}

	/**
	 * @property measuredContentHeight
	 * @since 0.7.0
	 */
	public var measuredContentHeight: Double {
		return DisplayNodeGetMeasuredContentHeight(self.handle)
	}

	/**
	 * @property measuredMarginTop
	 * @since 0.7.0
	 */
	public var measuredMarginTop: Double {
		return DisplayNodeGetMeasuredMarginTop(self.handle)
	}

	/**
	 * @property measuredMarginLeft
	 * @since 0.7.0
	 */
	public var measuredMarginLeft: Double {
		return DisplayNodeGetMeasuredMarginLeft(self.handle)
	}

	/**
	 * @property measuredMarginRight
	 * @since 0.7.0
	 */
	public var measuredMarginRight: Double {
		return DisplayNodeGetMeasuredMarginRight(self.handle)
	}

	/**
	 * @property measuredMarginBottom
	 * @since 0.7.0
	 */
	public var measuredMarginBottom: Double {
		return DisplayNodeGetMeasuredMarginBottom(self.handle)
	}

	/**
	 * @property measuredBorderTop
	 * @since 0.7.0
	 */
	public var measuredBorderTop: Double {
		return DisplayNodeGetMeasuredBorderTop(self.handle)
	}

	/**
	 * @property measuredBorderLeft
	 * @since 0.7.0
	 */
	public var measuredBorderLeft: Double {
		return DisplayNodeGetMeasuredBorderLeft(self.handle)
	}

	/**
	 * @property measuredBorderRight
	 * @since 0.7.0
	 */
	public var measuredBorderRight: Double {
		return DisplayNodeGetMeasuredBorderRight(self.handle)
	}

	/**
	 * @property measuredBorderBottom
	 * @since 0.7.0
	 */
	public var measuredBorderBottom: Double {
		return DisplayNodeGetMeasuredBorderBottom(self.handle)
	}

	/**
	 * @property measuredPaddingTop
	 * @since 0.7.0
	 */
	public var measuredPaddingTop: Double {
		return DisplayNodeGetMeasuredPaddingTop(self.handle)
	}

	/**
	 * @property measuredPaddingLeft
	 * @since 0.7.0
	 */
	public var measuredPaddingLeft: Double {
		return DisplayNodeGetMeasuredPaddingLeft(self.handle)
	}

	/**
	 * @property measuredPaddingRight
	 * @since 0.7.0
	 */
	public var measuredPaddingRight: Double {
		return DisplayNodeGetMeasuredPaddingRight(self.handle)
	}

	/**
	 * @property measuredPaddingBottom
	 * @since 0.7.0
	 */
	public var measuredPaddingBottom: Double {
		return DisplayNodeGetMeasuredPaddingBottom(self.handle)
	}

	/**
	 * @property isFillingParentWidth
	 * @since 0.7.0
	 */
	public var isFillingParentWidth: Bool {
		return DisplayNodeIsFillingParentWidth(self.handle)
	}

	/**
	 * @property fillsParentHeight
	 * @since 0.7.0
	 */
	public var isFillingParentHeight: Bool {
		return DisplayNodeIsFillingParentHeight(self.handle)
	}

	/**
	 * @property isWrappingContentWidth
	 * @since 0.7.0
	 */
	public var isWrappingContentWidth: Bool {
		return DisplayNodeIsWrappingContentWidth(self.handle)
	}

	/**
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

		DisplayNodeSetInvalidateCallback(self.handle, displayNodeInvalidateCallback)
		DisplayNodeSetResolveSizeCallback(self.handle, displayNodeResolveSizeCallback)
		DisplayNodeSetResolveOriginCallback(self.handle, displayNodeResolveOriginCallback)
		DisplayNodeSetResolveInnerSizeCallback(self.handle, displayNodeResolveInnerSizeCallback)
		DisplayNodeSetResolveContentSizeCallback(self.handle, displayNodeResolveContentSizeCallback)
		DisplayNodeSetResolveMarginCallback(self.handle, displayNodeResolveMarginCallback)
		DisplayNodeSetResolveBorderCallback(self.handle, displayNodeResolveBorderCallback)
		DisplayNodeSetResolvePaddingCallback(self.handle, displayNodeResolvePaddingCallback)
		DisplayNodeSetPrepareLayoutCallback(self.handle, displayNodePrepareLayoutCallback)
		DisplayNodeSetResolveLayoutCallback(self.handle, displayNodeResolveLayoutCallback)
		DisplayNodeSetMeasureCallback(self.handle, displayNodeMeasureSizeCallback)
		DisplayNodeSetUpdateCallback(self.handle, displayNodeUpdateCallback);

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
	 * @method setOpaque
	 * @since 0.7.0
	 */
	public func setOpaque() {
		DisplayNodeSetOpaque(self.handle)
	}

	/**
	 * @method setName
	 * @since 0.7.0
	 */
	public func setName(_ name: String) {
		DisplayNodeSetName(self.handle, name)
	}

	/**
	 * @method setType
	 * @since 0.7.0
	 */
	public func setType(_ type: String) {
		DisplayNodeSetType(self.handle, type)
	}

	/**
	 * @method appendStyle
	 * @since 0.7.0
	 */
	public func appendStyle(_ style: String) {
		DisplayNodeAppendStyle(self.handle, style)
	}

	/**
	 * @method removeStyle
	 * @since 0.7.0
	 */
	public func removeStyle(_ style: String) {
		DisplayNodeRemoveStyle(self.handle, style)
	}

	/**
	 * @method hasStyle
	 * @since 0.7.0
	 */
	public func hasStyle(_ style: String) -> Bool {
		return DisplayNodeHasStyle(self.handle, style)
	}

	/**
	 * @method appendState
	 * @since 0.7.0
	 */
	public func appendState(_ state: String) {
		DisplayNodeAppendState(self.handle, state)
	}

	/**
	 * @method removeState
	 * @since 0.7.0
	 */
	public func removeState(_ state: String) {
		DisplayNodeRemoveState(self.handle, state)
	}

	/**
	 * @method hasState
	 * @since 0.7.0
	 */
	public func hasState(_ state: String) -> Bool {
		return DisplayNodeHasState(self.handle, state)
	}

	/**
	 * @method setAnchorTop
	 * @since 0.7.0
	 */
	public func setAnchorTop(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "top":    self.setAnchorTop(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: 0)
				case "center": self.setAnchorTop(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: 50)
				case "bottom": self.setAnchorTop(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: 100)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .pc: self.setAnchorTop(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: value.number)
				default:  self.setAnchorTop(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: value.number * 100)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setAnchorTop
	 * @since 0.7.0
	 */
	public func setAnchorTop(type: AnchorType, unit: AnchorUnit, length: Double) {
		DisplayNodeSetAnchorTop(self.handle, type, unit, length)
	}

	/**
	 * @method setAnchorLeft
	 * @since 0.7.0
	 */
	public func setAnchorLeft(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "left":   self.setAnchorLeft(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: 0)
				case "center": self.setAnchorLeft(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: 50)
				case "right":  self.setAnchorLeft(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: 100)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .pc: self.setAnchorLeft(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: value.number)
				default:  self.setAnchorLeft(type: kAnchorTypeLength, unit: kAnchorUnitPC, length: value.number * 100)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setAnchorLeft
	 * @since 0.7.0
	 */
	public func setAnchorLeft(type: AnchorType, unit: AnchorUnit, length: Double) {
		DisplayNodeSetAnchorLeft(self.handle, type, unit, length)
	}

	/**
	 * @method setTop
	 * @since 0.7.0
	 */
	public func setTop(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setTop(type: kOriginTypeAuto, unit: kOriginUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: value.number)
				case .pc: self.setTop(type: kOriginTypeLength, unit: kOriginUnitPC, length: value.number)
				case .vw: self.setTop(type: kOriginTypeLength, unit: kOriginUnitVW, length: value.number)
				case .vh: self.setTop(type: kOriginTypeLength, unit: kOriginUnitVH, length: value.number)
				case .pw: self.setTop(type: kOriginTypeLength, unit: kOriginUnitPW, length: value.number)
				case .ph: self.setTop(type: kOriginTypeLength, unit: kOriginUnitPH, length: value.number)
				case .cw: self.setTop(type: kOriginTypeLength, unit: kOriginUnitCW, length: value.number)
				case .ch: self.setTop(type: kOriginTypeLength, unit: kOriginUnitCH, length: value.number)
				default:  self.setTop(type: kOriginTypeLength, unit: kOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setTop
	 * @since 0.7.0
	 */
	public func setTop(type: OriginType, unit: OriginUnit, length: Double) {
		DisplayNodeSetTop(self.handle, type, unit, length)
	}

	/**
	 * @method setMinTop
	 * @since 0.7.0
	 */
	public func setMinTop(_ min: Double) {
		DisplayNodeSetMinTop(self.handle, min)
	}

	/**
	 * @method setMaxTop
	 * @since 0.7.0
	 */
	public func setMaxTop(_ max: Double) {
		DisplayNodeSetMaxTop(self.handle, max)
	}

	/**
	 * @method setLeft
	 * @since 0.7.0
	 */
	public func setLeft(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setLeft(type: kOriginTypeAuto, unit: kOriginUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: value.number)
				case .pc: self.setLeft(type: kOriginTypeLength, unit: kOriginUnitPC, length: value.number)
				case .vw: self.setLeft(type: kOriginTypeLength, unit: kOriginUnitVW, length: value.number)
				case .vh: self.setLeft(type: kOriginTypeLength, unit: kOriginUnitVH, length: value.number)
				case .pw: self.setLeft(type: kOriginTypeLength, unit: kOriginUnitPW, length: value.number)
				case .ph: self.setLeft(type: kOriginTypeLength, unit: kOriginUnitPH, length: value.number)
				case .cw: self.setLeft(type: kOriginTypeLength, unit: kOriginUnitCW, length: value.number)
				case .ch: self.setLeft(type: kOriginTypeLength, unit: kOriginUnitCH, length: value.number)
				default:  self.setLeft(type: kOriginTypeLength, unit: kOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setLeft
	 * @since 0.7.0
	 */
	public func setLeft(type: OriginType, unit: OriginUnit, length: Double) {
		DisplayNodeSetLeft(self.handle, type, unit, length)
	}

	/**
	 * @method setMinLeft
	 * @since 0.7.0
	 */
	public func setMinLeft(_ min: Double) {
		DisplayNodeSetMinLeft(self.handle, min)
	}

	/**
	 * @method setMaxLeft
	 * @since 0.7.0
	 */
	public func setMaxLeft(_ max: Double) {
		DisplayNodeSetMaxLeft(self.handle, max)
	}

	/**
	 * @method setRight
	 * @since 0.7.0
	 */
	public func setRight(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setRight(type: kOriginTypeAuto, unit: kOriginUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: value.number)
				case .pc: self.setRight(type: kOriginTypeLength, unit: kOriginUnitPC, length: value.number)
				case .vw: self.setRight(type: kOriginTypeLength, unit: kOriginUnitVW, length: value.number)
				case .vh: self.setRight(type: kOriginTypeLength, unit: kOriginUnitVH, length: value.number)
				case .pw: self.setRight(type: kOriginTypeLength, unit: kOriginUnitPW, length: value.number)
				case .ph: self.setRight(type: kOriginTypeLength, unit: kOriginUnitPH, length: value.number)
				case .cw: self.setRight(type: kOriginTypeLength, unit: kOriginUnitCW, length: value.number)
				case .ch: self.setRight(type: kOriginTypeLength, unit: kOriginUnitCH, length: value.number)
				default:  self.setRight(type: kOriginTypeLength, unit: kOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setRight
	 * @since 0.7.0
	 */
	public func setRight(type: OriginType, unit: OriginUnit, length: Double) {
		DisplayNodeSetRight(self.handle, type, unit, length)
	}

	/**
	 * @method setMinRight
	 * @since 0.7.0
	 */
	public func setMinRight(_ min: Double) {
		DisplayNodeSetMinRight(self.handle, min)
	}

	/**
	 * @method setMaxRight
	 * @since 0.7.0
	 */
	public func setMaxRight(_ max: Double) {
		DisplayNodeSetMaxRight(self.handle, max)
	}

	/**
	 * @method setBottom
	 * @since 0.7.0
	 */
	public func setBottom(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setBottom(type: kOriginTypeAuto, unit: kOriginUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: value.number)
				case .pc: self.setBottom(type: kOriginTypeLength, unit: kOriginUnitPC, length: value.number)
				case .vw: self.setBottom(type: kOriginTypeLength, unit: kOriginUnitVW, length: value.number)
				case .vh: self.setBottom(type: kOriginTypeLength, unit: kOriginUnitVH, length: value.number)
				case .pw: self.setBottom(type: kOriginTypeLength, unit: kOriginUnitPW, length: value.number)
				case .ph: self.setBottom(type: kOriginTypeLength, unit: kOriginUnitPH, length: value.number)
				case .cw: self.setBottom(type: kOriginTypeLength, unit: kOriginUnitCW, length: value.number)
				case .ch: self.setBottom(type: kOriginTypeLength, unit: kOriginUnitCH, length: value.number)
				default:  self.setBottom(type: kOriginTypeLength, unit: kOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setBottom
	 * @since 0.7.0
	 */
	public func setBottom(type: OriginType, unit: OriginUnit, length: Double) {
		DisplayNodeSetBottom(self.handle, type, unit, length)
	}

	/**
	 * @method setMinBottom
	 * @since 0.7.0
	 */
	public func setMinBottom(_ min: Double) {
		DisplayNodeSetMinBottom(self.handle, min)
	}

	/**
	 * @method setMaxBottom
	 * @since 0.7.0
	 */
	public func setMaxBottom(_ max: Double) {
		DisplayNodeSetMaxBottom(self.handle, max)
	}

	/**
	 * @method setWidth
	 * @since 0.7.0
	 */
	public func setWidth(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "fill": self.setWidth(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)
				case "wrap": self.setWidth(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: value.number)
				case .pc: self.setWidth(type: kSizeTypeLength, unit: kSizeUnitPC, length: value.number)
				case .vw: self.setWidth(type: kSizeTypeLength, unit: kSizeUnitVW, length: value.number)
				case .vh: self.setWidth(type: kSizeTypeLength, unit: kSizeUnitVH, length: value.number)
				case .pw: self.setWidth(type: kSizeTypeLength, unit: kSizeUnitPW, length: value.number)
				case .ph: self.setWidth(type: kSizeTypeLength, unit: kSizeUnitPH, length: value.number)
				case .cw: self.setWidth(type: kSizeTypeLength, unit: kSizeUnitVW, length: value.number)
				case .ch: self.setWidth(type: kSizeTypeLength, unit: kSizeUnitVH, length: value.number)
				default:  self.setWidth(type: kSizeTypeLength, unit: kSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setWidth
	 * @since 0.7.0
	 */
	public func setWidth(type: SizeType, unit: SizeUnit, length: Double) {
		DisplayNodeSetWidth(self.handle, type, unit, length)
	}

	/**
	 * @method setMinWidth
	 * @since 0.7.0
	 */
	public func setMinWidth(_ min: Double) {
		DisplayNodeSetMinWidth(self.handle, min)
	}

	/**
	 * @method setMaxWidth
	 * @since 0.7.0
	 */
	public func setMaxWidth(_ max: Double) {
		DisplayNodeSetMaxWidth(self.handle, max)
	}

	/**
	 * @method setHeight
	 * @since 0.7.0
	 */
	public func setHeight(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "fill": self.setHeight(type: kSizeTypeFill, unit: kSizeUnitNone, length: 0)
				case "wrap": self.setHeight(type: kSizeTypeWrap, unit: kSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: value.number)
				case .pc: self.setHeight(type: kSizeTypeLength, unit: kSizeUnitPC, length: value.number)
				case .vw: self.setHeight(type: kSizeTypeLength, unit: kSizeUnitVW, length: value.number)
				case .vh: self.setHeight(type: kSizeTypeLength, unit: kSizeUnitVH, length: value.number)
				case .pw: self.setHeight(type: kSizeTypeLength, unit: kSizeUnitPW, length: value.number)
				case .ph: self.setHeight(type: kSizeTypeLength, unit: kSizeUnitPH, length: value.number)
				case .cw: self.setHeight(type: kSizeTypeLength, unit: kSizeUnitVW, length: value.number)
				case .ch: self.setHeight(type: kSizeTypeLength, unit: kSizeUnitVH, length: value.number)
				default:  self.setHeight(type: kSizeTypeLength, unit: kSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setHeight
	 * @since 0.7.0
	 */
	public func setHeight(type: SizeType, unit: SizeUnit, length: Double) {
		DisplayNodeSetHeight(self.handle, type, unit, length)
	}

	/**
	 * @method setMinHeight
	 * @since 0.7.0
	 */
	public func setMinHeight(_ min: Double) {
		DisplayNodeSetMinHeight(self.handle, min)
	}

	/**
	 * @method setMaxHeight
	 * @since 0.7.0
	 */
	public func setMaxHeight(_ max: Double) {
		DisplayNodeSetMaxHeight(self.handle, max)
	}

	/**
	 * @method setContentDirection
	 * @since 0.7.0
	 */
	public func setContentDirection(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "horizontal": self.setContentDirection(kContentDirectionHorizontal)
				case "vertical":   self.setContentDirection(kContentDirectionVertical)
				default: break
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setContentDirection
	 * @since 0.7.0
	 */
	public func setContentDirection(_ direction: ContentDirection) {
		DisplayNodeSetContentDirection(self.handle, direction)
	}

	/**
	 * @method setContentAlignment
	 * @since 0.7.0
	 */
	public func setContentAlignment(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "center": self.setContentAlignment(kContentAlignmentCenter)
				case "start":  self.setContentAlignment(kContentAlignmentStart)
				case "end":    self.setContentAlignment(kContentAlignmentEnd)
				default: break
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setContentAlignment
	 * @since 0.7.0
	 */
	public func setContentAlignment(_ contentAlignment: ContentAlignment) {
		DisplayNodeSetContentAlignment(self.handle, contentAlignment)
	}

	/**
	 * @method setContentDisposition
	 * @since 0.7.0
	 */
	public func setContentDisposition(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "center":        self.setContentDisposition(kContentDispositionCenter)
				case "start":         self.setContentDisposition(kContentDispositionStart)
				case "end":           self.setContentDisposition(kContentDispositionEnd)
				case "space-around":  self.setContentDisposition(kContentDispositionSpaceAround)
				case "space-evenly":  self.setContentDisposition(kContentDispositionSpaceEvenly)
				case "space-between": self.setContentDisposition(kContentDispositionSpaceBetween)
				default: break
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setContentDisposition
	 * @since 0.7.0
	 */
	public func setContentDisposition(_ contentDisposition: ContentDisposition) {
		DisplayNodeSetContentDisposition(self.handle, contentDisposition)
	}

	/**
	 * @method setContentTop
	 * @since 0.7.0
	 */
	public func setContentTop(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setContentTop(type: kContentOriginTypeLength, unit: kContentOriginUnitPX, length: value.number)
				default:  self.setContentTop(type: kContentOriginTypeLength, unit: kContentOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setContentTop
	 * @since 0.7.0
	 */
	public func setContentTop(type: ContentOriginType, unit: ContentOriginUnit, length: Double) {
		DisplayNodeSetContentTop(self.handle, type, unit, length)
	}

	/**
	 * @method setContentLeft
	 * @since 0.7.0
	 */
	public func setContentLeft(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setContentLeft(type: kContentOriginTypeLength, unit: kContentOriginUnitPX, length: value.number)
				default:  self.setContentLeft(type: kContentOriginTypeLength, unit: kContentOriginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setContentLeft
	 * @since 0.7.0
	 */
	public func setContentLeft(type: ContentOriginType, unit: ContentOriginUnit, length: Double) {
		DisplayNodeSetContentLeft(self.handle, type, unit, length)
	}

	/**
	 * @method setContentWidth
	 * @since 0.7.0
	 */
	public func setContentWidth(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setContentWidth(type: kContentSizeTypeAuto, unit: kContentSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: value.number)
				case .pc: self.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPC, length: value.number)
				case .vw: self.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitVW, length: value.number)
				case .vh: self.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitVH, length: value.number)
				case .pw: self.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPW, length: value.number)
				case .ph: self.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPH, length: value.number)
				case .cw: self.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitCW, length: value.number)
				case .ch: self.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitCH, length: value.number)
				default:  self.setContentWidth(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setContentWidth
	 * @since 0.7.0
	 */
	public func setContentWidth(type: ContentSizeType, unit: ContentSizeUnit, length: Double) {
		DisplayNodeSetContentWidth(self.handle, type, unit, length)
	}

	/**
	 * @method setContentHeight
	 * @since 0.7.0
	 */
	public func setContentHeight(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.setContentHeight(type: kContentSizeTypeAuto, unit: kContentSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: value.number)
				case .pc: self.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPC, length: value.number)
				case .vw: self.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitVW, length: value.number)
				case .vh: self.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitVH, length: value.number)
				case .pw: self.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPW, length: value.number)
				case .ph: self.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPH, length: value.number)
				case .cw: self.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitCW, length: value.number)
				case .ch: self.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitCH, length: value.number)
				default:  self.setContentHeight(type: kContentSizeTypeLength, unit: kContentSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setContentHeight
	 * @since 0.7.0
	 */
	public func setContentHeight(type: ContentSizeType, unit: ContentSizeUnit, length: Double) {
		DisplayNodeSetContentHeight(self.handle, type, unit, length)
	}

	/**
	 * @method setBorderTop
	 * @since 0.7.0
	 */
	public func setBorderTop(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPX, length: value.number)
				case .pc: self.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPC, length: value.number)
				case .vw: self.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitVW, length: value.number)
				case .vh: self.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitVH, length: value.number)
				case .pw: self.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitVW, length: value.number)
				case .ph: self.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitVH, length: value.number)
				case .cw: self.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitCW, length: value.number)
				case .ch: self.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitCH, length: value.number)
				default:  self.setBorderTop(type: kBorderTypeLength, unit: kBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setBorderTop
	 * @since 0.7.0
	 */
	public func setBorderTop(type: BorderType, unit: BorderUnit, length: Double) {
		DisplayNodeSetBorderTop(self.handle, type, unit, length)
	}

	/**
	 * @method setBorderLeft
	 * @since 0.7.0
	 */
	public func setBorderLeft(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPX, length: value.number)
				case .pc: self.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPC, length: value.number)
				case .vw: self.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitVW, length: value.number)
				case .vh: self.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitVH, length: value.number)
				case .pw: self.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitVW, length: value.number)
				case .ph: self.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitVH, length: value.number)
				case .cw: self.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitCW, length: value.number)
				case .ch: self.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitCH, length: value.number)
				default:  self.setBorderLeft(type: kBorderTypeLength, unit: kBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setBorderLeft
	 * @since 0.7.0
	 */
	public func setBorderLeft(type: BorderType, unit: BorderUnit, length: Double) {
		DisplayNodeSetBorderLeft(self.handle, type, unit, length)
	}

	/**
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public func setBorderRight(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPX, length: value.number)
				case .pc: self.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPC, length: value.number)
				case .vw: self.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitVW, length: value.number)
				case .vh: self.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitVH, length: value.number)
				case .pw: self.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitVW, length: value.number)
				case .ph: self.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitVH, length: value.number)
				case .cw: self.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitCW, length: value.number)
				case .ch: self.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitCH, length: value.number)
				default:  self.setBorderRight(type: kBorderTypeLength, unit: kBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public func setBorderRight(type: BorderType, unit: BorderUnit, length: Double) {
		DisplayNodeSetBorderRight(self.handle, type, unit, length)
	}

	/**
	 * @method setBorderBottom
	 * @since 0.7.0
	 */
	public func setBorderBottom(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPX, length: value.number)
				case .pc: self.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPC, length: value.number)
				case .vw: self.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitVW, length: value.number)
				case .vh: self.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitVH, length: value.number)
				case .pw: self.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitVW, length: value.number)
				case .ph: self.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitVH, length: value.number)
				case .cw: self.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitCW, length: value.number)
				case .ch: self.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitCH, length: value.number)
				default:  self.setBorderBottom(type: kBorderTypeLength, unit: kBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setBorderBottom
	 * @since 0.7.0
	 */
	public func setBorderBottom(type: BorderType, unit: BorderUnit, length: Double) {
		DisplayNodeSetBorderBottom(self.handle, type, unit, length)
	}

	/**
	 * @method setMarginTop
	 * @since 0.7.0
	 */
	public func setMarginTop(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPX, length: value.number)
				case .pc: self.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPC, length: value.number)
				case .vw: self.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitVW, length: value.number)
				case .vh: self.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitVH, length: value.number)
				case .pw: self.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPW, length: value.number)
				case .ph: self.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPH, length: value.number)
				case .cw: self.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitVW, length: value.number)
				case .ch: self.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitVH, length: value.number)
				default:  self.setMarginTop(type: kMarginTypeLength, unit: kMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setMarginTop
	 * @since 0.7.0
	 */
	public func setMarginTop(type: MarginType, unit: MarginUnit, length: Double) {
		DisplayNodeSetMarginTop(self.handle, type, unit, length)
	}

	/**
	 * @method setMarginLeft
	 * @since 0.7.0
	 */
	public func setMarginLeft(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPX, length: value.number)
				case .pc: self.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPC, length: value.number)
				case .vw: self.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitVW, length: value.number)
				case .vh: self.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitVH, length: value.number)
				case .pw: self.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPW, length: value.number)
				case .ph: self.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPH, length: value.number)
				case .cw: self.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitVW, length: value.number)
				case .ch: self.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitVH, length: value.number)
				default:  self.setMarginLeft(type: kMarginTypeLength, unit: kMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setMarginLeft
	 * @since 0.7.0
	 */
	public func setMarginLeft(type: MarginType, unit: MarginUnit, length: Double) {
		DisplayNodeSetMarginLeft(self.handle, type, unit, length)
	}

	/**
	 * @method setMarginRight
	 * @since 0.7.0
	 */
	public func setMarginRight(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPX, length: value.number)
				case .pc: self.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPC, length: value.number)
				case .vw: self.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitVW, length: value.number)
				case .vh: self.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitVH, length: value.number)
				case .pw: self.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPW, length: value.number)
				case .ph: self.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPH, length: value.number)
				case .cw: self.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitVW, length: value.number)
				case .ch: self.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitVH, length: value.number)
				default:  self.setMarginRight(type: kMarginTypeLength, unit: kMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setMarginRight
	 * @since 0.7.0
	 */
	public func setMarginRight(type: MarginType, unit: MarginUnit, length: Double) {
		DisplayNodeSetMarginRight(self.handle, type, unit, length)
	}

	/**
	 * @method setMarginBottom
	 * @since 0.7.0
	 */
	public func setMarginBottom(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPX, length: value.number)
				case .pc: self.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPC, length: value.number)
				case .vw: self.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitVW, length: value.number)
				case .vh: self.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitVH, length: value.number)
				case .pw: self.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPW, length: value.number)
				case .ph: self.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPH, length: value.number)
				case .cw: self.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitVW, length: value.number)
				case .ch: self.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitVH, length: value.number)
				default:  self.setMarginBottom(type: kMarginTypeLength, unit: kMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setMarginBottom
	 * @since 0.7.0
	 */
	public func setMarginBottom(type: MarginType, unit: MarginUnit, length: Double) {
		DisplayNodeSetMarginBottom(self.handle, type, unit, length)
	}

	/**
	 * @method setMinMarginTop
	 * @since 0.7.0
	 */
	public func setMinMarginTop(_ min: Double) {
		DisplayNodeSetMinMarginTop(self.handle, min)
	}

	/**
	 * @method setMaxMarginTop
	 * @since 0.7.0
	 */
	public func setMaxMarginTop(_ max: Double) {
		DisplayNodeSetMinMarginTop(self.handle, max)
	}

	/**
	 * @method setMinMarginLeft
	 * @since 0.7.0
	 */
	public func setMinMarginLeft(_ min: Double) {
		DisplayNodeSetMinMarginLeft(self.handle, min)
	}

	/**
	 * @method setMaxMarginLeft
	 * @since 0.7.0
	 */
	public func setMaxMarginLeft(_ max: Double) {
		DisplayNodeSetMinMarginLeft(self.handle, max)
	}

	/**
	 * @method setMinMarginRight
	 * @since 0.7.0
	 */
	public func setMinMarginRight(_ min: Double) {
		DisplayNodeSetMinMarginRight(self.handle, min)
	}

	/**
	 * @method setMaxMarginRight
	 * @since 0.7.0
	 */
	public func setMaxMarginRight(_ max: Double) {
		DisplayNodeSetMaxMarginRight(self.handle, max)
	}

	/**
	 * @method setMinMarginBottom
	 * @since 0.7.0
	 */
	public func setMinMarginBottom(_ min: Double) {
		DisplayNodeSetMinMarginBottom(self.handle, min)
	}

	/**
	 * @method setMaxMarginBottom
	 * @since 0.7.0
	 */
	public func setMaxMarginBottom(_ max: Double) {
		DisplayNodeSetMinMarginBottom(self.handle, max)
	}

	/**
	 * @method setPaddingTop
	 * @since 0.7.0
	 */
	public func setPaddingTop(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: value.number)
				case .pc: self.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: value.number)
				case .vw: self.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: value.number)
				case .vh: self.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: value.number)
				case .pw: self.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: value.number)
				case .ph: self.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: value.number)
				case .cw: self.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: value.number)
				case .ch: self.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: value.number)
				default:  self.setPaddingTop(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setPaddingTop
	 * @since 0.7.0
	 */
	public func setPaddingTop(type: PaddingType, unit: PaddingUnit, length: Double) {
		DisplayNodeSetPaddingTop(self.handle, type, unit, length)
	}

	/**
	 * @method setPaddingLeft
	 * @since 0.7.0
	 */
	public func setPaddingLeft(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: value.number)
				case .pc: self.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: value.number)
				case .vw: self.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: value.number)
				case .vh: self.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: value.number)
				case .pw: self.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: value.number)
				case .ph: self.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: value.number)
				case .cw: self.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: value.number)
				case .ch: self.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: value.number)
				default:  self.setPaddingLeft(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setPaddingLeft
	 * @since 0.7.0
	 */
	public func setPaddingLeft(type: PaddingType, unit: PaddingUnit, length: Double) {
		DisplayNodeSetPaddingLeft(self.handle, type, unit, length)
	}

	/**
	 * @method setPaddingRight
	 * @since 0.7.0
	 */
	public func setPaddingRight(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: value.number)
				case .pc: self.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: value.number)
				case .vw: self.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: value.number)
				case .vh: self.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: value.number)
				case .pw: self.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: value.number)
				case .ph: self.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: value.number)
				case .cw: self.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: value.number)
				case .ch: self.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: value.number)
				default:  self.setPaddingRight(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setPaddingRight
	 * @since 0.7.0
	 */
	public func setPaddingRight(type: PaddingType, unit: PaddingUnit, length: Double) {
		DisplayNodeSetPaddingRight(self.handle, type, unit, length)
	}

	/**
	 * @method setPaddingBottom
	 * @since 0.7.0
	 */
	public func setPaddingBottom(_ value: JavaScriptProperty) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: value.number)
				case .pc: self.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPC, length: value.number)
				case .vw: self.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitVW, length: value.number)
				case .vh: self.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitVH, length: value.number)
				case .pw: self.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPW, length: value.number)
				case .ph: self.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPH, length: value.number)
				case .cw: self.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitCW, length: value.number)
				case .ch: self.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitCH, length: value.number)
				default:  self.setPaddingBottom(type: kPaddingTypeLength, unit: kPaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method setPaddingBottom
	 * @since 0.7.0
	 */
	public func setPaddingBottom(type: PaddingType, unit: PaddingUnit, length: Double) {
		DisplayNodeSetPaddingBottom(self.handle, type, unit, length)
	}

	/**
	 * @method setMinPaddingTop
	 * @since 0.7.0
	 */
	public func setMinPaddingTop(_ min: Double) {
		DisplayNodeSetMinPaddingTop(self.handle, min)
	}

	/**
	 * @method setMaxPaddingTop
	 * @since 0.7.0
	 */
	public func setMaxPaddingTop(_ max: Double) {
		DisplayNodeSetMaxPaddingTop(self.handle, max)
	}

	/**
	 * @method setMinPaddingLeft
	 * @since 0.7.0
	 */
	public func setMinPaddingLeft(_ min: Double) {
		DisplayNodeSetMinPaddingLeft(self.handle, min)
	}

	/**
	 * @method setMaxPaddingLeft
	 * @since 0.7.0
	 */
	public func setMaxPaddingLeft(_ max: Double) {
		DisplayNodeSetMaxPaddingLeft(self.handle, max)
	}

	/**
	 * @method setMinPaddingRight
	 * @since 0.7.0
	 */
	public func setMinPaddingRight(_ min: Double) {
		DisplayNodeSetMinPaddingRight(self.handle, min)
	}

	/**
	 * @method setMaxPaddingRight
	 * @since 0.7.0
	 */
	public func setMaxPaddingRight(_ max: Double) {
		DisplayNodeSetMaxPaddingRight(self.handle, max)
	}

	/**
	 * @method setMinPaddingBottom
	 * @since 0.7.0
	 */
	public func setMinPaddingBottom(_ min: Double) {
		DisplayNodeSetMinPaddingBottom(self.handle, min)
	}

	/**
	 * @method setMaxPaddingBottom
	 * @since 0.7.0
	 */
	public func setMaxPaddingBottom(_ max: Double) {
		DisplayNodeSetMaxPaddingBottom(self.handle, max)
	}

	/**
	 * @method setExpandFactor
	 * @since 0.7.0
	 */
	public func setExpandFactor(_ factor: Double) {
		DisplayNodeSetExpandFactor(self.handle, factor)
	}

	/**
	 * @method setShrinkFactor
	 * @since 0.7.0
	 */
	public func setShrinkFactor(_ factor: Double) {
		DisplayNodeSetShrinkFactor(self.handle, factor)
	}

	/**
	 * @method setVisible
	 * @since 0.7.0
	 */
	public func setVisible(_ visible: Bool) {
		DisplayNodeSetVisible(self.handle, visible);
	}

	/**
	 * @method invalidateSize
	 * @since 0.7.0
	 */
	public func invalidateSize() {
		DisplayNodeInvalidateSize(self.handle)
	}

	/**
	 * @method invalidateOrigin
	 * @since 0.7.0
	 */
	public func invalidateOrigin() {
		DisplayNodeInvalidateOrigin(self.handle)
	}

	/**
	 * @method invalidateLayout
	 * @since 0.7.0
	 */
	public func invalidateLayout() {
		DisplayNodeInvalidateLayout(self.handle)
	}

	/**
	 * @method appendChild
	 * @since 0.7.0
	 */
	public func appendChild(_ node: DisplayNode) {
		DisplayNodeAppendChild(self.handle, node.handle)
	}

	/**
	 * @method insertChild
	 * @since 0.7.0
	 */
	public func insertChild(_ node: DisplayNode, at: Int) {
		DisplayNodeInsertChild(self.handle, node.handle, Int32(at))
	}

	/**
	 * @method removeChild
	 * @since 0.7.0
	 */
	public func removeChild(_ node: DisplayNode) {
		DisplayNodeRemoveChild(self.handle, node.handle)
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	public func measure() {
		DisplayNodeMeasure(self.handle)
	}

	/**
	 * @method resolve
	 * @since 0.7.0
	 */
	public func resolve() {
		DisplayNodeResolve(self.handle)
	}

	//--------------------------------------------------------------------------
	// MARK: Internal API
	//--------------------------------------------------------------------------

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
	 * @method didPrepareLayout
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didPrepareLayout() {
		self.delegate?.didPrepareLayout(node: self)
	}

	/**
	 * @method didResolveLayout
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didResolveLayout() {
		self.delegate?.didResolveLayout(node: self)
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	internal func measure(in rect: CGSize, min: CGSize, max: CGSize) -> CGSize? {
		return self.delegate?.measure(node: self, bounds: rect, min: min, max: max)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 */
	internal func update(name: String, property: PropertyRef?) {
		if let prop = self.delegate?.resolve(node: self, property: name)  {
			if (property == nil) {
				prop.reset(lock: nil, initial: true)
			} else {
				prop.reset(PropertyGetValues(property))
			}
 		}
	}
}

/**
 * @const displayNodeInvalidateCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeInvalidateCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didInvalidate()
	}
}

/**
 * @const displayNodeResolveSizeCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeResolveSizeCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveSize()
	}
}

/**
 * @const displayNodeResolveOriginCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeResolveOriginCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveOrigin()
	}
}

/**
 * @const displayNodeResolveInnerSizeCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeResolveInnerSizeCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveInnerSize()
	}
}

/**
 * @const displayNodeResolveContentSizeCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeResolveContentSizeCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveContentSize()
	}
}

/**
 * @const displayNodeResolveMarginCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeResolveMarginCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveMargin()
	}
}

/**
 * @const displayNodeResolveBorderCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeResolveBorderCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveBorder()
	}
}

/**
 * @const displayNodeResolvePaddingCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeResolvePaddingCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolvePadding()
	}
}

/**
 * @const displayNodePrepareLayoutCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodePrepareLayoutCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didPrepareLayout()
	}
}

/**
 * @const displayNodeResolveLayoutCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeResolveLayoutCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.didResolveLayout()
	}
}

/**
 * @const displayNodeMeasureSizeCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeMeasureSizeCallback: @convention(c) (DisplayNodeRef?, UnsafeMutablePointer<MeasuredSize>?, Double, Double, Double, Double, Double, Double) -> Void = { (ptr, res, w, h, minw, maxw, minh, maxh) in

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
 * @const PropertySetterCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeUpdateCallback: @convention(c) (DisplayNodeRef?, PropertyRef?, UnsafePointer<Int8>?) -> Void = { ptr, property, name in
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.update(name: name!.string, property: property)
	}
}
