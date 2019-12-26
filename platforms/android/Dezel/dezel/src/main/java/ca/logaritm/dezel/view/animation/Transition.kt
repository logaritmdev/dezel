package ca.logaritm.dezel.view.transition

import android.animation.Animator
import android.animation.AnimatorSet
import android.view.animation.Interpolator
import android.view.animation.PathInterpolator
import ca.logaritm.dezel.application.ApplicationActivity
import ca.logaritm.dezel.modules.view.JavaScriptView
import ca.logaritm.dezel.util.reflect.PropertyAccessor

/**
 * @class Transition
 * @since 0.7.0
 */
public class Transition(val activity: ApplicationActivity): Animator.AnimatorListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property callback
	 * @since 0.7.0
	 */
	public var callback: TransitionCallback = null

	/**
	 * @property duration
	 * @since 0.7.0
	 */
	public var duration: Double = 0.350

	/**
	 * @property equation
	 * @since 0.7.0
	 */
	public var equation: Interpolator = PathInterpolator(0.25f, 0.10f, 0.25f, 0.10f)

	/**
	 * @property delay
	 * @since 0.7.0
	 */
	public var delay: Double = 0.0

	/**
	 * @property observers
	 * @since 0.2.0
	 * @hidden
	 */
	private var observers: MutableSet<Transitionable> = mutableSetOf()

	/**
	 * @property animator
	 * @since 0.7.0
	 * @hidden
	 */
	private val animator: AnimatorSet = AnimatorSet()

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.animator.addListener(this)
	}

	/**
	 * @method begin
	 * @since 0.7.0
	 */
	public fun begin() {

		this.forEachView {

			this.setup(it.wrapper)

			val content = it.content
			if (content is Transitionable) {
				this.setup(content)
			}
		}

		this.dispatchBeginCallback()
	}

	/**
	 * @method commit
	 * @since 0.7.0
	 */
	public fun commit() {

		this.forEachView {

			this.start(it.wrapper)

			val content = it.content
			if (content is Transitionable) {
				this.start(content)
			}
		}

		this.dispatchCommitCallback()

		this.values.clear()

		this.animator.duration = this.duration.toLong()
		this.animator.interpolator = this.equation
		this.animator.start()
	}

	//--------------------------------------------------------------------------
	// Mehods - Private API
	//--------------------------------------------------------------------------

	/**
	 * @property values
	 * @since 0.7.0
	 * @hidden
	 */
	private var values: MutableMap<Transitionable, MutableMap<String, Any?>> = mutableMapOf()

	/**
	 * @method setup
	 * @since 0.7.0
	 * @hidden
	 */
	private fun setup(view: Transitionable) {

		this.setup(view, "top")
		this.setup(view, "left")
		this.setup(view, "right")
		this.setup(view, "bottom")

		view.animatable.forEach {
			this.setup(view, it)
		}
	}

	/**
	 * @method setup
	 * @since 0.7.0
	 * @hidden
	 */
	private fun setup(view: Transitionable, property: String) {

		val animation = view.animations[property]
		if (animation == null) {
			this.setInitialValue(view, property, PropertyAccessor.get(view, property))
			return
		}

		/*
		 * The property was being animated. In this case we cancel the current
		 * animation and start another from its current point.
		 */

		animation.cancel()

		view.animations.remove(property)

		val value = animation.animatedValue
		if (value == null) {
			this.setInitialValue(view, property, PropertyAccessor.get(view, property))
		} else {
			this.setInitialValue(view, property, value)
		}
	}

	/**
	 * @method start
	 * @since 0.7.0
	 */
	private fun start(view: Transitionable) {

		this.start(view, "top")
		this.start(view, "left")
		this.start(view, "right")
		this.start(view, "bottom")

		view.animatable.forEach {
			this.start(view, it)
		}
	}

	/**
	 * @method start
	 * @since 0.7.0
	 * @hidden
	 */
	private fun start(view: Transitionable, property: String) {

		val initialValue = this.getInitialValue(view, property)
		val currentValue = PropertyAccessor.get(view, property)

		if (initialValue == currentValue) {
			return
		}

		if (initialValue == null ||
			currentValue == null) {
			return
		}

		val animation = view.animate(property, initialValue, currentValue)
		if (animation == null) {
			return
		}

		this.animator.playTogether(animation)
	}

	/**
	 * @method forEachView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun forEachView(each: (JavaScriptView) -> Unit) {

		val window = this.activity.application?.window
		if (window == null) {
			return
		}

		each(window)

		this.forEachViewOf(window, each)
	}

	/**
	 * @method forEachViewOf
	 * @since 0.7.0
	 * @hidden
	 */
	private fun forEachViewOf(root: JavaScriptView, each: (JavaScriptView) -> Unit) {
		root.children.forEach { view ->
			if (view.visible.boolean) {
				this.forEachViewOf(view, each)
			}
		}
	}

	/**
	 * @method setInitialValue
	 * @since 0.7.0
	 * @hidden
	 */
	private fun setInitialValue(view: Transitionable, property: String, value: Any?) {
		val values = this.values.getOrPut(view, { mutableMapOf() })
		values[property] = value
	}

	/**
	 * @method getInitialValue
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getInitialValue(view: Transitionable, property: String): Any? {
		return this.values.getOrPut(view, { mutableMapOf() }).get(property)
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 * @hidden
	 */
	internal fun reset() {
		this.observers.clear()
	}

	/**
	 * @method dispatchBeginCallback
	 * @since 0.7.0
	 * @hidden
	 */
	private fun dispatchBeginCallback() {
		this.observers.forEach {
			it.onBeginTransition()
		}
	}

	/**
	 * @method dispatchCommitCallback
	 * @since 0.7.0
	 * @hidden
	 */
	private fun dispatchCommitCallback() {
		this.observers.forEach {
			it.onCommitTransition()
		}
	}

	/**
	 * @method dispatchFinishCallback
	 * @since 0.7.0
	 * @hidden
	 */
	private fun dispatchFinishCallback() {
		this.observers.forEach {
			it.onFinishTransition()
		}
	}
	
	//--------------------------------------------------------------------------
	// Mehods - Animator Listener
	//--------------------------------------------------------------------------

	/**
	 * @method onAnimationStart
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onAnimationStart(animation: Animator?) {
	
	}

	/**
	 * @method onAnimationRepeat
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onAnimationRepeat(animation: Animator?) {

	}

	/**
	 * @method onAnimationEnd
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onAnimationEnd(animation: Animator?) {
		this.dispatchFinishCallback()
		this.callback?.invoke()
	}

	/**
	 * @method onAnimationCancel
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onAnimationCancel(animation: Animator?) {

	}
}

typealias TransitionCallback = (() -> (Unit))?