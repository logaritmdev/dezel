/**
 * Manages a display of nodes.
 * @class Display
 * @since 0.7.0
 */
public class Display {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The display's window
	 * @property window
	 * @since 0.7.0
	 */
	public var window: DisplayNode? {
		willSet {
			DisplaySetWindow(self.handle, newValue?.handle)
		}
	}

	/**
	 * The display's viewport width.
	 * @property viewportWidth
	 * @since 0.7.0
	 */
	public var viewportWidth: Double = 0 {
		willSet {
			DisplaySetViewportWidth(self.handle, newValue)
		}
	}

	/**
	 * The display's viewport height.
	 * @property viewportHeight
	 * @since 0.7.0
	 */
	public var viewportHeight: Double = 0 {
		willSet {
			DisplaySetViewportHeight(self.handle, newValue)
		}
	}

	/**
	 * The display's scale.
	 * @property scale
	 * @since 0.7.0
	 */
	public var scale: Double = 1 {
		willSet {
			DisplaySetScale(self.handle, newValue)
		}
	}

	/**
	 * Whether the layout is invalid.
	 * @property invalid
	 * @since 0.7.0
	 */
	public var invalid: Bool {
		return DisplayIsInvalid(self.handle)
	}

	/**
	 * Whether the layout is resolving.
	 * @property resolving
	 * @since 0.7.0
	 */
	public var resolving: Bool {
		return DisplayIsResolving(self.handle)
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
		self.handle = DisplayCreate()
		DisplaySetInvalidateCallback(self.handle, displayInvalidateCallback)
		DisplaySetResolveCallback(self.handle, displayResolveCallback)
		DisplaySetData(self.handle, UnsafeMutableRawPointer(value: self))
	}

	/**
	 * @destructor
	 * @since 0.7.0
	 */
	deinit {
		DisplayGetData(self.handle).release()
		DisplayDelete(self.handle)
	}

	public func setVariable(_ name: String, value: String) {
	
	}

	/**
	 * Requests a callback that will be executed when the global layout begins.
	 * @method requestLayoutBeganCallback
	 * @since 0.7.0
	 */
	public func requestLayoutBeganCallback(_ callback: @escaping () -> Void) {
		self.layoutBeganCallbacks.append(callback)
	}

	/**
	 * Requests a callback that will be executed when the global layout finishes.
	 * @method requestLayoutEndedCallback
	 * @since 0.7.0
	 */
	public func requestLayoutEndedCallback(_ callback: @escaping () -> Void) {
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
 * @const displayInvalidateCallback
 * @since 0.7.0
 * @hidden
 */
private let displayInvalidateCallback: @convention(c) (DisplayRef?) -> Void = { ptr in
//	if let display = DisplayGetData(ptr).value as? Display {
//		display.layoutBegan()
//	}
}

/**
 * @const layoutEndedCallback
 * @since 0.7.0
 * @hidden
 */
private let displayResolveCallback: @convention(c) (DisplayRef?) -> Void = { ptr in
//	if let display = DisplayGetData(ptr).value as? Display {
//		display.layoutEnded()
//	}
}
