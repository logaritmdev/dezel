package ca.logaritm.dezel.modules.i18n

import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback

/**
 * @class TranslationManager
 * @since 0.5.0
 * @hidden
 */
open class TranslationManager(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The translation file used.
	 * @property file
	 * @since 0.5.0
	 */
	public var file: TranslationFile? = null
		private set

	//--------------------------------------------------------------------------
	//  JS Methods
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_load
	 * @since 0.5.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_load(callback: JavaScriptFunctionCallback) {

		when (callback.arguments) {

			0 -> this.file = TranslationFile(this.context.application)
			1 -> this.file = TranslationFile(this.context.application, callback.argument(0).string)

			else -> {
			}
		}

		callback.returns(this.file!!.loaded)
	}

	/**
	 * @method jsFunction_translate
	 * @since 0.5.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_translate(callback: JavaScriptFunctionCallback) {
		when (callback.arguments) {
			1 -> callback.returns(TranslationManagerExternal.translate(callback.argument(0).string))
			2 -> callback.returns(TranslationManagerExternal.translate(callback.argument(0).string, callback.argument(1).string))
		}
	}
}