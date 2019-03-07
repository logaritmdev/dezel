package ca.logaritm.dezel.core

/**
 * Convenience object to interact with the JavaScript console.
 * @class JavaScriptConsole
 * @since 0.4.0
 */
open class JavaScriptConsole(context: JavaScriptContext) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The console's JavaScript context.
	 * @property context
	 * @since 0.4.0
	 */
	public val context: JavaScriptContext

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 */
	init {
		this.context = context
	}

	/**
	 * Sends a message to the console.log method.
	 * @method log
	 * @since 0.4.0
	 */
	open fun log(message: String) {
		this.context.global.property("console").callMethod("log", arrayOf(this.context.createString(message)))
	}

	/**
	 * Sends a message to the console.warn method.
	 * @method warn
	 * @since 0.4.0
	 */
	open fun warn(message: String) {
		this.context.global.property("console").callMethod("warn", arrayOf(this.context.createString(message)))
	}

	/**
	 * Sends a message to the console.error method.
	 * @method error
	 * @since 0.4.0
	 */
	open fun error(message: String) {
		this.context.global.property("console").callMethod("error", arrayOf(this.context.createString(message)))
	}
}