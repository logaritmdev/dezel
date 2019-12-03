/**
 * @class JavaScriptUtilModule
 * @super JavaScriptModule
 */
open class JavaScriptUtilModule: JavaScriptModule {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	override open func configure(context: JavaScriptContext) {
		context.global.defineProperty(
			"__util__",
			value: context.createObject(JavaScriptUtil.self),
			getter: nil,
			setter: nil,
			writable: false,
			enumerable: false,
			configurable: false
		)
	}
}
