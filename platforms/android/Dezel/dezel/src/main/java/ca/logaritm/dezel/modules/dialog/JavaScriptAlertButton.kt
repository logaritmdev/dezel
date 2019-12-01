package ca.logaritm.dezel.modules.dialog

import ca.logaritm.dezel.core.*

/**
 * @class JavaScriptAlertButton
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptAlertButton(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @property label
	 * @since 0.7.0
	 */
	public val label by lazy {
		JavaScriptProperty("")
	}

	/**
	 * @property image
	 * @since 0.7.0
	 */
	public val image by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property style
	 * @since 0.7.0
	 */
	public val style by lazy {
		JavaScriptProperty("normal")
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_label
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_label(callback: JavaScriptGetterCallback) {
		callback.returns(this.label)
	}

	/**
	 * @method jsSet_label
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_label(callback: JavaScriptSetterCallback) {
		this.label.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_image
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_image(callback: JavaScriptGetterCallback) {
		callback.returns(this.image)
	}

	/**
	 * @method jsSet_image
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_image(callback: JavaScriptSetterCallback) {
		this.image.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_style
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_style(callback: JavaScriptGetterCallback) {
		callback.returns(this.style)
	}

	/**
	 * @method jsSet_style
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_style(callback: JavaScriptSetterCallback) {
		this.style.reset(callback.value, this)
	}
}