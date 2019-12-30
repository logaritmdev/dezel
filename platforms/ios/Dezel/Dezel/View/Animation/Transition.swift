/**
 * @class TransitionAnimation
 * @since 0.7.0
 */
public final class Transition {

	//--------------------------------------------------------------------------
	// MARK: Types
	//--------------------------------------------------------------------------

	/**
	 * @type Callback
	 * @since 0.7.0
	 */
	public typealias Callback = (() -> Void)

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property callback
	 * @since 0.7.0
	 */
	public var callback: Callback? {
		willSet(value) {
			CATransaction.setCompletionBlock(value)
		}
	}

	/**
	 * @property duration
	 * @since 0.7.0
	 */
	public var duration: CFTimeInterval = 0.350 {
		willSet(value) {
			CATransaction.setAnimationDuration(value)
		}
	}

	/**
	 * @property equation
	 * @since 0.7.0
	 */
	public var equation: CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default) {
		willSet(value) {
			CATransaction.setAnimationTimingFunction(value)
		}
	}

	/**
	 * @property delay
	 * @since 0.7.0
	 */
	public var delay: CFTimeInterval = 0

	/**
	 * @property observers
	 * @since 0.7.0
	 */
	private var observers: [CALayer] = []

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method begin
	 * @since 0.7.0
	 */
	public func begin() {
		self.dispatchBeginCallback()
		CATransaction.begin()
	}

	/**
	 * @method commit
	 * @since 0.7.0
	 */
	public func commit() {
		self.dispatchCommitCallback()
		CATransaction.commit()
	}

	/**
	 * @method notify
	 * @since 0.7.0
	 */
	public func notify(_ layer: CALayer) {
		self.observers.add(layer)
	}

	//--------------------------------------------------------------------------
	// MARK: Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method finished
	 * @since 0.7.0
	 * @hidden
	 */
	internal func finished() {
		self.dispatchFinishCallback()
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 * @hidden
	 */
	internal func reset() {
		self.observers.removeAll()
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method dispatchBeginCallback
	 * @since 0.7.0
	 * @hidden
	 */
	private func dispatchBeginCallback() {
		self.observers.forEach {
			($0 as? Animatable)?.didBeginTransition(layer: $0)
		}
	}

	/**
	 * @method dispatchCommitCallback
	 * @since 0.7.0
	 * @hidden
	 */
	private func dispatchCommitCallback() {
		self.observers.forEach {
			($0 as? Animatable)?.didCommitTransition(layer: $0)
		}
	}

	/**
	 * @method dispatchFinishCallback
	 * @since 0.7.0
	 * @hidden
	 */
	private func dispatchFinishCallback() {
		self.observers.forEach {
			($0 as? Animatable)?.didFinishTransition(layer: $0)
		}
	}
}
