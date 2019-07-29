package ca.logaritm.dezel.modules.platform

import android.os.Build
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptGetterCallback

/**
 * @class JavaScriptPlatform
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPlatform(context: JavaScriptContext): JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_name
	 * @since 0.7.0
	 * @hidden
	 */
	open fun jsGet_name(callback: JavaScriptGetterCallback) {
		callback.returns("android")
	}

	/**
	 * @method jsGet_version
	 * @since 0.7.0
	 * @hidden
	 */
	open fun jsGet_version(callback: JavaScriptGetterCallback) {
		callback.returns(Build.VERSION.RELEASE)
	}
}
