/**
 * Manages a display of nodes.
 * @class Display
 * @since 0.7.0
 */
open class Display {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the layout is invalid.
	 * @property invalid
	 * @since 0.7.0
	 */
	open var invalid: Bool {
		return DisplayIsInvalid(self.handle)
	}

	/**
	 * Whether the layout is resolving.
	 * @property resolving
	 * @since 0.7.0
	 */
	open var resolving: Bool {
		return DisplayIsResolving(self.handle)
	}

	/**
	 * The layout's root node.
	 * @property root
	 * @since 0.7.0
	 */
	open var window: LayoutNode? {
		willSet {
			DLLayoutSetRoot(self.handle, newValue?.handle)
		}
	}

	/**
	 * @property handle
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) public var handle: DisplayRef

	/**
	 * @property layoutBeganCallbacks
	 * @since 0.7.0
	 * @hidden
	 */
	private var layoutBeganCallbacks: [(() -> Void)] = []

	/**
	 * @property layoutEndedCallbacks
	 * @since 0.7.0
	 * @hidden
	 */
	private var layoutEndedCallbacks: [(() -> Void)] = []

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	internal init() {
		self.handle = DLLayoutCreate()
		DisplaySetLayoutBeganCallback(self.handle, layoutBeganCallback)
		DisplaySetLayoutEndedCallback(self.handle, layoutEndedCallback)
		DisplaySetData(self.handle, UnsafeMutableRawPointer(value: self))
	}

	/**
	 * @destructor
	 * @since 0.7.0
	 */
	deinit {
		DLLayoutGetData(self.handle).release()
		DLLayoutDelete(self.handle)
	}

	/**
	 * Assigns the display's viewport width.
	 * @property setViewportWidth
	 * @since 0.7.0
	 */
	open func setViewportWidth(_ value: CGFloat) {
		DLLayoutSetViewportWidth(self.handle, Double(value))
	}

	/**
	 * Assigns the display's viewport height.
	 * @method setViewportHeight
	 * @since 0.7.0
	 */
	open func setViewportHeight(_ value: CGFloat) {
		DisplaySetViewportHeight(self.handle, Double(value))
	}

	/**
	 * Assigns the display's scale.
	 * @property setScale
	 * @since 0.7.0
	 */
	open func setScale(_ value: CGFloat) {
		DisplaySetScale(self.handle, Double(value))
	}

	/**
	 * Assigns the display's window.
	 * @property setScale
	 * @since 0.7.0
	 */
	open func setWindow(_ window: DisplayNode) {
		DisplaySetWindow(self.handle, window.handle)
	}

	/**
	 * Requests a callback that will be executed when the global layout begins.
	 * @method requestLayoutBeganCallback
	 * @since 0.7.0
	 */
	open func requestLayoutBeganCallback(_ callback: @escaping () -> Void) {
		self.layoutBeganCallbacks.append(callback)
	}

	/**
	 * Requests a callback that will be executed when the global layout finishes.
	 * @method requestLayoutEndedCallback
	 * @since 0.7.0
	 */
	open func requestLayoutEndedCallback(_ callback: @escaping () -> Void) {
		self.layoutEndedCallbacks.append(callback)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method layoutBegan
	 * @since 0.7.0
	 * @hidden
	 */
	internal func layoutBegan() {
		self.dispatchLayoutBeganEvent()
	}

	/**
	 * @method layoutEnded
	 * @since 0.7.0
	 * @hidden
	 */
	internal func layoutEnded() {
		self.dispatchLayoutEndedEvent()
	}

	/**
	 * @method dispatchLayoutBeganEvent
	 * @since 0.7.0
	 * @hidden
	 */
	internal func dispatchLayoutBeganEvent() {
		self.layoutBeganCallbacks.forEach { $0() }
		self.layoutBeganCallbacks.removeAll()
	}

	/**
	 * @method dispatchLayoutEndedEvent
	 * @since 0.7.0
	 * @hidden
	 */
	internal func dispatchLayoutEndedEvent() {
		self.layoutEndedCallbacks.forEach { $0() }
		self.layoutEndedCallbacks.removeAll()
	}
}


/**
 * @const layoutBeganCallback
 * @since 0.7.0
 * @hidden
 */
private let layoutBeganCallback: @convention(c) (DisplayRef?) -> Void = { ptr in
	if let display = DisplayGetData(ptr).value as? Display {
		display.layoutBegan()
	}
}

/**
 * @const layoutEndedCallback
 * @since 0.7.0
 * @hidden
 */
private let layoutEndedCallback: @convention(c) (DisplayRef?) -> Void = { ptr in
	if let display = DisplayGetData(ptr).value as? Display {
		display.layoutEnded()
	}
}
