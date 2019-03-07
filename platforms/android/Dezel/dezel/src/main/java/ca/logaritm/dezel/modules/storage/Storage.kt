package ca.logaritm.dezel.modules.storage

import android.content.SharedPreferences
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback

/**
 * @class Storage
 * @since 0.1.0
 * @hidden
 */
open class Storage(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property preferences
	 * @since 0.1.0
	 * @hidden
	 */
	private val preferences: SharedPreferences = this.context.application.getSharedPreferences("dezel.storage", android.content.Context.MODE_PRIVATE)

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_remove
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_remove(callback: JavaScriptFunctionCallback) {

		val count = callback.arguments
		if (count < 1) {
			return
		}

		val editor = this.preferences.edit()
		if (editor == null) {
			return
		}

		val storageKey = callback.argument(0).string

		editor.remove(storageKey)
		editor.apply()
	}

	/**
	 * @method jsFunction_set
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_set(callback: JavaScriptFunctionCallback) {

		val count = callback.arguments
		if (count < 2) {
			return
		}

		val editor = this.preferences.edit()
		if (editor == null) {
			return
		}

		val storageKey = callback.argument(0).string
		val storageVal = callback.argument(1).string

		editor.putString(storageKey, storageVal)
		editor.apply()
	}

	/**
	 * @method jsFunction_get
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_get(callback: JavaScriptFunctionCallback) {

		val count = callback.arguments
		if (count < 1) {
			return
		}

		val key = callback.argument(0).string

		val value = this.preferences.getString(key, null)
		if (value != null) {
			callback.returns(value)
		}
	}
}