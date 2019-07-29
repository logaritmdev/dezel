/**
 * @class JavaScriptPlatform
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPlatform: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_name
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_name(callback: JavaScriptGetterCallback) {
		callback.returns(string: "ios")
	}

	/**
	 * @method jsGet_version
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_version(callback: JavaScriptGetterCallback) {
		callback.returns(string: UIDevice.current.systemVersion)
	}
}
