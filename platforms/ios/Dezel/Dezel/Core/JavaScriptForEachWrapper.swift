/**
 * @class JavaScriptValueForEachWrapper
 * @since 0.7.0
 * @hidden
 */
internal final class JavaScriptValueForEachWrapper: NSObject {

	/**
	 * @property context
	 * @since 0.7.0
	 * @hidden
	 */
	public var context: JavaScriptContext

	/**
	 * @property handler
	 * @since 0.7.0
	 * @hidden
	 */
	public var callback: JavaScriptForEachHandler

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(context: JavaScriptContext, callback: @escaping JavaScriptForEachHandler) {
		self.context = context
		self.callback = callback
		super.init()
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public func execute(key: Int, value: JSValueRef) {
		self.callback(key, JavaScriptValue.create(self.context, handle: value))
	}
}

/**
 * @since 0.7.0
 * @hidden
 */
internal let JavaScriptValueForEachCallback: @convention(c) (JSContextRef?, JSValueRef?, Int32, UnsafeMutableRawPointer?) -> Void = { context, value, index, data in

	let context = context!
	let value = value!
	let data = data!

	Unmanaged<JavaScriptValueForEachWrapper>.fromOpaque(data).takeUnretainedValue().execute(key: Int(index), value: value)
}
