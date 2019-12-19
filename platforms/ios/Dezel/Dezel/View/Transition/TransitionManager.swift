/**
 * @class TransitionManager
 * @since 0.7.0
 */
public final class TransitionManager {

	//--------------------------------------------------------------------------
	// MARK: Types
	//--------------------------------------------------------------------------

	/**
	 * @type Callback
	 * @since 0.7.0
	 */
	public typealias Callback = (() -> Void)

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * @property transition
	 * @since 0.7.0
	 */
	public static var transition: Transition? {
		return transitions.last
	}

	/**
	 * @method begin
	 * @since 0.7.0
	 */
	public static func begin(duration: CFTimeInterval, equation: CAMediaTimingFunction, delay: CFTimeInterval, callback: @escaping Callback) {

		let transition = Transition()

		Synchronizer.main.execute()

		transition.begin()
		transition.delay = delay
		transition.duration = duration
		transition.equation = equation
		transition.callback = {
			transition.callback = nil
			transition.finished()
			transition.reset()
			callback()
		}

		TransitionManager.transitions.append(transition)
	}

	/**
	 * @method commit
	 * @since 0.7.0
	 */
	public static func commit() {

		guard let transition = TransitionManager.transition else {
			return
		}

		Synchronizer.main.execute()

		transition.commit()

		TransitionManager.transitions.removeLast()
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @property transitions
	 * @since 0.7.0
	 * @hidden
	 */
	private static var transitions: [Transition] = []
}
