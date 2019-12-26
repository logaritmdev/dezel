package ca.logaritm.dezel.view.animation

import android.animation.Animator
import android.animation.ValueAnimator

public interface Transitionable {

	/**
	 * @property animatable
	 * @since 0.7.0
	 */
	val animatable: List<String>

	/**
	 * @property animations
	 * @since 0.7.0
	 */
	var animations: MutableMap<String, ValueAnimator>

	/**
	 * @method willAnimate
	 * @since 0.7.0
	 */
	fun animate(property: String, initialValue: Any, currentValue: Any): Animator?

	/**
	 * @method onBeforeAnimate
	 * @since 0.7.0
	 */
	fun onBeforeAnimate(property: String)

	/**
	 * @method onBeginTransition
	 * @since 0.7.0
	 */
	fun onBeginTransition()

	/**
	 * @method onCommitTransition
	 * @since 0.7.0
	 */
	fun onCommitTransition()

	/**
	 * @method onFinishTransition
	 * @since 0.7.0
	 */
	fun onFinishTransition()
	
}