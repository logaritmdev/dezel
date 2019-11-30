/**
 * @class JavaScriptValueForEachWrapper
 * @since 0.7.0
 * @hidden
 */
internal final class JavaScriptValueForEachWrapper {

	/**
	 * @property context
	 * @since 0.7.0
	 * @hidden
	 */
	internal var context: JavaScriptContext

	/**
	 * @property handler
	 * @since 0.7.0
	 * @hidden
	 */
	internal var handler: JavaScriptForEachHandler

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(context: JavaScriptContext, handler: @escaping JavaScriptForEachHandler) {
		self.context = context
		self.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public func execute(key: Int, value: JSValueRef) {
		self.handler(key, JavaScriptValue.create(self.context, handle: value))
	}
}

/**
 * @function javaScriptValueForEachCallback
 * @since 0.7.0
 * @hidden
 */
internal let javaScriptValueForEachCallback: @convention(c) (JSContextRef?, JSValueRef?, Int32, UnsafeMutableRawPointer?) -> Void = { context, value, index, data in

	let context = context!
	let value = value!
	let data = data!

	Unmanaged<JavaScriptValueForEachWrapper>.fromOpaque(data).takeUnretainedValue().execute(key: Int(index), value: value)
}
