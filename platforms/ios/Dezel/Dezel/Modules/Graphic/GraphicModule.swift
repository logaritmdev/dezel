/**
 * @class GraphicModule
 * @since 0.1.0
 * @hidden
 */
open class GraphicModule: Module {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override open func initialize() {
		self.context.registerClass("dezel.graphic.Image", with: Image.self)
		self.context.registerClass("dezel.graphic.Canvas", with: Canvas.self)
	}
}
