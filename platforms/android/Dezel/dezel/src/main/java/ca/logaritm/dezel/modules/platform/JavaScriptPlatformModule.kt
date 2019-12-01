package ca.logaritm.dezel.modules.platform

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptPlatformModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
public class JavaScriptPlatformModule(context: JavaScriptContext) : JavaScriptModule(context) {

	/**
	 * @method initialize
	 * @since 0.1.0
	 */
	public override fun initialize() {
		this.context.registerClass("dezel.platform.Platform", JavaScriptPlatform::class.java)
	}
}
