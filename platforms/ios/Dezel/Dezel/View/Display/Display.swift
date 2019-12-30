/**
 * @class Display
 * @since 0.7.0
 */
public class Display {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property window
	 * @since 0.7.0
	 */
	public var window: DisplayNode? {
		willSet {
			DisplaySetWindow(self.handle, newValue?.handle)
		}
	}

	/**
	 * @property scale
	 * @since 0.7.0
	 */
	public var scale: Double = 1 {
		willSet {
			DisplaySetScale(self.handle, newValue)
		}
	}

	/**
	 * @property viewportWidth
	 * @since 0.7.0
	 */
	public var viewportWidth: Double = 0 {
		willSet {
			DisplaySetViewportWidth(self.handle, newValue)
		}
	}

	/**
	 * @property viewportHeight
	 * @since 0.7.0
	 */
	public var viewportHeight: Double = 0 {
		willSet {
			DisplaySetViewportHeight(self.handle, newValue)
		}
	}

	/**
	 * @property stylesheet
	 * @since 0.7.0
	 */
	public var stylesheet: Stylesheet? {
		willSet {
			DisplaySetStylesheet(self.handle, newValue?.handle)
		}
	}

	/**
	 * @property invalid
	 * @since 0.7.0
	 */
	public var invalid: Bool {
		return DisplayIsInvalid(self.handle)
	}

	/**
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
	 * @property prepareCallbacks
	 * @since 0.7.0
	 * @hidden
	 */
	private var prepareCallbacks: [(() -> Void)] = []

	/**
	 * @property resolveCallbacks
	 * @since 0.7.0
	 * @hidden
	 */
	private var resolveCallbacks: [(() -> Void)] = []

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	internal init() {
		self.handle = DisplayCreate()
		DisplaySetPrepareCallback(self.handle, displayPrepareCallback)
		DisplaySetResolveCallback(self.handle, displayResolveCallback)
		DisplaySetData(self.handle, UnsafeMutableRawPointer(value: self))
	}

	/**
	 * @destructor
	 * @since 0.7.0
	 */
	deinit {
		DisplayGetData(self.handle).release()
		DisplaySetData(self.handle, nil)
		DisplayDelete(self.handle)
	}

	/**
	 * @method resolve
	 * @since 0.7.0
	 */
	public func resolve() {
		DisplayResolve(self.handle)
	}

	/**
	 * @method registerPrepareCallback
	 * @since 0.7.0
	 */
	public func registerPrepareCallback(_ callback: @escaping () -> Void) {
		self.prepareCallbacks.append(callback)
	}

	/**
	 * @method registerResolveCallback
	 * @since 0.7.0
	 */
	public func registerResolveCallback(_ callback: @escaping () -> Void) {
		self.resolveCallbacks.append(callback)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method didPrepare
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didPrepare() {
		self.dispatchPrepareCallback()
	}

	/**
	 * @method didResolve
	 * @since 0.7.0
	 * @hidden
	 */
	internal func didResolve() {
		self.dispatchResolveCallback()
	}

	/**
	 * @method dispatchLayoutBeganEvent
	 * @since 0.7.0
	 * @hidden
	 */
	internal func dispatchPrepareCallback() {
		self.prepareCallbacks.forEach { $0() }
		self.prepareCallbacks.removeAll()
	}

	/**
	 * @method dispatchLayoutEndedEvent
	 * @since 0.7.0
	 * @hidden
	 */
	internal func dispatchResolveCallback() {
		self.resolveCallbacks.forEach { $0() }
		self.resolveCallbacks.removeAll()
	}
}

/**
 * @function displayPrepareCallback
 * @since 0.7.0
 * @hidden
 */
private let displayPrepareCallback: @convention(c) (DisplayRef?) -> Void = { ptr in
	if let display = DisplayGetData(ptr).value as? Display {
		display.didPrepare()
	}
}

/**
 * @function displayResolveCallback
 * @since 0.7.0
 * @hidden
 */
private let displayResolveCallback: @convention(c) (DisplayRef?) -> Void = { ptr in
	if let display = DisplayGetData(ptr).value as? Display {
		display.didResolve()
	}
}
