package ca.logaritm.dezel.view.animation

import android.animation.Animator
import android.animation.AnimatorSet
import android.animation.ObjectAnimator
import android.view.animation.Interpolator
import android.view.animation.PathInterpolator
import ca.logaritm.dezel.application.ApplicationActivity
import ca.logaritm.dezel.modules.view.ImageView
import ca.logaritm.dezel.modules.view.TextView
import ca.logaritm.dezel.modules.view.View
import ca.logaritm.dezel.view.*
import ca.logaritm.dezel.view.graphic.Transform
import android.view.View as AndroidView
import android.view.Window as AndroidWindow

/**
 * @class TransitionGroup
 * @since 0.1.0
 * @hidden
 */
public class TransitionGroup(val activity: ApplicationActivity): Animator.AnimatorListener {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		const val PROP_WRAPPER_TOP = "dezel.WrapperView.top"
		const val PROP_WRAPPER_LEFT = "dezel.WrapperView.left"
		const val PROP_WRAPPER_RIGHT = "dezel.WrapperView.right"
		const val PROP_WRAPPER_BOTTOM = "dezel.WrapperView.bottom"
		const val PROP_WRAPPER_BACKGROUND_COLOR = "dezel.WrapperView.backgroundColor"
		const val PROP_WRAPPER_BORDER_TOP_WIDTH = "dezel.WrapperView.borderTopWidth"
		const val PROP_WRAPPER_BORDER_LEFT_WIDTH = "dezel.WrapperView.borderLeftWidth"
		const val PROP_WRAPPER_BORDER_RIGHT_WIDTH = "dezel.WrapperView.borderRightWidth"
		const val PROP_WRAPPER_BORDER_BOTTOM_WIDTH = "dezel.WrapperView.borderBottomWidth"
		const val PROP_WRAPPER_BORDER_TOP_COLOR = "dezel.WrapperView.borderTopColor"
		const val PROP_WRAPPER_BORDER_LEFT_COLOR = "dezel.WrapperView.borderLeftColor"
		const val PROP_WRAPPER_BORDER_RIGHT_COLOR = "dezel.WrapperView.borderRightColor"
		const val PROP_WRAPPER_BORDER_BOTTOM_COLOR = "dezel.WrapperView.borderBottomColor"
		const val PROP_WRAPPER_BORDER_TOP_LEFT_RADIUS = "dezel.WrapperView.borderTopLeftRadius"
		const val PROP_WRAPPER_BORDER_TOP_RIGHT_RADIUS = "dezel.WrapperView.borderTopRightRadius"
		const val PROP_WRAPPER_BORDER_BOTTOM_LEFT_RADIUS = "dezel.WrapperView.borderBottomLeftRadius"
		const val PROP_WRAPPER_BORDER_BOTTOM_RIGHT_RADIUS = "dezel.WrapperView.borderBottomRightRadius"
		const val PROP_WRAPPER_SHADOW_BLUR = "dezel.WrapperView.shadowBlur"
		const val PROP_WRAPPER_SHADOW_COLOR = "dezel.WrapperView.shadowColor"
		const val PROP_WRAPPER_SHADOW_OFFSET_TOP = "dezel.WrapperView.shadowOffsetTop"
		const val PROP_WRAPPER_SHADOW_OFFSET_LEFT = "dezel.WrapperView.shadowOffsetLeft"
		const val PROP_WRAPPER_ALPHA = "dezel.WrapperView.alpha"
		const val PROP_WRAPPER_TRANSFORM = "dezel.WrapperView.transform"
		const val PROP_SCROLL_TOP = "dezel.WrapperView.scrollTop"
		const val PROP_SCROLL_LEFT = "dezel.WrapperView.scrollLeft"

		const val PROP_CONTENT_TOP = "dezel.ContentView.top"
		const val PROP_CONTENT_LEFT = "dezel.ContentView.left"
		const val PROP_CONTENT_RIGHT = "dezel.ContentView.right"
		const val PROP_CONTENT_BOTTOM = "dezel.ContentView.bottom"
		const val PROP_CONTENT_TRANSLATION_X = "dezel.ContentView.translationX"
		const val PROP_CONTENT_TRANSLATION_Y = "dezel.ContentView.translationY"
		const val PROP_CONTENT_REAL_SCROLL_X = "dezel.ContentView.realScrollX"
		const val PROP_CONTENT_REAL_SCROLL_Y = "dezel.ContentView.realScrollY"

		const val PROP_FONT_SIZE = "dezel.TextView.fontSize"
		const val PROP_TEXT_COLOR = "dezel.TextView.textColor"
		const val PROP_TEXT_KERNING = "dezel.TextView.textKerning"
		const val PROP_TEXT_LEADING = "dezel.TextView.textLeading"
		const val PROP_TEXT_BASELINE = "dezel.TextView.textBaseline"

		const val PROP_IMAGE_TOP = "dezel.ImageView.imageTop"
		const val PROP_IMAGE_LEFT = "dezel.ImageView.imageLeft"
		const val PROP_IMAGE_WIDTH = "dezel.ImageView.imageWidth"
		const val PROP_IMAGE_HEIGHT = "dezel.ImageView.imageHeight"
		const val PROP_IMAGE_TINT = "dezel.ImageView.imageTint"
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property callback
	 * @since 0.1.0
	 * @hidden
	 */
	public var callback: TransitionCallback = null

	/**
	 * @property duration
	 * @since 0.1.0
	 * @hidden
	 */
	public var duration: Double = 0.350

	/**
	 * @property equation
	 * @since 0.1.0
	 * @hidden
	 */
	public var equation: Interpolator = PathInterpolator(0.25f, 0.10f, 0.25f, 0.10f)

	/**
	 * @property delay
	 * @since 0.1.0
	 * @hidden
	 */
	public var delay: Double = 0.0

	/**
	 * @property animator
	 * @since 0.1.0
	 * @hidden
	 */
	private val animator: AnimatorSet = AnimatorSet()

	/**
	 * @property startValues
	 * @since 0.1.0
	 * @hidden
	 */
	private var startValues: MutableMap<View, TransitionValues> = mutableMapOf()

	/**
	 * @property endValues
	 * @since 0.1.0
	 * @hidden
	 */
	private var endValues: MutableMap<View, TransitionValues> = mutableMapOf()

	/**
	 * @property listeners
	 * @since 0.2.0
	 * @hidden
	 */
	private var listeners: MutableSet<TransitionListener> = mutableSetOf()

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {
		this.animator.addListener(this)
	}

	/**
	 * @method create
	 * @since 0.1.0
	 * @hidden
	 */
	public fun create() {

		this.activity.updateDisplayManager.dispatch()

		this.forEachView {
			this.captureStartValues(it)
		}
	}

	/**
	 * @method commit
	 * @since 0.1.0
	 * @hidden
	 */
	public fun commit() {

		this.activity.updateDisplayManager.dispatch()

		this.forEachView {
			this.captureEndValues(it)
		}

		val startValueViews = this.startValues.keys
		val endValueViews = this.endValues.keys

		val keys = mutableSetOf<View>()
		keys.addAll(startValueViews)
		keys.addAll(endValueViews)

		val animations = mutableListOf<Animator>()

		for (key in keys) {

			val startValues = this.startValues[key]
			val endValues = this.endValues[key]

			val animators = this.createAnimators(startValues, endValues)
			if (animators == null) {
				continue
			}

			animations.addAll(animators)
		}

		this.startValues.clear()
		this.endValues.clear()

		this.animator.duration = this.duration.toLong()
		this.animator.interpolator = this.equation
		this.animator.playTogether(animations)
		this.animator.start()
	}

	/**
	 * @method captureStartValues
	 * @since 0.1.0
	 * @hidden
	 */
	private fun captureStartValues(view: View) {
		val values = TransitionValues(view)
		this.capture(values)
		this.startValues[view] = values
	}

	/**
	 * @method captureEndValues
	 * @since 0.1.0
	 * @hidden
	 */
	private fun captureEndValues(view: View) {
		val values = TransitionValues(view)
		this.capture(values)
		this.endValues[view] = values
	}

	/**
	 * @method capture
	 * @since 0.1.0
	 * @hidden
	 */
	private fun capture(transitionValues: TransitionValues) {

		val view = transitionValues.view

		val wrapper = view.wrapper
		val content = view.content

		if (wrapper.measured) {
			transitionValues.values[PROP_WRAPPER_TOP] = wrapper.top
			transitionValues.values[PROP_WRAPPER_LEFT] = wrapper.left
			transitionValues.values[PROP_WRAPPER_RIGHT] = wrapper.right
			transitionValues.values[PROP_WRAPPER_BOTTOM] = wrapper.bottom
		}

		transitionValues.values[PROP_WRAPPER_BACKGROUND_COLOR] = wrapper.backgroundKolor
		transitionValues.values[PROP_WRAPPER_BORDER_TOP_WIDTH] = wrapper.borderTopWidth
		transitionValues.values[PROP_WRAPPER_BORDER_LEFT_WIDTH] = wrapper.borderLeftWidth
		transitionValues.values[PROP_WRAPPER_BORDER_RIGHT_WIDTH] = wrapper.borderRightWidth
		transitionValues.values[PROP_WRAPPER_BORDER_BOTTOM_WIDTH] = wrapper.borderBottomWidth
		transitionValues.values[PROP_WRAPPER_BORDER_TOP_COLOR] = wrapper.borderTopColor
		transitionValues.values[PROP_WRAPPER_BORDER_LEFT_COLOR] = wrapper.borderLeftColor
		transitionValues.values[PROP_WRAPPER_BORDER_RIGHT_COLOR] = wrapper.borderRightColor
		transitionValues.values[PROP_WRAPPER_BORDER_BOTTOM_COLOR] = wrapper.borderBottomColor
		transitionValues.values[PROP_WRAPPER_BORDER_TOP_LEFT_RADIUS] = wrapper.borderTopLeftRadius
		transitionValues.values[PROP_WRAPPER_BORDER_TOP_RIGHT_RADIUS] = wrapper.borderTopRightRadius
		transitionValues.values[PROP_WRAPPER_BORDER_BOTTOM_LEFT_RADIUS] = wrapper.borderBottomLeftRadius
		transitionValues.values[PROP_WRAPPER_BORDER_BOTTOM_RIGHT_RADIUS] = wrapper.borderBottomRightRadius
		transitionValues.values[PROP_WRAPPER_SHADOW_BLUR] = wrapper.shadowBlur
		transitionValues.values[PROP_WRAPPER_SHADOW_COLOR] = wrapper.shadowColor
		transitionValues.values[PROP_WRAPPER_SHADOW_OFFSET_TOP] = wrapper.shadowOffsetTop
		transitionValues.values[PROP_WRAPPER_SHADOW_OFFSET_LEFT] = wrapper.shadowOffsetLeft
		transitionValues.values[PROP_WRAPPER_ALPHA] = wrapper.alpha
		transitionValues.values[PROP_WRAPPER_TRANSFORM] = wrapper.transform

		if (wrapper.measured) {
			transitionValues.values[PROP_CONTENT_TOP] = content.top
			transitionValues.values[PROP_CONTENT_LEFT] = content.left
			transitionValues.values[PROP_CONTENT_RIGHT] = content.right
			transitionValues.values[PROP_CONTENT_BOTTOM] = content.bottom
		}

		transitionValues.values[PROP_CONTENT_TRANSLATION_X] = content.translationX
		transitionValues.values[PROP_CONTENT_TRANSLATION_Y] = content.translationY

//		transitionValues.values[PROP_ORIGIN_X] = wrapper.originX
//		transitionValues.values[PROP_ORIGIN_Y] = wrapper.originY
//		transitionValues.values[PROP_ORIGIN_Z] = wrapper.originZ

		if (content is ContentView) {
			transitionValues.values[PROP_CONTENT_REAL_SCROLL_X] = content.realScrollX
			transitionValues.values[PROP_CONTENT_REAL_SCROLL_Y] = content.realScrollY
		}

		if (content is ContentTextView) {
			transitionValues.values[PROP_TEXT_COLOR] = content.textColor
			transitionValues.values[PROP_TEXT_KERNING] = content.textKerning
			transitionValues.values[PROP_TEXT_LEADING] = content.textLeading
			transitionValues.values[PROP_TEXT_BASELINE] = content.textBaseline
			transitionValues.values[PROP_FONT_SIZE] = content.fontSize
		}

		if (content is ContentImageView) {
			transitionValues.values[PROP_IMAGE_TOP] = content.imageTop
			transitionValues.values[PROP_IMAGE_LEFT] = content.imageLeft
			transitionValues.values[PROP_IMAGE_WIDTH] = content.imageWidth
			transitionValues.values[PROP_IMAGE_HEIGHT] = content.imageHeight
			transitionValues.values[PROP_IMAGE_TINT] = content.imageTint
		}

		if (content is Scrollable) {
			transitionValues.values[PROP_SCROLL_TOP] = content.scrollTop
			transitionValues.values[PROP_SCROLL_LEFT] = content.scrollLeft
		}
	}

	/**
	 * @method createAnimators
	 * @since 0.1.0
	 * @hidden
	 */
	private fun createAnimators(startValues: TransitionValues?, endValues: TransitionValues?): List<Animator>? {

		if (startValues == null || endValues == null) {
			return null
		}

		val animators = mutableListOf<Animator>()

		val view = startValues.view

		if (view.wrapper.measured) {
			this.addIntAnimator(view.wrapper, PROP_WRAPPER_TOP, "top", startValues, endValues, animators)
			this.addIntAnimator(view.wrapper, PROP_WRAPPER_LEFT, "left", startValues, endValues, animators)
			this.addIntAnimator(view.wrapper, PROP_WRAPPER_RIGHT, "right", startValues, endValues, animators)
			this.addIntAnimator(view.wrapper, PROP_WRAPPER_BOTTOM, "bottom", startValues, endValues, animators)
		}

		this.addColorAnimator(view.wrapper, PROP_WRAPPER_BACKGROUND_COLOR, "backgroundKolor", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_BORDER_TOP_WIDTH, "borderTopWidth", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_BORDER_LEFT_WIDTH, "borderLeftWidth", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_BORDER_RIGHT_WIDTH, "borderRightWidth", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_BORDER_BOTTOM_WIDTH, "borderBottomWidth", startValues, endValues, animators)
		this.addColorAnimator(view.wrapper, PROP_WRAPPER_BORDER_TOP_COLOR, "borderTopColor", startValues, endValues, animators)
		this.addColorAnimator(view.wrapper, PROP_WRAPPER_BORDER_LEFT_COLOR, "borderLeftColor", startValues, endValues, animators)
		this.addColorAnimator(view.wrapper, PROP_WRAPPER_BORDER_RIGHT_COLOR, "borderRightColor", startValues, endValues, animators)
		this.addColorAnimator(view.wrapper, PROP_WRAPPER_BORDER_BOTTOM_COLOR, "borderBottomColor", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_BORDER_TOP_LEFT_RADIUS, "borderTopLeftRadius", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_BORDER_TOP_RIGHT_RADIUS, "borderTopRightRadius", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_BORDER_BOTTOM_LEFT_RADIUS, "borderBottomLeftRadius", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_BORDER_BOTTOM_RIGHT_RADIUS, "borderBottomRightRadius", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_SHADOW_BLUR, "shadowBlur", startValues, endValues, animators)
		this.addColorAnimator(view.wrapper, PROP_WRAPPER_SHADOW_COLOR, "shadowColor", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_SHADOW_OFFSET_TOP, "shadowOffsetTop", startValues, endValues, animators)
		this.addFloatAnimator(view.wrapper, PROP_WRAPPER_SHADOW_OFFSET_LEFT, "shadowOffsetLeft", startValues, endValues, animators)
		this.addOpacityAnimator(view.wrapper, PROP_WRAPPER_ALPHA, startValues, endValues, animators)
		this.addTransformAnimator(view.wrapper, PROP_WRAPPER_TRANSFORM, startValues, endValues, animators)

		if (view.wrapper.measured) {
			this.addIntAnimator(view.content, PROP_CONTENT_TOP, "top", startValues, endValues, animators)
			this.addIntAnimator(view.content, PROP_CONTENT_LEFT, "left", startValues, endValues, animators)
			this.addIntAnimator(view.content, PROP_CONTENT_RIGHT, "right", startValues, endValues, animators)
			this.addIntAnimator(view.content, PROP_CONTENT_BOTTOM, "bottom", startValues, endValues, animators)
		}

		this.addFloatAnimator(view.content, PROP_CONTENT_TRANSLATION_X, "translationX", startValues, endValues, animators)
		this.addFloatAnimator(view.content, PROP_CONTENT_TRANSLATION_Y, "translationY", startValues, endValues, animators)
		
		if (view is TextView) {
			this.addColorAnimator(view.content, PROP_TEXT_COLOR, "textColor", startValues, endValues, animators)
			this.addFloatAnimator(view.content, PROP_TEXT_KERNING, "textKerning", startValues, endValues, animators)
			this.addFloatAnimator(view.content, PROP_TEXT_LEADING, "textLeading", startValues, endValues, animators)
			this.addFloatAnimator(view.content, PROP_TEXT_BASELINE, "textBaseline", startValues, endValues, animators)
		}

		if (view is ImageView) {
			this.addFloatAnimator(view.content, PROP_IMAGE_TOP, "imageTop", startValues, endValues, animators)
			this.addFloatAnimator(view.content, PROP_IMAGE_LEFT, "imageLeft", startValues, endValues, animators)
			this.addFloatAnimator(view.content, PROP_IMAGE_WIDTH, "imageWidth", startValues, endValues, animators)
			this.addFloatAnimator(view.content, PROP_IMAGE_HEIGHT, "imageHeight", startValues, endValues, animators)
			this.addColorAnimator(view.content, PROP_IMAGE_TINT, "imageTint", startValues, endValues, animators)
		}

		if (view.content is ContentView) {
			this.addIntAnimator(view.content, PROP_CONTENT_REAL_SCROLL_X, "realScrollX", startValues, endValues, animators)
			this.addIntAnimator(view.content, PROP_CONTENT_REAL_SCROLL_Y, "realScrollY", startValues, endValues, animators)
		}

		if (view.content is Scrollable) {
			this.addFloatAnimator(view.content, PROP_SCROLL_TOP, "scrollTop", startValues, endValues, animators)
			this.addFloatAnimator(view.content, PROP_SCROLL_LEFT, "scrollLeft", startValues, endValues, animators)
		}

		if (animators.size == 0) {
			return null
		}

		return animators
	}

	/**
	 * @method addIntAnimator
	 * @since 0.1.0
	 * @hidden
	 */
	private fun addIntAnimator(view: AndroidView, key: String, property: String, sv: TransitionValues, ev: TransitionValues, animators: MutableList<Animator>) {

		val f = sv.values[key]!!
		val t = ev.values[key]!!

		if (f == t) {
			return
		}

		if (f is Int && t is Int) {

			val animator = ObjectAnimator.ofInt(view, property, f, t)

			if (view is TransitionListener) {
				view.onTransitionProperty(property)
				this.listeners.add(view)
			}

			animators.add(animator)
		}
	}

	/**
	 * @method addFloatAnimator
	 * @since 0.1.0
	 * @hidden
	 */
	private fun addFloatAnimator(view: AndroidView, key: String, property: String, sv: TransitionValues, ev: TransitionValues, animators: MutableList<Animator>) {

		val f = sv.values[key]!!
		val t = ev.values[key]!!

		if (f == t) {
			return
		}

		if (f is Float && t is Float) {

			val animator = ObjectAnimator.ofFloat(view, property, f, t)

			if (view is TransitionListener) {
				view.onTransitionProperty(property)
				this.listeners.add(view)
			}

			animators.add(animator)
		}
	}

	/**
	 * @method addColorAnimator
	 * @since 0.1.0
	 * @hidden
	 */
	private fun addColorAnimator(view: AndroidView, key: String, property: String, sv: TransitionValues, ev: TransitionValues, animators: MutableList<Animator>) {

		val f = sv.values[key]!!
		val t = ev.values[key]!!

		if (f == t) {
			return
		}

		if (f is Int && t is Int) {

			val animator = ObjectAnimator.ofArgb(view, property, f, t)

			if (view is TransitionListener) {
				view.onTransitionProperty(property)
				this.listeners.add(view)
			}

			animators.add(animator)
		}
	}

	/**
	 * @method addOpacityAnimator
	 * @since 0.1.0
	 * @hidden
	 */
	private fun addOpacityAnimator(view: AndroidView, key: String, sv: TransitionValues, ev: TransitionValues, animators: MutableList<Animator>) {

		val f = sv.values[key]!!
		val t = ev.values[key]!!

		if (f == t) {
			return
		}

		if (f is Float && t is Float) {

			val animator = OpacityAnimator(view, f, t)

			if (view is TransitionListener) {
				view.onTransitionProperty("opacity")
				this.listeners.add(view)
			}

			animators.add(animator)
		}
	}

	/**
	 * @method addTransformAnimator
	 * @since 0.1.0
	 * @hidden
	 */
	private fun addTransformAnimator(view: WrapperView, key: String, sv: TransitionValues, ev: TransitionValues, animators: MutableList<Animator>) {

		val f = sv.values[key]!!
		val t = ev.values[key]!!

		if (f == t) {
			return
		}

		if (f is Transform && t is Transform) {
			val animator = TransformAnimator(view, f, t)
			view.onTransitionProperty("transform")
			this.listeners.add(view)
			animators.add(animator)
		}
	}

	/**
	 * @method forEachView
	 * @since 0.1.0
	 * @hidden
	 */
	private fun forEachView(each: (View) -> Unit) {

		val window = this.activity.application?.window
		if (window == null) {
			return
		}

		each(window)

		this.forEachViewOf(window, each)
	}

	/**
	 * @method forEachViewOf
	 * @since 0.1.0
	 * @hidden
	 */
	private fun forEachViewOf(root: View, each: (View) -> Unit) {
		root.children.forEach { view ->
			if (view.visible.boolean) {
				each.invoke(view)
				this.forEachViewOf(view, each)
			}
		}
	}

	//--------------------------------------------------------------------------
	// Mehods - Animator Listener
	//--------------------------------------------------------------------------

	/**
	 * @method onAnimationStart
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onAnimationStart(animation: Animator?) {
		this.listeners.forEach {
			it.onTransitionBegin()
		}
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

		this.listeners.forEach {
			it.onTransitionFinish()
		}

		this.listeners = mutableSetOf()

		this.callback?.invoke()
	}

	/**
	 * @method onAnimationCancel
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onAnimationCancel(animation: Animator?) {

	}
}