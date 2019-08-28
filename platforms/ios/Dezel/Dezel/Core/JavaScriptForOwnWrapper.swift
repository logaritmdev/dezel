
/**
 * @class JavaScriptValueForOwnWrapper
 * @since 0.7.0
 * @hidden
 */
internal final class JavaScriptValueForOwnWrapper: NSObject {

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
	internal var handler: JavaScriptForOwnHandler

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(context: JavaScriptContext, handler: @escaping JavaScriptForOwnHandler) {
		self.context = context
		self.handler = handler
		super.init()
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public func execute(key: String, value: JSValueRef) {
		self.handler(key, JavaScriptValue.create(self.context, handle: value))
	}
}

/**
 * @since 0.7.0
 * @hidden
 */
internal let JavaScriptValueForOwnCallback: @convention(c) (JSContextRef?, JSValueRef?, UnsafePointer<Int8>?, UnsafeMutableRawPointer?) -> Void = { context, value, name, data in

	let context = context!
	let value = value!
	let name = name!
	let data = data!

	Unmanaged<JavaScriptValueForOwnWrapper>.fromOpaque(data).takeUnretainedValue().execute(key: name.string, value: value)
}
