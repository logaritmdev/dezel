/**
 * @class TransitionGroup
 * @since 0.1.0
 * @hidden
 */
public final class TransitionGroup {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The application.
	 * @property application
	 * @since 0.2.0
	 */
	private(set) public var application: DezelApplicationController

	/**
	 * The transition's listeners.
	 * @property listeners
	 * @since 0.2.0
	 */
	private(set) public var listeners: [TransitionListener] = []

	/**
	 * The transition's completion callback.
	 * @property callback
	 * @since 0.1.0
	 */
	public var callback: Transition.TransitionCallback? {
		willSet(value) {
			CATransaction.setCompletionBlock(value)
		}
	}

	/**
	 * The transition's duration.
	 * @property duration
	 * @since 0.1.0
	 */
	public var duration: CFTimeInterval = 0.350 {
		willSet(value) {
			CATransaction.setAnimationDuration(value)
		}
	}

	/**
	 * The transition's equation.
	 * @property equation
	 * @since 0.1.0
	 */
	public var equation: CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default) {
		willSet(value) {
			CATransaction.setAnimationTimingFunction(value)
		}
	}

	/**
	 * The transition's delay.
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
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	public init(application: DezelApplicationController) {
		self.application = application
	}

	/**
	 * @method create
	 * @since 0.1.0
	 * @hidden
	 */
	public func create() {
		self.application.updateDisplayManager.dispatch()
		CATransaction.begin()
	}

	/**
	 * @method commit
	 * @since 0.1.0
	 * @hidden
	 */
	public func commit() {
		self.application.updateDisplayManager.dispatch()
		CATransaction.commit()
	}

	/**
	 * @method register
	 * @since 0.2.0
	 * @hidden
	 */
	public func register(_ listener: TransitionListener, animation: CABasicAnimation, for property: String) {
		let index = self.listeners.index { $0 === listener }
		if (index == nil) {
			self.listeners.append(listener)
		}
	}

	/**
	 * @method unregister
	 * @since 0.2.0
	 * @hidden
	 */
	public func unregister() {
		self.listeners.removeAll()
	}
}
