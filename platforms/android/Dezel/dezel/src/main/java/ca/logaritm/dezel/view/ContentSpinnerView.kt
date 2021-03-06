package ca.logaritm.dezel.view

import android.content.Context
import android.graphics.Canvas
import android.graphics.PorterDuff
import android.graphics.Rect
import android.graphics.drawable.Drawable
import android.view.View
import android.widget.FrameLayout
import android.widget.ProgressBar
import ca.logaritm.dezel.R
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.view.graphic.Color

/**
 * @class ContentSpinnerView
 * @since 0.1.0
 * @hidden
 */
open class ContentSpinnerView(context: Context) : FrameLayout(context) {

	//----------------------------------------------------------------------
	//  Properties
	//----------------------------------------------------------------------

	/**
	 * @property active
	 * @since 0.1.0
	 * @hidden
	 */
	open var active: Boolean by Delegates.OnSet(false) { value ->
		if (value) {
			this.showActiveDrawable()
			this.hideCircleDrawable()
		} else {
			this.hideActiveDrawable()
			this.showCircleDrawable()
		}
	}

	/**
	 * @property color
	 * @since 0.1.0
	 * @hidden
	 */
	open var color: Int by Delegates.OnSet(Color.GRAY) { value ->
		this.activeSpinnerDrawable.setColorFilter(value, PorterDuff.Mode.SRC_IN)
		this.circleSpinnerDrawable.setColorFilter(value, PorterDuff.Mode.SRC_IN)
	}

	/**
	 * @property progressBar
	 * @since 0.1.0
	 * @hidden
	 */
	private var progressBar: ProgressBar = ProgressBar(context, null, android.R.attr.progressBarStyleSmall)

	/**
	 * @property activeSpinnerDrawable
	 * @since 0.1.0
	 * @hidden
	 */
	private var activeSpinnerDrawable: Drawable

	/**
	 * @property circleSpinnerDrawable
	 * @since 0.1.0
	 * @hidden
	 */
	private var circleSpinnerDrawable: Drawable

	/**
	 * @property circleSpinnerDrawableBounds
	 * @since 0.1.0
	 * @hidden
	 */
	private var circleSpinnerDrawableBounds: Rect

	//----------------------------------------------------------------------
	//  ViewContent Protocol
	//----------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init {

		this.progressBar.visibility = View.GONE

		this.addView(this.progressBar)

		this.activeSpinnerDrawable = this.getActiveDrawable()
		this.circleSpinnerDrawable = this.getCircleDrawable()
		this.activeSpinnerDrawable.setColorFilter(Color.GRAY, PorterDuff.Mode.SRC_IN)
		this.circleSpinnerDrawable.setColorFilter(Color.GRAY, PorterDuff.Mode.SRC_IN)

		this.circleSpinnerDrawableBounds = Rect(0, 0, this.width, this.height)

		this.setWillNotDraw(false)
	}

	/**
	 * @inherited
	 * @method onMeasure
	 * @since 0.1.0
	 */
	override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
		super.onMeasure(widthMeasureSpec, heightMeasureSpec)
		this.progressBar.measure(widthMeasureSpec, heightMeasureSpec)
	}

	/**
	 * @method onDraw
	 * @since 0.1.0
	 * @since 0.1.0
	 */
	override fun onDraw(canvas: Canvas) {
		super.onDraw(canvas)
		if (this.circleSpinnerDrawable.isVisible) {
			this.circleSpinnerDrawable.bounds.set(0, 0, this.width, this.height)
			this.circleSpinnerDrawable.draw(canvas)
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method showActiveDrawable
	 * @since 0.1.0
	 * @since 0.1.0
	 */
	private fun showActiveDrawable() {
		this.progressBar.visibility = View.VISIBLE
		this.progressBar.top = 0
		this.progressBar.left = 0
		this.progressBar.right = this.width
		this.progressBar.bottom = this.height
	}

	/**
	 * @method hideActiveDrawable
	 * @since 0.1.0
	 * @since 0.1.0
	 */
	private fun hideActiveDrawable() {
		this.progressBar.visibility = View.GONE
	}

	/**
	 * @method showCircleDrawable
	 * @since 0.1.0
	 * @since 0.1.0
	 */
	private fun showCircleDrawable() {
		this.circleSpinnerDrawable.setVisible(true, false)
		this.invalidate()
	}

	/**
	 * @method hideCircleDrawable
	 * @since 0.1.0
	 * @since 0.1.0
	 */
	private fun hideCircleDrawable() {
		this.circleSpinnerDrawable.setVisible(false, false)
		this.invalidate()
	}

	/**
	 * @method getActiveDrawable
	 * @since 0.1.0
	 * @since 0.1.0
	 */
	private fun getActiveDrawable(): Drawable {
		return this.progressBar.indeterminateDrawable
	}

	/**
	 * @method getCircleDrawable
	 * @since 0.1.0
	 * @since 0.1.0
	 */
	private fun getCircleDrawable(): Drawable {
		return this.context.getDrawable(R.drawable.spinner_view)
	}
}
