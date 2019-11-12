package ca.logaritm.dezel.modules.view

import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptGetterCallback
import ca.logaritm.dezel.core.JavaScriptProperty
import ca.logaritm.dezel.core.JavaScriptSetterCallback
import ca.logaritm.dezel.extension.type.toColor
import ca.logaritm.dezel.view.SpinnerView

/**
 * @class JavaScriptSpinnerView
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptSpinnerView(context: JavaScriptContext) : JavaScriptView(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

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
	 * The activity view's active status.
	 * @property active
	 * @since 0.7.0
	 */
	public val active by lazy {
		JavaScriptProperty(false) { value ->
			this.view.active = value.boolean
		}
	}

	/**
	 * The activity view's color.
	 * @property color
	 * @since 0.7.0
	 */
	public val color by lazy {
		JavaScriptProperty("#000") { value ->
			this.view.color = value.string.toColor()
		}
	}

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
		this.active.reset(callback.value, lock = this)
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
		this.color.reset(callback.value, lock = this)
	}
}
