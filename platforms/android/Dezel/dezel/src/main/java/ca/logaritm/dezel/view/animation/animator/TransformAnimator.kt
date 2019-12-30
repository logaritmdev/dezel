package ca.logaritm.dezel.view.animation.animator

import android.animation.Animator
import android.animation.ValueAnimator
import ca.logaritm.dezel.view.WrapperView
import ca.logaritm.dezel.view.graphic.Transform
import android.view.View as AndroidView

/**
 * @class TransformAnimator
 * @since 0.1.0
 * @hidden
 */
internal class TransformAnimator(view: WrapperView, startValue: Transform, finalValue: Transform) : ValueAnimator(), Animator.AnimatorListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.1.0
	 * @hidden
	 */
	private var view: WrapperView

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
	private var startValue: Transform

	/**
	 * @property finalValue
	 * @since 0.1.0
	 * @hidden
	 */
	private var finalValue: Transform

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
		this.layerType = view.layerType
		this.startValue = startValue
		this.finalValue = finalValue

		this.setIntValues(1, 0)

		this.addUpdateListener {

			val transform = Transform()

			transform.translationX = (finalValue.translationX - startValue.translationX) * this.animatedFraction + startValue.translationX
			transform.translationY = (finalValue.translationY - startValue.translationY) * this.animatedFraction + startValue.translationY
			transform.translationZ = (finalValue.translationZ - startValue.translationZ) * this.animatedFraction + startValue.translationZ

			transform.rotationX = (finalValue.rotationX - startValue.rotationX) * this.animatedFraction + startValue.rotationX
			transform.rotationY = (finalValue.rotationY - startValue.rotationY) * this.animatedFraction + startValue.rotationY
			transform.rotationZ = (finalValue.rotationZ - startValue.rotationZ) * this.animatedFraction + startValue.rotationZ

			transform.scaleX = (finalValue.scaleX - startValue.scaleX) * this.animatedFraction + startValue.scaleX
			transform.scaleY = (finalValue.scaleY - startValue.scaleY) * this.animatedFraction + startValue.scaleY
			transform.scaleZ = (finalValue.scaleZ - startValue.scaleZ) * this.animatedFraction + startValue.scaleZ

			view.transform = transform
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