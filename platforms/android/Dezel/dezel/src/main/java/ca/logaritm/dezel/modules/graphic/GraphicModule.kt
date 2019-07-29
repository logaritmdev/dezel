package ca.logaritm.dezel.modules.graphic

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class GraphicModule
 * @since 0.1.0
 * @hidden
 */
open class GraphicModule(context: JavaScriptContext): Module(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.graphic.JavaScriptImage", JavaScriptImage::class.java)
		this.context.registerClass("dezel.graphic.JavaScriptCanvas", JavaScriptCanvas::class.java)
	}
}
