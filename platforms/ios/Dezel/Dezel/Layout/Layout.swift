import Foundation

/**
 * Contextual informations required by each layout node.
 * @class Layout
 * @since 0.4.0
 */
open class Layout {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the layout is invalid.
	 * @property invalid
	 * @since 0.4.0
	 */
	open var invalid: Bool {
		return DLLayoutIsInvalid(self.handle)
	}

	/**
	 * Whether the layout is resolving.
	 * @property resolving
	 * @since 0.4.0
	 */
	open var resolving: Bool {
		return DLLayoutIsResolving(self.handle)
	}

	/**
	 * The layout's root node.
	 * @property root
	 * @since 0.4.0
	 */
	open var root: LayoutNode? {
		willSet {
			DLLayoutSetRoot(self.handle, newValue?.handle)
		}
	}

	/**
	 * The layout's viewport width.
	 * @property viewportWidth
	 * @since 0.4.0
	 */
	open var viewportWidth: CGFloat = 0 {
		willSet {
			DLLayoutSetViewportWidth(self.handle, Double(newValue))
		}
	}

	/**
	 * The layout's viewport height.
	 * @property viewportHeight
	 * @since 0.4.0
	 */
	open var viewportHeight: CGFloat = 0 {
		willSet {
			DLLayoutSetViewportHeight(self.handle, Double(newValue))
		}
	}

	/**
	 * The layout's scale.
	 * @property scale
	 * @since 0.4.0
	 */
	open var scale: CGFloat = 1 {
		willSet {
			DLLayoutSetScale(self.handle, Double(newValue))
		}
	}

	/**
	 * @property handle
	 * @since 0.4.0
	 * @hidden
	 */
	private(set) public var handle: DLLayoutRef

	/**
	 * @property layoutBeganCallbacks
	 * @since 0.4.0
	 * @hidden
	 */
	private var layoutBeganCallbacks: [(() -> Void)] = []

	/**
	 * @property layoutEndedCallbacks
	 * @since 0.4.0
	 * @hidden
	 */
	private var layoutEndedCallbacks: [(() -> Void)] = []

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 */
	internal init() {
		self.handle = DLLayoutCreate()
		DLLayoutSetLayoutBeganCallback(self.handle, layoutBeganCallback)
		DLLayoutSetLayoutEndedCallback(self.handle, layoutEndedCallback)
		DLLayoutSetData(self.handle, UnsafeMutableRawPointer(value: self))
	}

	/**
	 * @destructor
	 * @since 0.4.0
	 */
	deinit {
		DLLayoutGetData(self.handle).release()
		DLLayoutDelete(self.handle)
	}

	/**
	 * Requests a callback that will be executed when the global layout begins.
	 * @method requestLayoutBeganCallback
	 * @since 0.4.0
	 */
	public func requestLayoutBeganCallback(_ callback: @escaping () -> Void) {
		self.layoutBeganCallbacks.append(callback)
	}

	/**
	 * Requests a callback that will be executed when the global layout finishes.
	 * @method requestLayoutEndedCallback
	 * @since 0.4.0
	 */
	public func requestLayoutEndedCallback(_ callback: @escaping () -> Void) {
		self.layoutEndedCallbacks.append(callback)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method dispatchLayoutBeganEvent
	 * @since 0.4.0
	 * @hidden
	 */
	internal func dispatchLayoutBeganEvent() {
		self.layoutBeganCallbacks.forEach { $0() }
		self.layoutBeganCallbacks.removeAll()
	}

	/**
	 * @method dispatchLayoutEndedEvent
	 * @since 0.4.0
	 * @hidden
	 */
	internal func dispatchLayoutEndedEvent() {
		self.layoutEndedCallbacks.forEach { $0() }
		self.layoutEndedCallbacks.removeAll()
	}
}

/**
 * @const layoutBeganCallback
 * @since 0.4.0
 * @hidden
 */
private let layoutBeganCallback: @convention(c) (DLLayoutRef?) -> Void = { ptr in
	if let layout = DLLayoutGetData(ptr).value as? Layout {
		layout.dispatchLayoutBeganEvent()
	}
}

/**
 * @const layoutEndedCallback
 * @since 0.4.0
 * @hidden
 */
private let layoutEndedCallback: @convention(c) (DLLayoutRef?) -> Void = { ptr in
	if let layout = DLLayoutGetData(ptr).value as? Layout {
		layout.dispatchLayoutEndedEvent()
	}
}
