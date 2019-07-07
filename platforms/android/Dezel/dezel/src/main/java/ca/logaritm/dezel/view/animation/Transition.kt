package ca.logaritm.dezel.view.animation

import android.view.animation.Interpolator
import ca.logaritm.dezel.application.ApplicationActivity
import ca.logaritm.dezel.extension.last

/**
 * @object Transition
 * @since 0.1.0
 * @hidden
 */
public object Transition {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The transition that is being created.
	 * @property current
	 * @since 0.1.0
	 */
	public val current: TransitionGroup?
		get() = Transition.stack.last

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Creates a new transition.
	 * @method create
	 * @since 0.1.0
	 */
	public fun create(activity: ApplicationActivity, duration: Double, equation: Interpolator, delay: Double) {

		val transition = TransitionGroup(activity)
		transition.duration = duration
		transition.equation = equation
		transition.delay = delay
		transition.create()

		stack.add(transition)
	}

	/**
	 * Commits the transition.
	 * @method commit
	 * @since 0.1.0
	 */
	public fun commit(callback: TransitionCallback) {

		val transition = Transition.current
		if (transition == null) {
			return
		}

		transition.callback = callback
		transition.commit()

		stack.remove(transition)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property stack
	 * @since 0.1.0
	 * @hidden
	 */
	private var stack: MutableList<TransitionGroup> = mutableListOf()
}
