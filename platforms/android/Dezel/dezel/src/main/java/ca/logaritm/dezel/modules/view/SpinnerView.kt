package ca.logaritm.dezel.modules.view

import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptGetterCallback
import ca.logaritm.dezel.core.JavaScriptSetterCallback
import ca.logaritm.dezel.core.Property
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.toColor
import ca.logaritm.dezel.view.ContentSpinnerView
import android.view.View as AndroidView

/**
 * @class SpinnerView
 * @since 0.1.0
 * @hidden
 */
open class SpinnerView(context: JavaScriptContext) : View(context) {

	/**
	 * The activity view's active status.
	 * @property active
	 * @since 0.1.0
	 */
	open var active: Property by Delegates.OnSet(Property(false)) { value ->
		this.view.active = value.boolean
	}

	/**
	 * The activity view's color.
	 * @property color
	 * @since 0.1.0
	 */
	open var color: Property by Delegates.OnSet(Property("#000")) { value ->
		this.view.color = value.string.toColor()
	}

	/**
	 * @property view
	 * @since 0.1.0
	 * @hidden
	 */
	private val view: ContentSpinnerView
		get() = this.content as ContentSpinnerView

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method createContentView
	 * @since 0.1.0
	 */
	override fun createContentView() : ContentSpinnerView {
		return ContentSpinnerView(this.context.application)
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_active
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_active(callback: JavaScriptGetterCallback) {
		callback.returns(this.active)
	}

	/**
	 * @method jsSet_active
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_active(callback: JavaScriptSetterCallback) {
		this.active = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_color
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_color(callback: JavaScriptGetterCallback) {
		callback.returns(this.color)
	}

	/**
	 * @method jsSet_color
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_color(callback: JavaScriptSetterCallback) {
		this.color = Property(callback.value)
	}
}
