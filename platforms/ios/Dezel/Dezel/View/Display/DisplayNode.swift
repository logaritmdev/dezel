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

		DisplayNodeSetResolveSizeCallback(self.handle, displayNodeResolveSizeCallback)
		DisplayNodeSetResolveOriginCallback(self.handle, displayNodeResolveOriginCallback)
		DisplayNodeSetResolveInnerSizeCallback(self.handle, displayNodeResolveInnerSizeCallback)
		DisplayNodeSetResolveContentSizeCallback(self.handle, displayNodeResolveContentSizeCallback)
		DisplayNodeSetResolveMarginCallback(self.handle, displayNodeResolveMarginCallback)
		DisplayNodeSetResolveBorderCallback(self.handle, displayNodeResolveBorderCallback)
		DisplayNodeSetResolvePaddingCallback(self.handle, displayNodeResolvePaddingCallback)
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
	 * @method setAnchorTop
	 * @since 0.7.0
	 */
	public func setAnchorTop(type: DisplayNodeAnchorType, unit: DisplayNodeAnchorUnit, length: Double) {
		DisplayNodeSetAnchorTop(self.handle, type, unit, length)
	}

	/**
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
	 * @method setAnchorLeft
	 * @since 0.7.0
	 */
	public func setAnchorLeft(type: DisplayNodeAnchorType, unit: DisplayNodeAnchorUnit, length: Double) {
		DisplayNodeSetAnchorLeft(self.handle, type, unit, length)
	}

	/**
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
	 * @method setTop
	 * @since 0.7.0
	 */
	public func setTop(type: DisplayNodeOriginType, unit: DisplayNodeOriginUnit, length: Double) {
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
	 * @method setLeft
	 * @since 0.7.0
	 */
	public func setLeft(type: DisplayNodeOriginType, unit: DisplayNodeOriginUnit, length: Double) {
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
	 * @method setRight
	 * @since 0.7.0
	 */
	public func setRight(type: DisplayNodeOriginType, unit: DisplayNodeOriginUnit, length: Double) {
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
	 * @method setBottom
	 * @since 0.7.0
	 */
	public func setBottom(type: DisplayNodeOriginType, unit: DisplayNodeOriginUnit, length: Double) {
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
	 * @method setWidth
	 * @since 0.7.0
	 */
	public func setWidth(type: DisplayNodeSizeType, unit: DisplayNodeSizeUnit, length: Double) {
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
	 * @method setHeight
	 * @since 0.7.0
	 */
	public func setHeight(type: DisplayNodeSizeType, unit: DisplayNodeSizeUnit, length: Double) {
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
				case "horizontal": self.setContentDirection(kDisplayNodeContentDirectionHorizontal)
				case "vertical":   self.setContentDirection(kDisplayNodeContentDirectionVertical)
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
	public func setContentDirection(_ direction: DisplayNodeContentDirection) {
		DisplayNodeSetContentDirection(self.handle, direction)
	}

	/**
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
	 * @method setContentAlignment
	 * @since 0.7.0
	 */
	public func setContentAlignment(_ contentAlignment: DisplayNodeContentAlignment) {
		DisplayNodeSetContentAlignment(self.handle, contentAlignment)
	}

	/**
	 * @method setContentDisposition
	 * @since 0.7.0
	 */
	public func setContentDisposition(_ value: JavaScriptProperty) {

		if (value.type == .string) {

			switch (value.string) {
				case "center":        self.setContentDisposition(kDisplayNodeContentDispositionCenter)
				case "start":         self.setContentDisposition(kDisplayNodeContentDispositionStart)
				case "end":           self.setContentDisposition(kDisplayNodeContentDispositionEnd)
				case "space-around":  self.setContentDisposition(kDisplayNodeContentDispositionSpaceAround)
				case "space-evenly":  self.setContentDisposition(kDisplayNodeContentDispositionSpaceEvenly)
				case "space-between": self.setContentDisposition(kDisplayNodeContentDispositionSpaceBetween)
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
	public func setContentDisposition(_ contentDisposition: DisplayNodeContentDisposition) {
		DisplayNodeSetContentDisposition(self.handle, contentDisposition)
	}

	/**
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
	 * @method setContentTop
	 * @since 0.7.0
	 */
	public func setContentTop(type: DisplayNodeContentOriginType, unit: DisplayNodeContentOriginUnit, length: Double) {
		DisplayNodeSetContentTop(self.handle, type, unit, length)
	}

	/**
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
	 * @method setContentLeft
	 * @since 0.7.0
	 */
	public func setContentLeft(type: DisplayNodeContentOriginType, unit: DisplayNodeContentOriginUnit, length: Double) {
		DisplayNodeSetContentLeft(self.handle, type, unit, length)
	}

	/**
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
	 * @method setContentWidth
	 * @since 0.7.0
	 */
	public func setContentWidth(type: DisplayNodeContentSizeType, unit: DisplayNodeContentSizeUnit, length: Double) {
		DisplayNodeSetContentWidth(self.handle, type, unit, length)
	}

	/**
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
	 * @method setContentHeight
	 * @since 0.7.0
	 */
	public func setContentHeight(type: DisplayNodeContentSizeType, unit: DisplayNodeContentSizeUnit, length: Double) {
		DisplayNodeSetContentHeight(self.handle, type, unit, length)
	}

	/**
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
	 * @method setBorderTop
	 * @since 0.7.0
	 */
	public func setBorderTop(type: DisplayNodeBorderType, unit: DisplayNodeBorderUnit, length: Double) {
		DisplayNodeSetBorderTop(self.handle, type, unit, length)
	}

	/**
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
	 * @method setBorderLeft
	 * @since 0.7.0
	 */
	public func setBorderLeft(type: DisplayNodeBorderType, unit: DisplayNodeBorderUnit, length: Double) {
		DisplayNodeSetBorderLeft(self.handle, type, unit, length)
	}

	/**
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
	 * @method setBorderRight
	 * @since 0.7.0
	 */
	public func setBorderRight(type: DisplayNodeBorderType, unit: DisplayNodeBorderUnit, length: Double) {
		DisplayNodeSetBorderRight(self.handle, type, unit, length)
	}

	/**
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
	 * @method setBorderBottom
	 * @since 0.7.0
	 */
	public func setBorderBottom(type: DisplayNodeBorderType, unit: DisplayNodeBorderUnit, length: Double) {
		DisplayNodeSetBorderBottom(self.handle, type, unit, length)
	}

	/**
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
	 * @method setMarginTop
	 * @since 0.7.0
	 */
	public func setMarginTop(type: DisplayNodeMarginType, unit: DisplayNodeMarginUnit, length: Double) {
		DisplayNodeSetMarginTop(self.handle, type, unit, length)
	}

	/**
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
	 * @method setMarginLeft
	 * @since 0.7.0
	 */
	public func setMarginLeft(type: DisplayNodeMarginType, unit: DisplayNodeMarginUnit, length: Double) {
		DisplayNodeSetMarginLeft(self.handle, type, unit, length)
	}

	/**
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
	 * @method setMarginRight
	 * @since 0.7.0
	 */
	public func setMarginRight(type: DisplayNodeMarginType, unit: DisplayNodeMarginUnit, length: Double) {
		DisplayNodeSetMarginRight(self.handle, type, unit, length)
	}

	/**
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
	 * @method setMarginBottom
	 * @since 0.7.0
	 */
	public func setMarginBottom(type: DisplayNodeMarginType, unit: DisplayNodeMarginUnit, length: Double) {
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
	 * @method setPaddingTop
	 * @since 0.7.0
	 */
	public func setPaddingTop(type: DisplayNodePaddingType, unit: DisplayNodePaddingUnit, length: Double) {
		DisplayNodeSetPaddingTop(self.handle, type, unit, length)
	}

	/**
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
	 * @method setPaddingLeft
	 * @since 0.7.0
	 */
	public func setPaddingLeft(type: DisplayNodePaddingType, unit: DisplayNodePaddingUnit, length: Double) {
		DisplayNodeSetPaddingLeft(self.handle, type, unit, length)
	}

	/**
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
	 * @method setPaddingRight
	 * @since 0.7.0
	 */
	public func setPaddingRight(type: DisplayNodePaddingType, unit: DisplayNodePaddingUnit, length: Double) {
		DisplayNodeSetPaddingRight(self.handle, type, unit, length)
	}

	/**
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
	 * @method setPaddingBottom
	 * @since 0.7.0
	 */
	public func setPaddingBottom(type: DisplayNodePaddingType, unit: DisplayNodePaddingUnit, length: Double) {
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
		return self.delegate?.measure(node: self, in: rect, min: min, max: max)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 */
	internal func update(name: String, property: PropertyRef?) {

		guard let prop = self.delegate?.getProperty(name) else {
			return
		}

		if (property == nil) {
			prop.reset(lock: nil, initial: true)
			return
		}

		let count = PropertyGetValueCount(property)

		if (count == 1) {

			switch (PropertyGetValueType(property, 0)) {

				case kPropertyValueTypeNull:
					prop.reset()

				case kPropertyValueTypeString:
					prop.reset(PropertyGetValueAsString(property, 0).string)

				case kPropertyValueTypeNumber:
					prop.reset(PropertyGetValueAsNumber(property, 0), unit: toUnit(src: PropertyGetValueUnit(property, 0)))

				case kPropertyValueTypeBoolean:
					prop.reset(PropertyGetValueAsBoolean(property, 0))

				case kPropertyValueTypeFunction:
				break
				case kPropertyValueTypeVariable:
					break

				default:
					break;
			}
		}
	}
}

func toUnit(src: PropertyValueUnit) -> JavaScriptPropertyUnit {
	switch (src) {
	case kPropertyValueUnitNone: return .none
	case kPropertyValueUnitPX: return .px
	case kPropertyValueUnitPC: return .pc
	case kPropertyValueUnitVW: return .vw
	case kPropertyValueUnitVH: return .vh
	case kPropertyValueUnitPW: return .pw
	case kPropertyValueUnitPH: return .ph
	case kPropertyValueUnitCW: return .cw
	case kPropertyValueUnitCH: return .ch
	case kPropertyValueUnitDeg: return .deg
	case kPropertyValueUnitRad: return .rad
	default: return .none
	}
}

/**
 * @const displayNodeDidInvalidateCallback
 * @since 0.7.0
 * @hidden
 */
private let displayNodeDidInvalidateCallback: @convention(c) (DisplayNodeRef?) -> Void = { ptr in
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
private let displayNodeMeasureSizeCallback: @convention(c) (DisplayNodeRef?, UnsafeMutablePointer<DisplayNodeMeasuredSize>?, Double, Double, Double, Double, Double, Double) -> Void = { (ptr, res, w, h, minw, maxw, minh, maxh) in

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
	print("WAT")
	guard let name = name else { return }
	if let node = DisplayNodeGetData(ptr).value as? DisplayNode {
		node.update(name: name.string, property: property)
	}
}
