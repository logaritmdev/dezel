package ca.logaritm.dezel.view.animation

import android.animation.ValueAnimator

/**
 * The interface for transitionable elements.
 * @interface TransitionListener
 * @since 0.2.0
 */
public interface TransitionListener {

	/**
	 * Called when a transition animation is created for the specified property.
	 * @method onBeforeTransitionBegin
	 * @since 0.2.0
	 */
	fun onBeforeTransitionBegin(animator: ValueAnimator, property: String)

	/**
	 * Called when the transition animation begins.
	 * @method onTransitionBegin
	 * @since 0.2.0
	 */
	fun onTransitionBegin()

	/**
	 * Called when the transition animation finishes.
	 * @method onTransitionFinish
	 * @since 0.2.0
	 */
	fun onTransitionFinish()
}