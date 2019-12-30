package ca.logaritm.dezel.view.animation.animator

import android.animation.Animator
import android.animation.ValueAnimator
import android.view.View as AndroidView

/**
 * @class OpacityAnimator
 * @since 0.1.0
 * @hidden
 */
internal class OpacityAnimator(view: AndroidView, startValue: Float, finalValue: Float) : ValueAnimator(), Animator.AnimatorListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.1.0
	 * @hidden
	 */
	private var view: AndroidView

	/**
	 * @property layerType
	 * @since 0.1.0
	 * @hidden
	 */
	private var layerType: Int

	/**
	 * @property startValue
	 * @since 0.1.0
	 * @hidden
	 */
	private var startValue: Float

	/**
	 * @property finalValue
	 * @since 0.1.0
	 * @hidden
	 */
	private var finalValue: Float

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init {

		this.view = view
		this.layerType = this.view.layerType
		this.startValue = startValue
		this.finalValue = finalValue

		this.setIntValues(1, 0)

		this.addUpdateListener {
			view.alpha = (finalValue - startValue) * this.animatedFraction + startValue
		}

		this.addListener(this)
	}

	//--------------------------------------------------------------------------
	// Methods - Animator JavaScriptViewListener
	//--------------------------------------------------------------------------

	/**
	 * @method onAnimationStart
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onAnimationStart(animation: Animator?) {
		this.view.setLayerType(AndroidView.LAYER_TYPE_HARDWARE, null)
	}

	/**
	 * @method onAnimationRepeat
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onAnimationRepeat(animation: Animator?) {

	}

	/**
	 * @method onAnimationEnd
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onAnimationEnd(animation: Animator?) {
		this.view.setLayerType(this.layerType, null)
	}

	/**
	 * @method onAnimationCancel
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onAnimationCancel(animation: Animator?) {
		this.view.setLayerType(this.layerType, null)
	}
}