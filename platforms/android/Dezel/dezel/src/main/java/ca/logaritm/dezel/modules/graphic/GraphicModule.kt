package ca.logaritm.dezel.modules.graphic

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class GraphicModule
 * @since 0.1.0
 * @hidden
 */
open class GraphicModule(context: JavaScriptContext): JavaScriptModule(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.graphic.Image", JavaScriptImage::class.java)
		this.context.registerClass("dezel.graphic.Canvas", JavaScriptCanvas::class.java)
	}
}
