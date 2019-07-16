/**
 * @class UpdateDisplayManager
 * @since 0.2.0
 */
public class UpdateDisplayManager: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * The main update display manager instance.
	 * @property main
	 * @sine 0.7.0
	 */
	public static let main: UpdateDisplayManager = UpdateDisplayManager()

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property scheduled
	 * @since 0.2.0
	 * @hidden
	 */
	private var scheduled: Bool = false

	/**
	 * @property callbacks
	 * @since 0.2.0
	 * @hidden
	 */
	private var callbacks: [WeakCallback] = []

	/**
	 * @property link
	 * @since 0.2.0
	 * @hidden
	 */
	private var link: CADisplayLink!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.2.0
	 */
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.2.0
	 */
	override public init() {

		super.init()

		self.link = CADisplayLink(target: self, selector: #selector(update))
		self.link.add(to: .current, forMode: .common)
		self.link.isPaused = true
	}

	/**
	 * Schedules an update display callback.
	 * @method schedule
	 * @since 0.2.0
	 */
	public func schedule(_ callback: UpdateDisplayCallback) {

		if (self.scheduled == false) {
			self.scheduled = true
			self.link.isPaused = false
		}

		self.callbacks.append(WeakCallback(ref: callback))
	}

	/**
	 * Dispatches update display callbacks.
	 * @method dispatch
	 * @since 0.2.0
	 */
	public func dispatch() {

		if (self.scheduled == false) {
			return
		}

		var index = 0

		/*
		 * A dispatch call might invalidate another view that needs its display
		 * updated on this pass therefore we must loop through this way. It might
		 * be a good idea to look for infinite loop in the future.
		 */

		while (index < self.callbacks.count) {

			if let callback = self.callbacks[index].ref {
				callback.performUpdate()
			}

			index += 1
		}

		self.callbacks = []
		self.scheduled = false
	}

	/**
	 * Resets the update display manager.
	 * @method reset
	 * @since 0.2.0
	 */
	public func reset() {
		self.callbacks = []
		self.scheduled = false
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	@objc private func update() {
		#if DEBUG
			let t1 = CFAbsoluteTimeGetCurrent()
		#endif

		self.dispatch()

		#if DEBUG
			let t2 = CFAbsoluteTimeGetCurrent()
			let tt = (t2 - t1) * 1000
			NSLog("UpdateDisplayManager - Update took \(tt) ms ")
		#endif

		self.link.isPaused = true
	}

	//--------------------------------------------------------------------------
	// MARK: Classes
	//--------------------------------------------------------------------------

	/**
	 * @class WeakCallback
	 * @since 0.6.0
	 * @hidden
	 */
	private class WeakCallback {

		/**
		 * @property ref
		 * @since 0.6.0
		 * @hidden
		 */
		private(set) public weak var ref: UpdateDisplayCallback?

		/**
		 * @constructor
		 * @since 0.6.0
		 * @hidden
		 */
		public init(ref: UpdateDisplayCallback?) {
			self.ref = ref
		}
	}
}
