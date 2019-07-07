/**
 * Manages transitions animations.
 * @class Transition
 * @since 0.1.0
 */
public final class Transition {

	public typealias TransitionCallback = (() -> Void)

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * The transition that is being created.
	 * @property current
	 * @since 0.1.0
	 */
	public static var current: TransitionGroup? {
		return stack.last
	}

	/**
	 * Creates a new transition.
	 * @method create
	 * @since 0.1.0
	 */
	public static func create(application: ApplicationController, duration: CFTimeInterval, equation: CAMediaTimingFunction, delay: CFTimeInterval, callback: @escaping TransitionCallback) {

		let transition = TransitionGroup(application: application)

		transition.create()
		transition.delay = delay
		transition.duration = duration
		transition.equation = equation
		transition.callback = {
			transition.finish()
			transition.callback = nil
			callback()
		}

		Transition.stack.append(transition)
	}

	/**
	 * Commits the transition.
	 * @method commit
	 * @since 0.1.0
	 */
	public static func commit() {

		guard let transition = Transition.current else {
			return
		}

		transition.commit()

		Transition.stack.removeLast()
	}

	/**
	 * Convenience method to create core animation action for a given layer.
	 * @method action
	 * @since 0.1.0
	 */
	public static func action(for layer: CALayer, key: String) -> CAAction? {

		if let transition = Transition.current {

			var current = layer.presentation()
			if (current == nil || layer.animation(forKey: key) == nil) {
				current = layer
			}

			let animation = CABasicAnimation(keyPath: key)

			switch (key) {

				case "bounds":
					animation.fromValue = NSValue(cgRect: current!.bounds)
				case "position":
					animation.fromValue = NSValue(cgPoint: current!.position)
				case "transform":
					animation.fromValue = NSValue(caTransform3D: current!.transform)
				case "opacity":
					animation.fromValue = current!.opacity

				default:
					break
			}

			if (animation.fromValue != nil) {

				if (transition.delay > 0) {
					animation.beginTime = CACurrentMediaTime() + transition.delay
					animation.fillMode = CAMediaTimingFillMode.both
				}

				if let listener = layer.listener as? TransitionListener {
					if (listener.shouldBeginTransitionAnimation(animation: animation, for: key, of: layer)) {
						listener.willBeginTransitionAnimation(animation: animation, for: key, of: layer)
						transition.register(listener)
					} else {
						return NSNull()
					}
				}

				return animation
			}
		}

		return NSNull()
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @property stack
	 * @since 0.1.0
	 * @hidden
	 */
	private static var stack: [TransitionGroup] = []
}
