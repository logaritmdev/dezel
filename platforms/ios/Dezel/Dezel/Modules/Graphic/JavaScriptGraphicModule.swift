/**
 * @class JavaScriptGraphicModule
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptGraphicModule: Module {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method register
	 * @since 0.7.0
	 */
	override open func register(context: JavaScriptContext) {
		context.registerClass("dezel.graphic.Image", with: JavaScriptImage.self)
		context.registerClass("dezel.graphic.Canvas", with: JavaScriptCanvas.self)
	}
}
