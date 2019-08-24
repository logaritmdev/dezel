package ca.logaritm.dezel.modules.dialog

import ca.logaritm.dezel.core.*

/**
 * @class JavaScriptAlertButton
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptAlertButton(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The alert button's label.
	 * @property label
	 * @since 0.7.0
	 */
	open val label: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "")
	}

	/**
	 * The alert button's image.
	 * @property image
	 * @since 0.7.0
	 */
	open val image: JavaScriptProperty by lazy {
		JavaScriptProperty(context)
	}

	/**
	 * The alert button's renderNode.
	 * @property style
	 * @since 0.7.0
	 */
	open val style: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "normal")
	}

	//--------------------------------------------------------------------------
	// JS Properties
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
		this.label.set(callback.value, this)
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
		this.image.set(callback.value, this)
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
		this.style.set(callback.value, this)
	}
}