/**
 * @class TransitionGroup
 * @since 0.1.0
 */
public final class TransitionGroup {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property listeners
	 * @since 0.2.0
	 */
	private(set) public var listeners: [TransitionListener] = []

	/**
	 * @property callback
	 * @since 0.1.0
	 */
	public var callback: Transition.Callback? {
		willSet(value) {
			CATransaction.setCompletionBlock(value)
		}
	}

	/**
	 * @property duration
	 * @since 0.1.0
	 */
	public var duration: CFTimeInterval = 0.350 {
		willSet(value) {
			CATransaction.setAnimationDuration(value)
		}
	}

	/**
	 * @property equation
	 * @since 0.1.0
	 */
	public var equation: CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default) {
		willSet(value) {
			CATransaction.setAnimationTimingFunction(value)
		}
	}

	/**
	 * @property delay
	 * @since 0.1.0
	 */
	public var delay: CFTimeInterval = 0 {
		willSet(value) {
			self.delay = value
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method create
	 * @since 0.1.0
	 * @hidden
	 */
	public func create() {
		Synchronizer.main.execute()
		CATransaction.begin()
	}

	/**
	 * @method commit
	 * @since 0.1.0
	 * @hidden
	 */
	public func commit() {
		Synchronizer.main.execute()
		CATransaction.commit()
	}

	/**
	 * @method register
	 * @since 0.2.0
	 * @hidden
	 */
	public func register(_ listener: TransitionListener) {
		self.listeners.register(listener)
	}

	/**
	 * @method finish
	 * @since 0.2.0
	 * @hidden
	 */
	public func finish() {
		self.listeners.dispatchFinishEvent()
		self.listeners.removeAll()
	}
}
