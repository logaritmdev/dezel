package ca.logaritm.dezel.modules.dialog

import ca.logaritm.dezel.core.*

/**
 * @class AlertButton
 * @since 0.1.0
 * @hidden
 */
open class AlertButton(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The alert button's label.
	 * @property label
	 * @since 0.1.0
	 */
	open var label: Property = Property("")

	/**
	 * The alert button's renderNode.
	 * @property style
	 * @since 0.1.0
	 */
	open var style: Property = Property("normal")

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_label
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_label(callback: JavaScriptGetterCallback) {
		callback.returns(this.label)
	}

	/**
	 * @method jsSet_label
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_label(callback: JavaScriptSetterCallback) {
		this.label = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_style
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_style(callback: JavaScriptGetterCallback) {
		callback.returns(this.style)
	}

	/**
	 * @method jsSet_style
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_style(callback: JavaScriptSetterCallback) {
		this.style = Property(callback.value)
	}
}