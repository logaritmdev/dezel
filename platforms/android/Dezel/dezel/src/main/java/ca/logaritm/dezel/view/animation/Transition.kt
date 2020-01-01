package ca.logaritm.dezel.view.animation

import android.animation.Animator
import android.animation.AnimatorSet
import android.animation.ObjectAnimator
import android.animation.ValueAnimator
import android.util.Log
import android.view.View
import android.view.animation.Interpolator
import android.view.animation.PathInterpolator
import ca.logaritm.dezel.application.ApplicationActivity
import ca.logaritm.dezel.modules.view.JavaScriptView
import ca.logaritm.dezel.util.reflect.PropertyAccessor
import java.lang.Exception

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
	private var observers: MutableSet<Animatable> = mutableSetOf()

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

		this.forEachView { view ->
			this.captureStartValues(view.wrapper)
			this.captureStartValues(view.content)
		}

		this.dispatchBeginCallback()
	}

	/**
	 * @method commit
	 * @since 0.7.0
	 */
	public fun commit() {

		this.forEachView { view ->
			this.captureEndValues(view.wrapper)
			this.captureEndValues(view.content)
		}

		val animations = mutableListOf<Animator>()

		val views = mutableSetOf<View>()
		views.addAll(this.endValues.keys)
		views.addAll(this.startValues.keys)

		for (view in views) {
			this.animate(view, animations)
		}

		this.dispatchCommitCallback()

		this.startValues.clear()
		this.endValues.clear()

		this.animator.duration = this.duration.toLong() // TODO make duration's type long
		this.animator.interpolator = this.equation
		this.animator.playTogether(animations)
		this.animator.start()
	}

	//--------------------------------------------------------------------------
	// Methods - Internal API
	//--------------------------------------------------------------------------
	
	/**
	 * @method reset
	 * @since 0.7.0
	 * @hidden
	 */
	internal fun reset() {
		this.observers.clear()
	}
	
	//--------------------------------------------------------------------------
	// Methods - Private API
	//--------------------------------------------------------------------------

	/**
	 * @property startValues
	 * @since 0.7.0
	 * @hidden
	 */
	private var startValues: MutableMap<View, Values> = mutableMapOf()

	/**
	 * @property endValues
	 * @since 0.7.0
	 * @hidden
	 */
	private var endValues: MutableMap<View, Values> = mutableMapOf()

	/**
	 * @method captureStartValues
	 * @since 0.7.0
	 * @hidden
	 */
	private fun captureStartValues(view: View) {

		if (view is Animatable) {

			this.startValues[view] = Values()

			this.captureStartValue(view, "top")
			this.captureStartValue(view, "left")
			this.captureStartValue(view, "right")
			this.captureStartValue(view, "bottom")

			view.animatable.forEach { property ->
				this.captureStartValue(view, property)
			}
		}
	}

	/**
	 * @method captureEndValues
	 * @since 0.7.0
	 * @hidden
	 */
	private fun captureEndValues(view: View) {

		if (view is Animatable) {

			this.endValues[view] = Values()

			this.captureEndValue(view, "top")
			this.captureEndValue(view, "left")
			this.captureEndValue(view, "right")
			this.captureEndValue(view, "bottom")

			view.animatable.forEach { property ->
				this.captureEndValue(view, property)
			}
		}
	}

	/**
	 * @method captureStartValue
	 * @since 0.7.0
	 * @hidden
	 */
	private fun captureStartValue(view: View, property: String) {

		val group = this.startValues[view]
		if (group == null) {
			throw Exception("Unexpected error.")
		}

		group.values[property] = this.read(view, property)

		if (view is Animatable) {

			val animation = view.animations[property]
			if (animation == null) {
				return
			}

			/**
			 * This view is animated. Since this will start another animation
			 * we must remove it so the next animator can continue from
			 * where it currently is.
			 */

			animation.cancel()

			view.animations.remove(property)
		}
	}

	/**
	 * @method captureEndValue
	 * @since 0.7.0
	 * @hidden
	 */
	private fun captureEndValue(view: View, property: String) {

		val group = this.endValues[view]
		if (group == null) {
			throw Exception("Unexpected error.")
		}

		group.values[property] = this.read(view, property)
	}

	/**
	 * @method animate
	 * @since 0.7.0
	 * @hidden
	 */
	private fun animate(view: View, animations: MutableList<Animator>) {

		if (view is Animatable) {

			this.animate(view, "top", animations)
			this.animate(view, "left", animations)
			this.animate(view, "right", animations)
			this.animate(view, "bottom", animations)

			view.animatable.forEach { property ->
				this.animate(view, property, animations)
			}
		}
	}

	/**
	 * @method animate
	 * @since 0.7.0
	 * @hidden
	 */
	private fun animate(view: View, property: String, animations: MutableList<Animator>) {

		val s = this.getStartValue(view, property)
		val e = this.getEndValue(view, property)

		if (s == null ||
			e == null) {
			return
		}

		if (s == e) {
			return
		}

		if (view is Animatable) {

			var animation: ValueAnimator? = null

			if (property == "top" ||
				property == "left" ||
				property == "right" ||
				property == "bottom") {

				if (s is Int &&
					e is Int) {
					animation = ObjectAnimator.ofInt(view, property, s, e)
				}

			} else {
				animation = view.animate(property, s, e)
			}

			if (animation == null) {
				return
			}

			this.observers.add(view)

			view.animations[property] = animation

			animation.addListener(Listener(view, property))

			animations.add(animation)
		}
	}

	/**
	 * @method read
	 * @since 0.7.0
	 * @hidden
	 */
	private fun read(view: View, property: String): Any? {
		return PropertyAccessor.get(view, property)
	}

	/**
	 * @method getStartValue
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getStartValue(view: View, property: String): Any? {
		return this.startValues[view]!!.values[property]
	}

	/**
	 * @method getEndValue
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getEndValue(view: View, property: String): Any? {
		return this.endValues[view]!!.values[property]
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
	private fun forEachViewOf(node: JavaScriptView, each: (JavaScriptView) -> Unit) {
		node.children.forEach { view ->
			if (view.visible.boolean) {
				each.invoke(view)
				this.forEachViewOf(view, each)
			}
		}
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
	// Methods - Animator Listener
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

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class Values
	 * @since 0.7.0
	 * @hidden
	 */
	private class Values {

		/**
		 * @property values
		 * @since 0.7.0
		 * @hidden
		 */
		public var values: MutableMap<String, Any?> = mutableMapOf()
	}

	/**
	 * @class Values
	 * @since 0.7.0
	 * @hidden
	 */
	private class Listener(val view: Animatable, val property: String) : Animator.AnimatorListener {
		
		/**
		 * @method onAnimationCancel
		 * @since 0.7.0
		 * @hidden
		 */
		override fun onAnimationStart(animation: Animator?) {

		}

		/**
		 * @method onAnimationCancel
		 * @since 0.7.0
		 * @hidden
		 */
		override fun onAnimationRepeat(animation: Animator?) {

		}

		/**
		 * @method onAnimationCancel
		 * @since 0.7.0
		 * @hidden
		 */
		override fun onAnimationEnd(animation: Animator?) {
			this.view.animations.remove(this.property)
		}

		/**
		 * @method onAnimationCancel
		 * @since 0.7.0
		 * @hidden
		 */
		override fun onAnimationCancel(animation: Animator?) {

		}
	}
}

