package ca.logaritm.dezel.modules.view

import ca.logaritm.dezel.application.activity
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptGetterCallback
import ca.logaritm.dezel.core.JavaScriptProperty
import ca.logaritm.dezel.core.JavaScriptSetterCallback
import ca.logaritm.dezel.extension.type.toColor
import ca.logaritm.dezel.view.SpinnerView

/**
 * @class JavaScriptSpinnerView
 * @super JavaScriptView
 * @since 0.7.0
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
	 * @method createContentView
	 * @since 0.7.0
	 */
	override fun createContentView(): SpinnerView {
		return SpinnerView(this.context.activity)
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @property spin
	 * @since 0.7.0
	 */
	public val spin by lazy {
		JavaScriptProperty(false) { value ->
			this.view.spin = value.boolean
		}
	}

	/**
	 * @property tint
	 * @since 0.7.0
	 */
	public val tint by lazy {
		JavaScriptProperty("#000") { value ->
			this.view.tint = value.string.toColor()
		}
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_color
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_color(callback: JavaScriptGetterCallback) {
		callback.returns(this.tint)
	}

	/**
	 * @method jsSet_color
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_color(callback: JavaScriptSetterCallback) {
		this.tint.reset(callback.value, lock = this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_spin
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_spin(callback: JavaScriptGetterCallback) {
		callback.returns(this.spin)
	}

	/**
	 * @method jsSet_spin
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_spin(callback: JavaScriptSetterCallback) {
		this.spin.reset(callback.value, lock = this)
	}
}
