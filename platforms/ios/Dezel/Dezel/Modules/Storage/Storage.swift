/**
 * @class Storage
 * @since 0.1.0
 * @hidden
 */
open class Storage: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_remove
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_remove(callback: JavaScriptFunctionCallback) {

		let count = callback.arguments
		if (count < 1) {
			return
		}

		let key = callback.argument(0).string

		UserDefaults.standard.removeObject(forKey: kPrefix + key)
	}

	/**
	 * @method jsFunction_set
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_set(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			return
		}

		let key = callback.argument(0).string
		let val = callback.argument(1).string

		UserDefaults.standard.set(val, forKey: kPrefix + key)
	}

	/**
	 * @method jsFunction_get
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_get(callback: JavaScriptFunctionCallback) {

		let count = callback.arguments
		if (count < 1) {
			return
		}

		let key = callback.argument(0).string

		if let val = UserDefaults.standard.string(forKey: kPrefix + key) {
			callback.returns(string: val)
		}
	}
}

private let kPrefix = "dezel.storage."
