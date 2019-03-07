import Foundation

/**
 * Convenience object to interact with the JavaScript console.
 * @class JavaScriptConsole
 * @since 0.4.0
 */
open class JavaScriptConsole {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The console's JavaScript context.
	 * @property context
	 * @since 0.4.0
	 */
	public let context: JavaScriptContext

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 */
	public init(context: JavaScriptContext) {
		self.context = context
	}

	/**
	 * Sends a message to the console.log method.
	 * @method log
	 * @since 0.4.0
	 */
	open func log(_ message: String) {
		self.context.global.property("console").callMethod("log", arguments: [self.context.createString(message)])
	}

	/**
	 * Sends a message to the console.warn method.
	 * @method warn
	 * @since 0.4.0
	 */
	open func warn(_ message: String) {
		self.context.global.property("console").callMethod("warn", arguments: [self.context.createString(message)])
	}

	/**
	 * Sends a message to the console.error method.
	 * @method error
	 * @since 0.4.0
	 */
	open func error(_ message: String) {
		self.context.global.property("console").callMethod("error", arguments: [self.context.createString(message)])
	}
}
