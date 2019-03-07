/**
 * @class LocalStorage
 * @since 0.1.0
 * @hidden
 */
open class LocalStorage: JavaScriptObject {

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_removeItem
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_removeItem(callback: JavaScriptFunctionCallback) {

		let count = callback.arguments
		if (count < 1) {
			return
		}

		let key = callback.argument(0).string

		UserDefaults.standard.removeObject(forKey: kPrefix + key)
	}

	/**
	 * @method jsFunction_setItem
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_setItem(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			return
		}

		let key = callback.argument(0).string
		let val = callback.argument(1).string

		UserDefaults.standard.set(val, forKey: kPrefix + key)
	}

	/**
	 * @method jsFunction_getItem
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_getItem(callback: JavaScriptFunctionCallback) {

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

private let kPrefix = "dezel.localStorage."
