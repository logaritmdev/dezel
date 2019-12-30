package ca.logaritm.dezel.modules.util

import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.extension.core.activity
import ca.logaritm.dezel.modules.application.JavaScriptApplication

/**
 * @class JavaScriptUtil
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptUtil(context: JavaScriptContext): JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @property jsFunction_importClass
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_importClass(callback: JavaScriptFunctionCallback) {
		this.context.classes[callback.argument(0).string]?.let {
			callback.returns(it)
		}
	}

	/**
	 * @property jsFunction_importObject
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_importObject(callback: JavaScriptFunctionCallback) {
		this.context.objects[callback.argument(0).string]?.let {
			callback.returns(it)
		}
	}

	/**
	 * @property jsFunction_registerApplication
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_registerApplication(callback: JavaScriptFunctionCallback) {
		callback.argument(0).cast(JavaScriptApplication::class.java)?.let {
			this.context.activity.registerApplication(it)
		}
	}

	/**
	 * @property jsFunction_reloadApplication
	 * @since 0.7.0
	 * @hidden
	 */
	open fun jsFunction_reloadApplication(callback: JavaScriptFunctionCallback) {
		this.context.activity.reloadApplication()
	}

	/**
	 * @property jsFunction_reloadApplicationStyles
	 * @since 0.7.0
	 * @hidden
	 */
	open fun jsFunction_reloadApplicationStyles(callback: JavaScriptFunctionCallback) {
		this.context.activity.reloadApplicationStyles()
	}
}