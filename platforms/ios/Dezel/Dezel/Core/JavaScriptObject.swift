/**
 * The base class for bridged object.
 * @class JavaScriptObject
 * @since 0.1.0
 */
open class JavaScriptObject: JavaScriptValue {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the JavaScript object.
	 * @constructor
	 * @since 0.4.0
	 */
	required override public init(context: JavaScriptContext) {
		super.init(context: context)
	}

	/**
	 * Returns an attribute from this object.
	 * @method attribute
	 * @since 0.1.0
	 */
	public func attribute(_ key: AnyObject) -> AnyObject? {
		return DLValueGetAttribute(self.context.handle, self.handle, toHash(key))?.value
	}

	/**
	 * Assigns an attribute on this object.
	 * @method attribute
	 * @since 0.1.0
	 */
	public func attribute(_ key: AnyObject, value: AnyObject) {
		DLValueSetAttribute(self.context.handle, self.handle, toHash(key), UnsafeMutableRawPointer(Unmanaged.passRetained(value).toOpaque()))
	}

	/**
	 * Deletes an attribute from this object.
	 * @method deleteAttribute
	 * @since 0.1.0
	 */
	public func deleteAttribute(_ key: AnyObject) {
		DLValueGetAttribute(self.context.handle, self.handle, toHash(key))?.release()
		DLValueDeleteAttribute(self.context.handle, self.handle, toHash(key))
	}

	/**
	 * Assigns the value's finalize handler.
	 * @method finalize
	 * @since 0.4.0
	 */
	public func finalize(_ handler: @escaping JavaScriptFinalizeHandler) {
		_ = JavaScriptFinalizeWrapper(context: self.context, handle: self.handle, handler: handler)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Extensions
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method didResetValue
	 * @since 0.4.0
	 */
	override open func didResetValue() {
		self.finalize { callback in
			DLValueDataGetAssociatedObject(callback.handle).release()
		}
	}
}
