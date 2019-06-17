import Foundation

/**
 * Manages the style of an element.
 * @class StylerNode
 * @since 0.1.0
 */
open class StylerNode {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property delegate
	 * @since 0.1.0
	 */
	public weak var delegate: StylerNodeDelegate?

	/**
	 * @property id
	 * @since 0.1.0
	 */
	open var id: String = "" {
		willSet {
			DLStylerNodeSetId(self.handle, newValue)
		}
	}

	/**
	 * @property type
	 * @since 0.1.0
	 */
	open var type: String = "" {
		willSet {
			DLStylerNodeSetType(self.handle, newValue)
		}
	}

	/**
	 * @property visible
	 * @since 0.1.0
	 */
	open var visible: Bool = true {
		willSet {
			DLStylerNodeSetVisible(self.handle, newValue)
		}
	}

	/**
	 * @property handle
	 * @since 0.1.0
	 * @hidden
	 */
	internal var handle: DLStylerNodeRef!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	internal init(styler: Styler) {
		self.handle = DLStylerNodeCreate()
		DLStylerNodeSetStyler(self.handle, styler.handle)
		DLStylerNodeSetApplyCallback(self.handle, applyCallback)
		DLStylerNodeSetFetchCallback(self.handle, fetchCallback)
		DLStylerNodeSetInvalidateCallback(self.handle, invalidateCallback)
		DLStylerNodeSetData(self.handle, UnsafeMutableRawPointer(unretained: self))
	}

	/**
	 * @destructor
	 * @since 0.1.0
	 */
	deinit {
		DLStylerNodeDelete(self.handle)
	}

	/**
	 * @method appendChild
	 * @since 0.1.0
	 * @hidden
	 */
	open func appendChild(_ node: StylerNode) {
		DLStylerNodeAppendChild(self.handle, node.handle)
	}

	/**
	 * @method insertChild
	 * @since 0.1.0
	 * @hidden
	 */
	open func insertChild(_ node: StylerNode, at: Int) {
		DLStylerNodeInsertChild(self.handle, node.handle, Int32(at))
	}

	/**
	 * @method removeChild
	 * @since 0.1.0
	 * @hidden
	 */
	open func removeChild(_ node: StylerNode) {
		DLStylerNodeRemoveChild(self.handle, node.handle)
	}

	/**
	 * @method appendShadowedNode
	 * @since 0.1.0
	 * @hidden
	 */
	open func appendShadowedNode(_ node: StylerNode) {
		DLStylerNodeAppendShadowedNode(self.handle, node.handle)
	}

	/**
	 * @method insertShadowedNode
	 * @since 0.1.0
	 * @hidden
	 */
	open func insertShadowedNode(_ node: StylerNode, at: Int) {
		DLStylerNodeInsertShadowedElement(self.handle, node.handle, Int32(at))
	}

	/**
	 * @method removeShadowedNode
	 * @since 0.1.0
	 * @hidden
	 */
	open func removeShadowedNode(_ node: StylerNode) {
		DLStylerNodeRemoveShadowedNode(self.handle, node.handle)
	}

	/**
	 * @method hasStyle
	 * @since 0.7.0
	 * @hidden
	 */
	open func hasStyle(_ style: String) -> Bool {
		return DLStylerNodeHasStyle(self.handle, style)
	}

	/**
	 * @method setStyle
	 * @since 0.7.0
	 * @hidden
	 */
	open func setStyle(_ style: String, enable: Bool = true) {
		DLStylerNodeSetStyle(self.handle, style, enable)
	}

	/**
	 * @method hasState
	 * @since 0.7.0
	 * @hidden
	 */
	open func hasState(_ state: String) -> Bool {
		return DLStylerNodeHasState(self.handle, state)
	}

	/**
	 * @method setState
	 * @since 0.7.0
	 * @hidden
	 */
	open func setState(_ state: String, enable: Bool = true) {
		DLStylerNodeSetState(self.handle, state, enable)
	}

	/**
	 * @method resolve
	 * @since 0.1.0
	 * @hidden
	 */
	open func resolve() {
		DLStylerNodeResolve(self.handle)
	}
}

/**
 * @const applyCallback
 * @since 0.1.0
 * @hidden
 */
private let applyCallback: @convention(c) (DLStylerNodeRef?, DLStylerStyleItemRef?) -> Void = { node, item in

	let node = node!
	let item = item!

	guard let stylerNode = DLStylerNodeGetData(node).value as? StylerNode else {
		return
	}

	let name = DLStylerStyleItemGetProperty(item).string
	let type = DLStylerStyleItemGetValueType(item)
	let unit = DLStylerStyleItemGetValueUnit(item)
	let data = DLStylerStyleItemGetData(item)

	if let value = data?.value as? Property {
		stylerNode.delegate?.applyStyleProperty(node: stylerNode, property: name, value: value)
		return
	}

	let value: Property

	if (type == kDLStylerStyleItemTypeNumber) {

		switch (unit) {

			case kDLStylerStyleItemUnitPX: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .px)
			case kDLStylerStyleItemUnitPC: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .pc)
			case kDLStylerStyleItemUnitVW: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .vw)
			case kDLStylerStyleItemUnitVH: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .vh)
			case kDLStylerStyleItemUnitPW: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .pw)
			case kDLStylerStyleItemUnitPH: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .ph)
			case kDLStylerStyleItemUnitCW: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .cw)
			case kDLStylerStyleItemUnitCH: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .ch)
			case kDLStylerStyleItemUnitDeg: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .deg)
			case kDLStylerStyleItemUnitRad: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .rad)
			case kDLStylerStyleItemUnitNone: value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .none)

			default:
				value = Property(number: DLStylerStyleItemGetValueAsNumber(item), unit: .none)
		}

	} else if (type == kDLStylerStyleItemTypeString) {

		value = Property(string: DLStylerStyleItemGetValueAsString(item).string)

	} else if (type == kDLStylerStyleItemTypeBoolean) {

		value = Property(boolean: DLStylerStyleItemGetValueAsBoolean(item))

	} else {
		value = Property()
	}

	DLStylerStyleItemSetData(item, UnsafeMutableRawPointer(value: value))

	stylerNode.delegate?.applyStyleProperty(node: stylerNode, property: name, value: value)
}

/**
 * @const fetchCallback
 * @since 0.1.0
 * @hidden
 */
private let fetchCallback: @convention(c) (DLStylerNodeRef?, DLStylerStyleItemRef?) -> Bool = { node, item in

	let node = node!
	let item = item!

	guard let stylerNode = DLStylerNodeGetData(node).value as? StylerNode else {
		return false
	}

	if let result = stylerNode.delegate?.fetchStyleProperty(node: stylerNode, property: DLStylerStyleItemGetProperty(item).string) {

		if (result.type == .string) {
			DLStylerStyleItemSetValueType(item, kDLStylerStyleItemTypeString)
			DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitNone)
			DLStylerStyleItemSetValueWithString(item, result.string)
			return true
		}

		if (result.type == .number) {

			DLStylerStyleItemSetValueType(item, kDLStylerStyleItemTypeNumber)
			DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitNone)
			DLStylerStyleItemSetValueWithNumber(item, result.number)

			switch (result.unit) {
				case .px: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitPX)
				case .pc: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitPC)
				case .vw: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitVW)
				case .vh: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitVH)
				case .pw: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitPW)
				case .ph: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitPH)
				case .cw: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitCW)
				case .ch: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitCH)
				case .deg: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitDeg)
				case .rad: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitRad)
				case .none: DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitNone)
			}

			return true
		}

		if (result.type == .boolean) {
			DLStylerStyleItemSetValueType(item, kDLStylerStyleItemTypeBoolean)
			DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitNone)
			DLStylerStyleItemSetValueWithBoolean(item, result.boolean)
			return true
		}

		if (result.type == .null) {
			DLStylerStyleItemSetValueType(item, kDLStylerStyleItemTypeNull)
			DLStylerStyleItemSetValueUnit(item, kDLStylerStyleItemUnitNone)
			return true
		}
	}

	return false
}

/**
 * @const invalidateCallback
 * @since 0.1.0
 * @hidden
 */
private let invalidateCallback: @convention(c) (DLStylerNodeRef?) -> Void = { ptr in
	if let styles = DLStylerNodeGetData(ptr).value as? StylerNode {
		styles.delegate?.didInvalidateStylerNode(node: styles)
	}
}
