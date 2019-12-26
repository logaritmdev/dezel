package ca.logaritm.dezel.view.transition

import android.view.animation.Interpolator
import ca.logaritm.dezel.application.ApplicationActivity
import ca.logaritm.dezel.extension.type.last
import ca.logaritm.dezel.view.Synchronizer

/**
 * @object TransitionManager
 * @since 0.7.0
 * @hidden
 */
public object TransitionManager {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property transition
	 * @since 0.7.0
	 */
	public val transition: Transition?
		get() = transitions.last

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method begin
	 * @since 0.7.0
	 */
	public fun begin(activity: ApplicationActivity, duration: Double, equation: Interpolator, delay: Double, callback: TransitionCallback) {

		val transition = Transition(activity)

		Synchronizer.main.execute()

		transition.callback = callback
		transition.duration = duration
		transition.equation = equation
		transition.delay = delay
		transition.begin()

		transitions.add(transition)
	}

	/**
	 * @method commit
	 * @since 0.7.0
	 */
	public fun commit() {

		val transition = transitions.last
		if (transition == null) {
			return
		}

		Synchronizer.main.execute()

		transition.commit()

		transitions.remove(transition)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property transitions
	 * @since 0.7.0
	 * @hidden
	 */
	private var transitions: MutableList<Transition> = mutableListOf()
}
