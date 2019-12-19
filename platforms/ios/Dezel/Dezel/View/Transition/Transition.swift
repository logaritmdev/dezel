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
	 * @since 0.1.0
	 */
	public var callback: Callback? {
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
	public var delay: CFTimeInterval = 0

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method begin
	 * @since 0.1.0
	 */
	public func begin() {
		self.dispatchBeginCallback()
		CATransaction.begin()
	}

	/**
	 * @method commit
	 * @since 0.1.0
	 */
	public func commit() {
		self.dispatchCommitCallback()
		CATransaction.commit()
	}

	/**
	 * @method notify
	 * @since 0.2.0
	 */
	public func notify(_ layer: CALayer) {
		self.layers.add(layer)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @property layers
	 * @since 0.2.0
	 */
	private var layers: [CALayer] = []

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
		self.layers.removeAll()
	}

	/**
	 * @method dispatchBeginCallback
	 * @since 0.7.0
	 * @hidden
	 */
	private func dispatchBeginCallback() {
		self.layers.forEach {
			($0 as? Transitionable)?.didBeginTransition()
		}
	}

	/**
	 * @method dispatchCommitCallback
	 * @since 0.7.0
	 * @hidden
	 */
	private func dispatchCommitCallback() {
		self.layers.forEach {
			($0 as? Transitionable)?.didCommitTransition()
		}
	}

	/**
	 * @method dispatchFinishCallback
	 * @since 0.7.0
	 * @hidden
	 */
	private func dispatchFinishCallback() {
		self.layers.forEach {
			($0 as? Transitionable)?.didFinishTransition()
		}
	}
}
