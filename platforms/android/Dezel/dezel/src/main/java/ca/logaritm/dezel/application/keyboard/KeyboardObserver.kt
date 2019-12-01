package ca.logaritm.dezel.application.keyboard

import android.app.Activity
import android.graphics.Point
import android.graphics.Rect
import android.graphics.drawable.ColorDrawable
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.LinearLayout
import android.widget.PopupWindow
import ca.logaritm.dezel.view.graphic.Color

/**.
 * @class KeyboardObserver
 * @super PopupWindow
 * @since 0.1.0
 */
open class KeyboardObserver(val activity: Activity, view: View) : PopupWindow(activity) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property listener
	 * @since 0.1.0
	 */
	open var listener: KeyboardObserverListener? = null

	/**
	 * @property orientation
	 * @since 0.1.0
	 * @hidden
	 */
	private val orientation: Int
		get() = this.activity.resources.configuration.orientation

	/**
	 * @property parentView
	 * @since 0.1.0
	 * @hidden
	 */
	private val parentView: View

	/**
	 * @property layoutView
	 * @since 0.1.0
	 * @hidden
	 */
	private val layoutView: View

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {

		this.softInputMode = WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE or WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE
		this.inputMethodMode = PopupWindow.INPUT_METHOD_NEEDED

		this.width = 0
		this.height = WindowManager.LayoutParams.MATCH_PARENT

		this.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))

		this.parentView = this.activity.findViewById(android.R.id.content)
		this.layoutView = LinearLayout(activity)
		this.layoutView.background = ColorDrawable(Color.TRANSPARENT)
		this.layoutView.layoutParams = LinearLayout.LayoutParams(
			ViewGroup.LayoutParams.MATCH_PARENT,
			ViewGroup.LayoutParams.MATCH_PARENT
		)

		this.contentView = this.layoutView

		this.layoutView.viewTreeObserver.addOnGlobalLayoutListener {
			this.handleGlobalLayout()
		}

		view.post {
			this.start()
		}
	}

	/**
	 * @method start
	 * @since 0.1.0
	 */
	open fun start() {
		this.showAtLocation(this.parentView, Gravity.NO_GRAVITY, 0, 0)
	}

	/**
	 * @method close
	 * @since 0.1.0
	 */
	open fun close() {
		this.dismiss()
	}

	/**
	 * @method handleGlobalLayout
	 * @since 0.1.0
	 */
	private fun handleGlobalLayout() {

		val screenSize = Point()
		val layoutSize = Rect()
		this.activity.windowManager.defaultDisplay.getSize(screenSize)
		this.layoutView.getWindowVisibleDisplayFrame(layoutSize)

		this.listener?.onKeyboardHeightChanged(screenSize.y - layoutSize.bottom, this.orientation)
	}
}