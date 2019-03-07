import Foundation

/**
 * Manages and resolves the layout of a node within a hierarchy.
 * @class LayoutNode
 * @since 0.1.0
 */
open class LayoutNode {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The layout node's delegate.
	 * @property delegate
	 * @since 0.1.0
	 */
	open weak var delegate: LayoutNodeDelegate?

	/**
	 * @property id
	 * @since 0.1.0
	 */
	open var id: String = "" {
		willSet {
			DLLayoutNodeSetId(self.handle, newValue)
		}
	}

	/**
	 * @property visible
	 * @since 0.1.0
	 */
	open var visible: Bool = true {
		willSet {
			DLLayoutNodeSetVisible(self.handle, newValue)
		}
	}

	/**
	 * @property measuredTop
	 * @since 0.1.0
	 */
	open var measuredTop: Double {
		return DLLayoutNodeGetMeasuredTop(self.handle)
	}

	/**
	 * @property measuredLeft
	 * @since 0.1.0
	 */
	open var measuredLeft: Double {
		return DLLayoutNodeGetMeasuredLeft(self.handle)
	}

	/**
	 * @property measuredRight
	 * @since 0.1.0
	 */
	open var measuredRight: Double {
		return DLLayoutNodeGetMeasuredRight(self.handle)
	}

	/**
	 * @property measuredBottom
	 * @since 0.1.0
	 */
	open var measuredBottom: Double {
		return DLLayoutNodeGetMeasuredBottom(self.handle)
	}

	/**
	 * @property measuredWidth
	 * @since 0.1.0
	 */
	open var measuredWidth: Double {
		return DLLayoutNodeGetMeasuredWidth(self.handle)
	}

	/**
	 * @property measuredHeight
	 * @since 0.1.0
	 */
	open var measuredHeight: Double {
		return DLLayoutNodeGetMeasuredHeight(self.handle)
	}

	/**
	 * @property measuredInnerWidth
	 * @since 0.1.0
	 */
	open var measuredInnerWidth: Double {
		return DLLayoutNodeGetMeasuredInnerWidth(self.handle)
	}

	/**
	 * @property measuredInnerHeight
	 * @since 0.1.0
	 */
	open var measuredInnerHeight: Double {
		return DLLayoutNodeGetMeasuredInnerHeight(self.handle)
	}

	/**
	 * @property measuredContentWidth
	 * @since 0.1.0
	 */
	open var measuredContentWidth: Double {
		return DLLayoutNodeGetMeasuredContentWidth(self.handle)
	}

	/**
	 * @property measuredContentHeight
	 * @since 0.1.0
	 */
	open var measuredContentHeight: Double {
		return DLLayoutNodeGetMeasuredContentHeight(self.handle)
	}

	/**
	 * @property measuredMarginTop
	 * @since 0.1.0
	 */
	open var measuredMarginTop: Double {
		return DLLayoutNodeGetMeasuredMarginTop(self.handle)
	}

	/**
	 * @property measuredMarginLeft
	 * @since 0.1.0
	 */
	open var measuredMarginLeft: Double {
		return DLLayoutNodeGetMeasuredMarginLeft(self.handle)
	}

	/**
	 * @property measuredMarginRight
	 * @since 0.1.0
	 */
	open var measuredMarginRight: Double {
		return DLLayoutNodeGetMeasuredMarginRight(self.handle)
	}

	/**
	 * @property measuredMarginBottom
	 * @since 0.1.0
	 */
	open var measuredMarginBottom: Double {
		return DLLayoutNodeGetMeasuredMarginBottom(self.handle)
	}

	/**
	 * @property measuredPaddingTop
	 * @since 0.1.0
	 */
	open var measuredPaddingTop: Double {
		return DLLayoutNodeGetMeasuredPaddingTop(self.handle)
	}

	/**
	 * @property measuredBorderTop
	 * @since 0.1.0
	 */
	open var measuredBorderTop: Double {
		return DLLayoutNodeGetMeasuredBorderTop(self.handle)
	}

	/**
	 * @property measuredBorderLeft
	 * @since 0.1.0
	 */
	open var measuredBorderLeft: Double {
		return DLLayoutNodeGetMeasuredBorderLeft(self.handle)
	}

	/**
	 * @property measuredBorderRight
	 * @since 0.1.0
	 */
	open var measuredBorderRight: Double {
		return DLLayoutNodeGetMeasuredBorderRight(self.handle)
	}

	/**
	 * @property measuredBorderBottom
	 * @since 0.1.0
	 */
	open var measuredBorderBottom: Double {
		return DLLayoutNodeGetMeasuredBorderBottom(self.handle)
	}

	/**
	 * @property measuredPaddingLeft
	 * @since 0.1.0
	 */
	open var measuredPaddingLeft: Double {
		return DLLayoutNodeGetMeasuredPaddingLeft(self.handle)
	}

	/**
	 * @property measuredPaddingRight
	 * @since 0.1.0
	 */
	open var measuredPaddingRight: Double {
		return DLLayoutNodeGetMeasuredPaddingRight(self.handle)
	}

	/**
	 * @property measuredPaddingBottom
	 * @since 0.1.0
	 */
	open var measuredPaddingBottom: Double {
		return DLLayoutNodeGetMeasuredPaddingBottom(self.handle)
	}

	/**
	 * @property viewportWidth
	 * @since 0.1.0
	 */
	open var viewportWidth: Double {
		return DLLayoutNodeGetViewportWidth(self.handle)
	}

	/**
	 * @property viewportHeight
	 * @since 0.1.0
	 */
	open var viewportHeight: Double {
		return DLLayoutNodeGetViewportHeight(self.handle)
	}

	/**
	 * @property fillsParentWidth
	 * @since 0.1.0
	 */
	open var fillsParentWidth: Bool {
		return DLLayoutNodeFillsParentWidth(self.handle)
	}

	/**
	 * @property fillsParentHeight
	 * @since 0.1.0
	 */
	open var fillsParentHeight: Bool {
		return DLLayoutNodeFillsParentHeight(self.handle)
	}

	/**
	 * @property wrapsContentWidth
	 * @since 0.1.0
	 */
	open var wrapsContentWidth: Bool {
		return DLLayoutNodeWrapsContentWidth(self.handle)
	}

	/**
	 * @property wrapsContentHeight
	 * @since 0.1.0
	 */
	open var wrapsContentHeight: Bool {
		return DLLayoutNodeWrapsContentHeight(self.handle)
	}

	/**
	 * @property hasInvalidSize
	 * @since 0.2.0
	 */
	open var hasInvalidSize: Bool {
		return DLLayoutNodeHasInvalidSize(self.handle)
	}

	/**
	 * @property hasInvalidPosition
	 * @since 0.2.0
	 */
	open var hasInvalidPosition: Bool {
		return DLLayoutNodeHasInvalidPosition(self.handle)
	}

	/**
	 * @property hasInvalidLayout
	 * @since 0.1.0
	 */
	open var hasInvalidLayout: Bool {
		return DLLayoutNodeHasInvalidLayout(self.handle)
	}

	/**
	 * @property handle
	 * @since 0.1.0
	 */
	private(set) public var handle: DLLayoutNodeRef!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	internal init(layout: Layout) {
		self.handle = DLLayoutNodeCreate()
		DLLayoutNodeSetLayout(self.handle, layout.handle)
		DLLayoutNodeSetPrepareCallback(self.handle, prepareCallback)
		DLLayoutNodeSetMeasureCallback(self.handle, measureCallback)
		DLLayoutNodeSetResolveSizeCallback(self.handle, resolveSizeCallback)
		DLLayoutNodeSetResolveInnerSizeCallback(self.handle, resolveInnerSizeCallback)
		DLLayoutNodeSetResolveContentSizeCallback(self.handle, resolveContentSizeCallback)
		DLLayoutNodeSetResolvePositionCallback(self.handle, resolvePositionCallback)
		DLLayoutNodeSetResolveMarginCallback(self.handle, resolveMarginCallback)
		DLLayoutNodeSetResolveBorderCallback(self.handle, resolveBorderCallback)
		DLLayoutNodeSetResolvePaddingCallback(self.handle, resolvePaddingCallback)
		DLLayoutNodeSetLayoutBeganCallback(self.handle, layoutBeganCallback)
		DLLayoutNodeSetLayoutEndedCallback(self.handle, layoutEndedCallback)
		DLLayoutNodeSetInvalidateCallback(self.handle, invalidateCallback)
		DLLayoutNodeSetData(self.handle, UnsafeMutableRawPointer(unretained: self))
	}

	/**
	 * @destructor
	 * @since 0.1.0
	 */
	deinit {
		DLLayoutNodeDelete(self.handle)
	}

	/**
	 * @method anchorTop
	 * @since 0.1.0
	 */
	open func anchorTop(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "top":    self.anchorTop(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: 0)
				case "center": self.anchorTop(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: 50)
				case "bottom": self.anchorTop(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: 100)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .pc: self.anchorTop(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: value.number)
				default:  self.anchorTop(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: value.number * 100)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method anchorTop
	 * @since 0.1.0
	 */
	open func anchorTop(type: DLLayoutAnchorType, unit: DLLayoutAnchorUnit, length: Double) {
		DLLayoutNodeSetAnchorTop(self.handle, type, unit, length)
	}

	/**
	 * @method anchorLeft
	 * @since 0.1.0
	 */
	open func anchorLeft(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "left":   self.anchorLeft(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: 0)
				case "center": self.anchorLeft(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: 50)
				case "right":  self.anchorLeft(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: 100)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .pc: self.anchorLeft(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: value.number)
				default:  self.anchorLeft(type: kDLLayoutAnchorTypeLength, unit: kDLLayoutAnchorUnitPC, length: value.number * 100)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method anchorLeft
	 * @since 0.1.0
	 */
	open func anchorLeft(type: DLLayoutAnchorType, unit: DLLayoutAnchorUnit, length: Double) {
		DLLayoutNodeSetAnchorLeft(self.handle, type, unit, length)
	}

	/**
	 * @method top
	 * @since 0.1.0
	 */
	open func top(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.top(type: kDLLayoutPositionTypeAuto, unit: kDLLayoutPositionUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: value.number)
				case .pc: self.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: value.number)
				case .vw: self.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: value.number)
				case .vh: self.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: value.number)
				case .pw: self.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPW, length: value.number)
				case .ph: self.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPH, length: value.number)
				case .cw: self.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCW, length: value.number)
				case .ch: self.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCH, length: value.number)
				default:  self.top(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method top
	 * @since 0.1.0
	 */
	open func top(type: DLLayoutPositionType, unit: DLLayoutPositionUnit, length: Double) {
		DLLayoutNodeSetTop(self.handle, type, unit, length)
	}

	/**
	 * @method minTop
	 * @since 0.1.0
	 */
	open func minTop(_ min: Double) {
		DLLayoutNodeSetMinTop(self.handle, min)
	}

	/**
	 * @method maxTop
	 * @since 0.1.0
	 */
	open func maxTop(_ max: Double) {
		DLLayoutNodeSetMaxTop(self.handle, max)
	}

	/**
	 * @method left
	 * @since 0.1.0
	 */
	open func left(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.left(type: kDLLayoutPositionTypeAuto, unit: kDLLayoutPositionUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: value.number)
				case .pc: self.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: value.number)
				case .vw: self.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: value.number)
				case .vh: self.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: value.number)
				case .pw: self.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPW, length: value.number)
				case .ph: self.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPH, length: value.number)
				case .cw: self.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCW, length: value.number)
				case .ch: self.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCH, length: value.number)
				default:  self.left(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method left
	 * @since 0.1.0
	 */
	open func left(type: DLLayoutPositionType, unit: DLLayoutPositionUnit, length: Double) {
		DLLayoutNodeSetLeft(self.handle, type, unit, length)
	}

	/**
	 * @method minLeft
	 * @since 0.1.0
	 */
	open func minLeft(_ min: Double) {
		DLLayoutNodeSetMinLeft(self.handle, min)
	}

	/**
	 * @method maxLeft
	 * @since 0.1.0
	 */
	open func maxLeft(_ max: Double) {
		DLLayoutNodeSetMaxLeft(self.handle, max)
	}

	/**
	 * @method right
	 * @since 0.1.0
	 */
	open func right(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.right(type: kDLLayoutPositionTypeAuto, unit: kDLLayoutPositionUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: value.number)
				case .pc: self.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: value.number)
				case .vw: self.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: value.number)
				case .vh: self.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: value.number)
				case .pw: self.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPW, length: value.number)
				case .ph: self.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPH, length: value.number)
				case .cw: self.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCW, length: value.number)
				case .ch: self.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCH, length: value.number)
				default:  self.right(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method right
	 * @since 0.1.0
	 */
	open func right(type: DLLayoutPositionType, unit: DLLayoutPositionUnit, length: Double) {
		DLLayoutNodeSetRight(self.handle, type, unit, length)
	}

	/**
	 * @method minRight
	 * @since 0.1.0
	 */
	open func minRight(_ min: Double) {
		DLLayoutNodeSetMinRight(self.handle, min)
	}

	/**
	 * @method maxRight
	 * @since 0.1.0
	 */
	open func maxRight(_ max: Double) {
		DLLayoutNodeSetMaxRight(self.handle, max)
	}

	/**
	 * @method bottom
	 * @since 0.1.0
	 */
	open func bottom(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.bottom(type: kDLLayoutPositionTypeAuto, unit: kDLLayoutPositionUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: value.number)
				case .pc: self.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPC, length: value.number)
				case .vw: self.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVW, length: value.number)
				case .vh: self.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitVH, length: value.number)
				case .pw: self.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPW, length: value.number)
				case .ph: self.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPH, length: value.number)
				case .cw: self.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCW, length: value.number)
				case .ch: self.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitCH, length: value.number)
				default:  self.bottom(type: kDLLayoutPositionTypeLength, unit: kDLLayoutPositionUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method bottom
	 * @since 0.1.0
	 */
	open func bottom(type: DLLayoutPositionType, unit: DLLayoutPositionUnit, length: Double) {
		DLLayoutNodeSetBottom(self.handle, type, unit, length)
	}

	/**
	 * @method minBottom
	 * @since 0.1.0
	 */
	open func minBottom(_ min: Double) {
		DLLayoutNodeSetMinBottom(self.handle, min)
	}

	/**
	 * @method maxBottom
	 * @since 0.1.0
	 */
	open func maxBottom(_ max: Double) {
		DLLayoutNodeSetMaxBottom(self.handle, max)
	}

	/**
	 * @method width
	 * @since 0.1.0
	 */
	open func width(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "fill": self.width(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
				case "wrap": self.width(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: value.number)
				case .pc: self.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: value.number)
				case .vw: self.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVW, length: value.number)
				case .vh: self.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVH, length: value.number)
				case .pw: self.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPW, length: value.number)
				case .ph: self.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPH, length: value.number)
				case .cw: self.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVW, length: value.number)
				case .ch: self.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVH, length: value.number)
				default:  self.width(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method width
	 * @since 0.1.0
	 */
	open func width(type: DLLayoutSizeType, unit: DLLayoutSizeUnit, length: Double) {
			DLLayoutNodeSetWidth(self.handle, type, unit, length)
	}

	/**
	 * @method minWidth
	 * @since 0.1.0
	 */
	open func minWidth(_ min: Double) {
		DLLayoutNodeSetMinWidth(self.handle, min)
	}

	/**
	 * @method maxWidth
	 * @since 0.1.0
	 */
	open func maxWidth(_ max: Double) {
		DLLayoutNodeSetMaxWidth(self.handle, max)
	}

	/**
	 * @method height
	 * @since 0.1.0
	 */
	open func height(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "fill": self.height(type: kDLLayoutSizeTypeFill, unit: kDLLayoutSizeUnitNone, length: 0)
				case "wrap": self.height(type: kDLLayoutSizeTypeWrap, unit: kDLLayoutSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: value.number)
				case .pc: self.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPC, length: value.number)
				case .vw: self.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVW, length: value.number)
				case .vh: self.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVH, length: value.number)
				case .pw: self.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPW, length: value.number)
				case .ph: self.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPH, length: value.number)
				case .cw: self.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVW, length: value.number)
				case .ch: self.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitVH, length: value.number)
				default:  self.height(type: kDLLayoutSizeTypeLength, unit: kDLLayoutSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method height
	 * @since 0.1.0
	 */
	open func height(type: DLLayoutSizeType, unit: DLLayoutSizeUnit, length: Double) {
		DLLayoutNodeSetHeight(self.handle, type, unit, length)
	}

	/**
	 * @method minHeight
	 * @since 0.1.0
	 */
	open func minHeight(_ min: Double) {
		DLLayoutNodeSetMinHeight(self.handle, min)
	}

	/**
	 * @method maxHeight
	 * @since 0.1.0
	 */
	open func maxHeight(_ max: Double) {
		DLLayoutNodeSetMaxHeight(self.handle, max)
	}

	/**
	 * @method contentOrientation
	 * @since 0.1.0
	 */
	open func contentOrientation(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "horizontal": self.contentOrientation(kDLLayoutContentOrientationHorizontal)
				case "vertical":   self.contentOrientation(kDLLayoutContentOrientationVertical)
				default: break
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method contentOrientation
	 * @since 0.1.0
	 */
	open func contentOrientation(_ direction: DLLayoutContentOrientation) {
		DLLayoutNodeSetContentOrientation(self.handle, direction)
	}

	/**
	 * @method contentDisposition
	 * @since 0.1.0
	 */
	open func contentDisposition(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "center":        self.contentDisposition(kDLLayoutContentDispositionCenter)
				case "start":         self.contentDisposition(kDLLayoutContentDispositionStart)
				case "end":           self.contentDisposition(kDLLayoutContentDispositionEnd)
				case "space-around":  self.contentDisposition(kDLLayoutContentDispositionSpaceAround)
				case "space-evenly":  self.contentDisposition(kDLLayoutContentDispositionSpaceEvenly)
				case "space-between": self.contentDisposition(kDLLayoutContentDispositionSpaceBetween)
				default: break
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method contentDisposition
	 * @since 0.1.0
	 */
	open func contentDisposition(_ contentDisposition: DLLayoutContentDisposition) {
		DLLayoutNodeSetContentDisposition(self.handle, contentDisposition)
	}

	/**
	 * @method contentArrangement
	 * @since 0.1.0
	 */
	open func contentArrangement(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "center": self.contentArrangement(kDLLayoutContentArrangementCenter)
				case "start":  self.contentArrangement(kDLLayoutContentArrangementStart)
				case "end":    self.contentArrangement(kDLLayoutContentArrangementEnd)
				default: break
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method contentArrangement
	 * @since 0.1.0
	 */
	open func contentArrangement(_ contentArrangement: DLLayoutContentArrangement) {
		DLLayoutNodeSetContentArrangement(self.handle, contentArrangement)
	}

	/**
	 * @method contentTop
	 * @since 0.1.0
	 */
	open func contentTop(_ value: Property) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.contentTop(type: kDLLayoutContentPositionTypeLength, unit: kDLLayoutContentPositionUnitPX, length: value.number)
				default:  self.contentTop(type: kDLLayoutContentPositionTypeLength, unit: kDLLayoutContentPositionUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method contentTop
	 * @since 0.1.0
	 */
	open func contentTop(type: DLLayoutContentPositionType, unit: DLLayoutContentPositionUnit, length: Double) {
		DLLayoutNodeSetContentTop(self.handle, type, unit, length)
	}

	/**
	 * @method contentLeft
	 * @since 0.1.0
	 */
	open func contentLeft(_ value: Property) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.contentLeft(type: kDLLayoutContentPositionTypeLength, unit: kDLLayoutContentPositionUnitPX, length: value.number)
				default:  self.contentLeft(type: kDLLayoutContentPositionTypeLength, unit: kDLLayoutContentPositionUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method contentLeft
	 * @since 0.1.0
	 */
	open func contentLeft(type: DLLayoutContentPositionType, unit: DLLayoutContentPositionUnit, length: Double) {
		DLLayoutNodeSetContentLeft(self.handle, type, unit, length)
	}

	/**
	 * @method contentWidth
	 * @since 0.1.0
	 */
	open func contentWidth(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.contentWidth(type: kDLLayoutContentSizeTypeAuto, unit: kDLLayoutContentSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: value.number)
				case .pc: self.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPC, length: value.number)
				case .vw: self.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitVW, length: value.number)
				case .vh: self.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitVH, length: value.number)
				case .pw: self.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPW, length: value.number)
				case .ph: self.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPH, length: value.number)
				case .cw: self.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitCW, length: value.number)
				case .ch: self.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitCH, length: value.number)
				default:  self.contentWidth(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method contentWidth
	 * @since 0.1.0
	 */
	open func contentWidth(type: DLLayoutContentSizeType, unit: DLLayoutContentSizeUnit, length: Double) {
		DLLayoutNodeSetContentWidth(self.handle, type, unit, length)
	}

	/**
	 * @method contentHeight
	 * @since 0.1.0
	 */
	open func contentHeight(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "auto": self.contentHeight(type: kDLLayoutContentSizeTypeAuto, unit: kDLLayoutContentSizeUnitNone, length: 0)
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: value.number)
				case .pc: self.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPC, length: value.number)
				case .vw: self.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitVW, length: value.number)
				case .vh: self.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitVH, length: value.number)
				case .pw: self.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPW, length: value.number)
				case .ph: self.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPH, length: value.number)
				case .cw: self.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitCW, length: value.number)
				case .ch: self.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitCH, length: value.number)
				default:  self.contentHeight(type: kDLLayoutContentSizeTypeLength, unit: kDLLayoutContentSizeUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method contentHeight
	 * @since 0.1.0
	 */
	open func contentHeight(type: DLLayoutContentSizeType, unit: DLLayoutContentSizeUnit, length: Double) {
		DLLayoutNodeSetContentHeight(self.handle, type, unit, length)
	}

	/**
	 * @method borderTop
	 * @since 0.1.0
	 */
	open func borderTop(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: value.number)
				case .pc: self.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPC, length: value.number)
				case .vw: self.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: value.number)
				case .vh: self.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: value.number)
				case .pw: self.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: value.number)
				case .ph: self.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: value.number)
				case .cw: self.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCW, length: value.number)
				case .ch: self.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCH, length: value.number)
				default:  self.borderTop(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method borderTop
	 * @since 0.1.0
	 */
	open func borderTop(type: DLLayoutBorderType, unit: DLLayoutBorderUnit, length: Double) {
		DLLayoutNodeSetBorderTop(self.handle, type, unit, length)
	}

	/**
	 * @method borderLeft
	 * @since 0.1.0
	 */
	open func borderLeft(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: value.number)
				case .pc: self.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPC, length: value.number)
				case .vw: self.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: value.number)
				case .vh: self.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: value.number)
				case .pw: self.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: value.number)
				case .ph: self.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: value.number)
				case .cw: self.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCW, length: value.number)
				case .ch: self.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCH, length: value.number)
				default:  self.borderLeft(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method borderLeft
	 * @since 0.1.0
	 */
	open func borderLeft(type: DLLayoutBorderType, unit: DLLayoutBorderUnit, length: Double) {
		DLLayoutNodeSetBorderLeft(self.handle, type, unit, length)
	}

	/**
	 * @method borderRight
	 * @since 0.1.0
	 */
	open func borderRight(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: value.number)
				case .pc: self.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPC, length: value.number)
				case .vw: self.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: value.number)
				case .vh: self.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: value.number)
				case .pw: self.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: value.number)
				case .ph: self.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: value.number)
				case .cw: self.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCW, length: value.number)
				case .ch: self.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCH, length: value.number)
				default:  self.borderRight(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method borderRight
	 * @since 0.1.0
	 */
	open func borderRight(type: DLLayoutBorderType, unit: DLLayoutBorderUnit, length: Double) {
		DLLayoutNodeSetBorderRight(self.handle, type, unit, length)
	}

	/**
	 * @method borderBottom
	 * @since 0.1.0
	 */
	open func borderBottom(_ value: Property) {

		if (value.type == .string) {

			switch (value.string) {
				case "thin": self.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: Double(1 / UIScreen.main.scale))
				default: break
			}

			return
		}

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: value.number)
				case .pc: self.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPC, length: value.number)
				case .vw: self.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: value.number)
				case .vh: self.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: value.number)
				case .pw: self.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVW, length: value.number)
				case .ph: self.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitVH, length: value.number)
				case .cw: self.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCW, length: value.number)
				case .ch: self.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitCH, length: value.number)
				default:  self.borderBottom(type: kDLLayoutBorderTypeLength, unit: kDLLayoutBorderUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method borderBottom
	 * @since 0.1.0
	 */
	open func borderBottom(type: DLLayoutBorderType, unit: DLLayoutBorderUnit, length: Double) {
		DLLayoutNodeSetBorderBottom(self.handle, type, unit, length)
	}

	/**
	 * @method marginTop
	 * @since 0.1.0
	 */
	open func marginTop(_ value: Property) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: value.number)
				case .pc: self.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPC, length: value.number)
				case .vw: self.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: value.number)
				case .vh: self.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: value.number)
				case .pw: self.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPW, length: value.number)
				case .ph: self.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPH, length: value.number)
				case .cw: self.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: value.number)
				case .ch: self.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: value.number)
				default:  self.marginTop(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method marginTop
	 * @since 0.1.0
	 */
	open func marginTop(type: DLLayoutMarginType, unit: DLLayoutMarginUnit, length: Double) {
		DLLayoutNodeSetMarginTop(self.handle, type, unit, length)
	}

	/**
	 * @method marginLeft
	 * @since 0.1.0
	 */
	open func marginLeft(_ value: Property) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: value.number)
				case .pc: self.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPC, length: value.number)
				case .vw: self.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: value.number)
				case .vh: self.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: value.number)
				case .pw: self.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPW, length: value.number)
				case .ph: self.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPH, length: value.number)
				case .cw: self.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: value.number)
				case .ch: self.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: value.number)
				default:  self.marginLeft(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method marginLeft
	 * @since 0.1.0
	 */
	open func marginLeft(type: DLLayoutMarginType, unit: DLLayoutMarginUnit, length: Double) {
		DLLayoutNodeSetMarginLeft(self.handle, type, unit, length)
	}

	/**
	 * @method marginRight
	 * @since 0.1.0
	 */
	open func marginRight(_ value: Property) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: value.number)
				case .pc: self.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPC, length: value.number)
				case .vw: self.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: value.number)
				case .vh: self.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: value.number)
				case .pw: self.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPW, length: value.number)
				case .ph: self.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPH, length: value.number)
				case .cw: self.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: value.number)
				case .ch: self.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: value.number)
				default:  self.marginRight(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method marginRight
	 * @since 0.1.0
	 */
	open func marginRight(type: DLLayoutMarginType, unit: DLLayoutMarginUnit, length: Double) {
		DLLayoutNodeSetMarginRight(self.handle, type, unit, length)
	}

	/**
	 * @method marginBottom
	 * @since 0.1.0
	 */
	open func marginBottom(_ value: Property) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: value.number)
				case .pc: self.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPC, length: value.number)
				case .vw: self.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: value.number)
				case .vh: self.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: value.number)
				case .pw: self.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPW, length: value.number)
				case .ph: self.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPH, length: value.number)
				case .cw: self.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVW, length: value.number)
				case .ch: self.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitVH, length: value.number)
				default:  self.marginBottom(type: kDLLayoutMarginTypeLength, unit: kDLLayoutMarginUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method marginBottom
	 * @since 0.1.0
	 */
	open func marginBottom(type: DLLayoutMarginType, unit: DLLayoutMarginUnit, length: Double) {
		DLLayoutNodeSetMarginBottom(self.handle, type, unit, length)
	}

	/**
	 * @method minMarginTop
	 * @since 0.1.0
	 */
	open func minMarginTop(_ min: Double) {
		DLLayoutNodeSetMinMarginTop(self.handle, min)
	}

	/**
	 * @method maxMarginTop
	 * @since 0.1.0
	 */
	open func maxMarginTop(_ max: Double) {
		DLLayoutNodeSetMinMarginTop(self.handle, max)
	}

	/**
	 * @method minMarginLeft
	 * @since 0.1.0
	 */
	open func minMarginLeft(_ min: Double) {
		DLLayoutNodeSetMinMarginLeft(self.handle, min)
	}

	/**
	 * @method maxMarginLeft
	 * @since 0.1.0
	 */
	open func maxMarginLeft(_ max: Double) {
		DLLayoutNodeSetMinMarginLeft(self.handle, max)
	}

	/**
	 * @method minMarginRight
	 * @since 0.1.0
	 */
	open func minMarginRight(_ min: Double) {
		DLLayoutNodeSetMinMarginRight(self.handle, min)
	}

	/**
	 * @method maxMarginRight
	 * @since 0.1.0
	 */
	open func maxMarginRight(_ max: Double) {
		DLLayoutNodeSetMaxMarginRight(self.handle, max)
	}

	/**
	 * @method minMarginBottom
	 * @since 0.1.0
	 */
	open func minMarginBottom(_ min: Double) {
		DLLayoutNodeSetMinMarginBottom(self.handle, min)
	}

	/**
	 * @method maxMarginBottom
	 * @since 0.1.0
	 */
	open func maxMarginBottom(_ max: Double) {
		DLLayoutNodeSetMinMarginBottom(self.handle, max)
	}

	/**
	 * @method paddingTop
	 * @since 0.1.0
	 */
	open func paddingTop(_ value: Property) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: value.number)
				case .pc: self.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPC, length: value.number)
				case .vw: self.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVW, length: value.number)
				case .vh: self.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVH, length: value.number)
				case .pw: self.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPW, length: value.number)
				case .ph: self.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPH, length: value.number)
				case .cw: self.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCW, length: value.number)
				case .ch: self.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCH, length: value.number)
				default:  self.paddingTop(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method paddingTop
	 * @since 0.1.0
	 */
	open func paddingTop(type: DLLayoutPaddingType, unit: DLLayoutPaddingUnit, length: Double) {
		DLLayoutNodeSetPaddingTop(self.handle, type, unit, length)
	}

	/**
	 * @method paddingLeft
	 * @since 0.1.0
	 */
	open func paddingLeft(_ value: Property) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: value.number)
				case .pc: self.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPC, length: value.number)
				case .vw: self.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVW, length: value.number)
				case .vh: self.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVH, length: value.number)
				case .pw: self.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPW, length: value.number)
				case .ph: self.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPH, length: value.number)
				case .cw: self.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCW, length: value.number)
				case .ch: self.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCH, length: value.number)
				default:  self.paddingLeft(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method paddingLeft
	 * @since 0.1.0
	 */
	open func paddingLeft(type: DLLayoutPaddingType, unit: DLLayoutPaddingUnit, length: Double) {
		DLLayoutNodeSetPaddingLeft(self.handle, type, unit, length)
	}

	/**
	 * @method paddingRight
	 * @since 0.1.0
	 */
	open func paddingRight(_ value: Property) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: value.number)
				case .pc: self.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPC, length: value.number)
				case .vw: self.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVW, length: value.number)
				case .vh: self.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVH, length: value.number)
				case .pw: self.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPW, length: value.number)
				case .ph: self.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPH, length: value.number)
				case .cw: self.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCW, length: value.number)
				case .ch: self.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCH, length: value.number)
				default:  self.paddingRight(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method paddingRight
	 * @since 0.1.0
	 */
	open func paddingRight(type: DLLayoutPaddingType, unit: DLLayoutPaddingUnit, length: Double) {
		DLLayoutNodeSetPaddingRight(self.handle, type, unit, length)
	}

	/**
	 * @method paddingBottom
	 * @since 0.1.0
	 */
	open func paddingBottom(_ value: Property) {

		if (value.type == .number) {

			switch (value.unit) {
				case .px: self.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: value.number)
				case .pc: self.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPC, length: value.number)
				case .vw: self.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVW, length: value.number)
				case .vh: self.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitVH, length: value.number)
				case .pw: self.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPW, length: value.number)
				case .ph: self.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPH, length: value.number)
				case .cw: self.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCW, length: value.number)
				case .ch: self.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitCH, length: value.number)
				default:  self.paddingBottom(type: kDLLayoutPaddingTypeLength, unit: kDLLayoutPaddingUnitPX, length: value.number)
			}

			return
		}

		fatalError("Invalid property type.")
	}

	/**
	 * @method paddingBottom
	 * @since 0.1.0
	 */
	open func paddingBottom(type: DLLayoutPaddingType, unit: DLLayoutPaddingUnit, length: Double) {
		DLLayoutNodeSetPaddingBottom(self.handle, type, unit, length)
	}

	/**
	 * @method minPaddingTop
	 * @since 0.1.0
	 */
	open func minPaddingTop(_ min: Double) {
		DLLayoutNodeSetMinPaddingTop(self.handle, min)
	}

	/**
	 * @method maxPaddingTop
	 * @since 0.1.0
	 */
	open func maxPaddingTop(_ max: Double) {
		DLLayoutNodeSetMaxPaddingTop(self.handle, max)
	}

	/**
	 * @method minPaddingLeft
	 * @since 0.1.0
	 */
	open func minPaddingLeft(_ min: Double) {
		DLLayoutNodeSetMinPaddingLeft(self.handle, min)
	}

	/**
	 * @method maxPaddingLeft
	 * @since 0.1.0
	 */
	open func maxPaddingLeft(_ max: Double) {
		DLLayoutNodeSetMaxPaddingLeft(self.handle, max)
	}

	/**
	 * @method minPaddingRight
	 * @since 0.1.0
	 */
	open func minPaddingRight(_ min: Double) {
		DLLayoutNodeSetMinPaddingRight(self.handle, min)
	}

	/**
	 * @method maxPaddingRight
	 * @since 0.1.0
	 */
	open func maxPaddingRight(_ max: Double) {
		DLLayoutNodeSetMaxPaddingRight(self.handle, max)
	}

	/**
	 * @method minPaddingBottom
	 * @since 0.1.0
	 */
	open func minPaddingBottom(_ min: Double) {
		DLLayoutNodeSetMinPaddingBottom(self.handle, min)
	}

	/**
	 * @method maxPaddingBottom
	 * @since 0.1.0
	 */
	open func maxPaddingBottom(_ max: Double) {
		DLLayoutNodeSetMaxPaddingBottom(self.handle, max)
	}

	/**
	 * @method expand
	 * @since 0.1.0
	 */
	open func expand(_ ratio: Double) {
		DLLayoutNodeSetExpand(self.handle, Double(ratio))
	}

	/**
	 * @method shrink
	 * @since 0.1.0
	 */
	open func shrink(_ ratio: Double) {
		DLLayoutNodeSetShrink(self.handle, Double(ratio))
	}

	/**
	 * @method invalidate
	 * @since 0.1.0
	 */
	open func invalidate() {
		DLLayoutNodeInvalidateLayout(self.handle)
	}

	/**
	 * @method invalidateSize
	 * @since 0.2.0
	 */
	open func invalidateSize() {
		DLLayoutNodeInvalidateSize(self.handle)
	}

	/**
	 * @method invalidatePosition
	 * @since 0.2.0
	 */
	open func invalidatePosition() {
		DLLayoutNodeInvalidatePosition(self.handle)
	}

	/**
	 * @method resolve
	 * @since 0.1.0
	 */
	open func resolve() {
		DLLayoutNodeResolve(self.handle)
	}

	/**
	 * @method measure
	 * @since 0.1.0
	 */
	open func measure() {
		DLLayoutNodeResolveSelf(self.handle)
	}

	/**
	 * @method appendChild
	 * @since 0.1.0
	 */
	open func appendChild(_ node: LayoutNode) {
		DLLayoutNodeAppendChild(self.handle, node.handle)
	}

	/**
	 * @method insertChild
	 * @since 0.1.0
	 */
	open func insertChild(_ node: LayoutNode, at: Int) {
		DLLayoutNodeInsertChild(self.handle, node.handle, Int32(at))
	}

	/**
	 * @method removeChild
	 * @since 0.1.0
	 */
	open func removeChild(_ node: LayoutNode) {
		DLLayoutNodeRemoveChild(self.handle, node.handle)
	}

	//--------------------------------------------------------------------------
	// MARK: Test Helpers
	//--------------------------------------------------------------------------

	open var resolveSizeCount: Int {
		return Int(DLLayoutNodeGetResolveSizeCount(self.handle))
	}

	open var resolvePositionCount: Int {
		return Int(DLLayoutNodeGetResolvePositionCount(self.handle))
	}
}

/**
 * @const prepareCallback
 * @since 0.1.0
 * @hidden
 */
private let prepareCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.prepareLayoutNode(node: layout)
	}
}

/**
 * @const measureCallback
 * @since 0.1.0
 * @hidden
 */
private let measureCallback: @convention(c) (DLLayoutNodeRef?, UnsafeMutablePointer<DLLayoutNodeMeasure>?, Double, Double, Double, Double, Double, Double) -> Void = { (ptr, res, w, h, minw, maxw, minh, maxh) in

	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {

		let bounds = CGSize(width: CGFloat(w), height: CGFloat(h))
		let min = CGSize(width: CGFloat(minw), height: CGFloat(minh))
		let max = CGSize(width: CGFloat(maxw), height: CGFloat(maxh))

		if let size = layout.delegate?.measureLayoutNode(node: layout, in: bounds, min: min, max: max), let res = res {
			res.pointee.width = Double(size.width)
			res.pointee.height = Double(size.height)
		}
	}
}

/**
 * @const resolveSizeCallback
 * @since 0.2.0
 * @hidden
 */
private let resolveSizeCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.didResolveSize(node: layout)
	}
}

/**
 * @const resolvePositionCallback
 * @since 0.2.0
 * @hidden
 */
private let resolvePositionCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.didResolvePosition(node: layout)
	}
}

/**
 * @const resolveInnerSizeCallback
 * @since 0.2.0
 * @hidden
 */
private let resolveInnerSizeCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.didResolveInnerSize(node: layout)
	}
}

/**
 * @const resolveContentSizeCallback
 * @since 0.2.0
 * @hidden
 */
private let resolveContentSizeCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.didResolveContentSize(node: layout)
	}
}

/**
 * @const resolveMarginCallback
 * @since 0.1.0
 * @hidden
 */
private let resolveMarginCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.didResolveMargin(node: layout)
	}
}

/**
 * @const resolveBorderCallback
 * @since 0.1.0
 * @hidden
 */
private let resolveBorderCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.didResolveBorder(node: layout)
	}
}

/**
 * @const resolvePaddingCallback
 * @since 0.1.0
 * @hidden
 */
private let resolvePaddingCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.didResolvePadding(node: layout)
	}
}

/**
 * @const layoutBeganCallback
 * @since 0.1.0
 * @hidden
 */
private let layoutBeganCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.didBeginLayout(node: layout)
	}
}

/**
 * @const layoutEndedCallback
 * @since 0.1.0
 * @hidden
 */
private let layoutEndedCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.didFinishLayout(node: layout)
	}
}

/**
 * @const invalidateCallback
 * @since 0.1.0
 * @hidden
 */
private let invalidateCallback: @convention(c) (DLLayoutNodeRef?) -> Void = { ptr in
	if let layout = DLLayoutNodeGetData(ptr).value as? LayoutNode {
		layout.delegate?.didInvalidateLayout(node: layout)
	}
}
