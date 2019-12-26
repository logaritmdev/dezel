/**
 * @class JavaScriptObject
 * @super JavaScriptValue
 * @since 0.1.0
 */
open class JavaScriptObject: JavaScriptValue {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 */
	public required init(context: JavaScriptContext) {
		super.init(context: context)
	}

	/**
	 * @method dispose
	 * @since 0.6.0
	 */
	override open func dispose() {

		if (self.handle != nil) {
			JavaScriptValueGetAssociatedObject(self.context.handle, self.handle).release()
			JavaScriptValueSetAssociatedObject(self.context.handle, self.handle, nil)
		}

		super.dispose()
	}

	/**
	 * @method attribute
	 * @since 0.1.0
	 */
	public func attribute(_ key: AnyObject) -> AnyObject? {
		return JavaScriptValueGetAttribute(self.context.handle, self.handle, toHash(key))?.value
	}

	/**
	 * @method attribute
	 * @since 0.1.0
	 */
	public func attribute(_ key: AnyObject, value: AnyObject?) {
		let hash = toHash(key)
		JavaScriptValueGetAttribute(self.context.handle, self.handle, hash)?.release()
		JavaScriptValueSetAttribute(self.context.handle, self.handle, hash, toRetainedOpaque(value))
	}

	/**
	 * @method finalize
	 * @since 0.4.0
	 */
	public func finalize(_ handler: @escaping JavaScriptFinalizeHandler) {
		_ = JavaScriptFinalizeWrapper(context: self.context, handle: self.handle, handler: handler)
	}

	//--------------------------------------------------------------------------
	// MARK: Extensions
	//--------------------------------------------------------------------------

	/**
	 * @method didResetValue
	 * @since 0.4.0
	 */
	override open func didResetValue() {

		self.finalize { callback in
	
			/*
			 * When an object is finalized on the JavaScript side we must
			 * dispose it from the native side because its technically no
			 * longer usable.
			 */

			if let this = JavaScriptValueDataGetAssociatedObject(callback.handle) {
				Unmanaged<JavaScriptValue>.fromOpaque(this).takeUnretainedValue().dispose()
			}
		}
	}
}
