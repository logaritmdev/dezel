/**
 * @class JavaScriptUtilModule
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptUtilModule: Module {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method register
	 * @since 0.7.0
	 */
	override open func register(context: JavaScriptContext) {
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
