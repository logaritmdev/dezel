/**
 * @class Platform
 * @since 0.1.0
 * @hidden
 */
open class Platform: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_name
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_name(callback: JavaScriptGetterCallback) {
		callback.returns(string: "ios")
	}

	/**
	 * @method jsGet_version
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_version(callback: JavaScriptGetterCallback) {
		callback.returns(string: UIDevice.current.systemVersion)
	}
}
