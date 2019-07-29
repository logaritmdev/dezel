package ca.logaritm.dezel.modules.platform

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class PlatformModule
 * @since 0.1.0
 * @hidden
 */
public class PlatformModule(context: JavaScriptContext) : Module(context) {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	public override fun initialize() {
		this.context.registerClass("dezel.platform.JavaScriptPlatform", JavaScriptPlatform::class.java)
	}
}
