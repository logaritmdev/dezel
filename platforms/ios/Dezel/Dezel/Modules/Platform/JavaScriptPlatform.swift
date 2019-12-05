/**
 * @class JavaScriptPlatform
 * @super JavaScriptClass
 * @since 0.7.0
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
	@objc func jsGet_name(callback: JavaScriptGetterCallback) {
		callback.returns("ios")
	}

	/**
	 * @method jsGet_version
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_version(callback: JavaScriptGetterCallback) {
		callback.returns(UIDevice.current.systemVersion)
	}
}
