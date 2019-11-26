/**
 * @class JavaScriptGraphicModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptGraphicModule: JavaScriptModule {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method register
	 * @since 0.7.0
	 */
	override open func register(context: JavaScriptContext) {
		context.registerClass("dezel.graphic.Image", with: JavaScriptImage.self)
		context.registerClass("dezel.graphic.Canvas", with: JavaScriptCanvas.self)
	}
}
