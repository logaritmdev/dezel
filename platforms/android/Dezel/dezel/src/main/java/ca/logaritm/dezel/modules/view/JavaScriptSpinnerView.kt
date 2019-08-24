package ca.logaritm.dezel.modules.view

import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptGetterCallback
import ca.logaritm.dezel.core.JavaScriptSetterCallback
import ca.logaritm.dezel.core.JavaScriptProperty
import ca.logaritm.dezel.extension.toColor
import ca.logaritm.dezel.view.SpinnerView

/**
 * @class JavaScriptSpinnerView
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptSpinnerView(context: JavaScriptContext) : JavaScriptView(context) {

	/**
	 * The activity view's active status.
	 * @property active
	 * @since 0.7.0
	 */
	open val active: JavaScriptProperty by lazy {
		JavaScriptProperty(context, false) { value ->
			this.view.active = value.boolean
		}
	}

	/**
	 * The activity view's color.
	 * @property color
	 * @since 0.7.0
	 */
	open val color: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "#000") { value ->
			this.view.color = value.string.toColor()
		}
	}

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private val view: SpinnerView
		get() = this.content as SpinnerView

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method createContentView
	 * @since 0.7.0
	 */
	override fun createContentView(): SpinnerView {
		return SpinnerView(this.context.application)
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_active
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_active(callback: JavaScriptGetterCallback) {
		callback.returns(this.active)
	}

	/**
	 * @method jsSet_active
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_active(callback: JavaScriptSetterCallback) {
		this.active.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_color
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_color(callback: JavaScriptGetterCallback) {
		callback.returns(this.color)
	}

	/**
	 * @method jsSet_color
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_color(callback: JavaScriptSetterCallback) {
		this.color.set(callback.value, this)
	}
}
