/**
 * @class JavaScriptFinalizeCallback
 * @since 0.1.0
 */
public final class JavaScriptFinalizeCallback {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

    /**
     * @property context
     * @since 0.1.0
	 * @hidden
     */
	private(set) public var context: JavaScriptContext

    /**
     * @property handle
     * @since 0.4.0
	 * @hidden
     */
	private(set) public var handle: JavaScriptValueDataRef

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

    /**
     * @constructor
     * @since 0.1.0
	 * @hidden
     */
	internal init(context: JavaScriptContext, handle: JavaScriptValueDataRef) {
		self.context = context
		self.handle = handle
	}

	/**
	 * @method attribute
	 * @since 0.4.0
	 */
	public func attribute(_ key: AnyObject) -> AnyObject? {
		return toUnretainedObject(JavaScriptValueDataGetAttribute(self.handle, toHash(key)))
	}

	/**
	 * @method attribute
	 * @since 0.4.0
	 */
	public func attribute(_ key: AnyObject, value: AnyObject?) {
		let hash = toHash(key)
		JavaScriptValueDataGetAttribute(self.handle, hash)?.release()
		JavaScriptValueDataSetAttribute(self.handle, hash, toRetainedOpaque(value))
	}
}
