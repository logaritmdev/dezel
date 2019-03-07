package ca.logaritm.dezel.modules.web

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module
import ca.logaritm.dezel.core.getResource

/**
 * @class WebModule
 * @since 0.1.0
 * @hidden
 */
open class WebModule(context: JavaScriptContext) : Module(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {

		this.context.registerClass("dezel.web.XMLHttpRequest", XMLHttpRequest::class.java)
		this.context.registerClass("dezel.web.XMLHttpRequestUpload", XMLHttpRequestUpload::class.java)
		this.context.registerClass("dezel.web.WebSocket", WebSocket::class.java)
		this.context.registerClass("dezel.web.WebGlobal", WebGlobal::class.java)

		this.context.global.defineProperty(
			"localStorage",
			value = this.context.createObject(LocalStorage::class.java),
			getter = null,
			setter = null,
			writable = false,
			enumerable = false,
			configurable = true
		)

		this.context.evaluate(JavaScriptContext::class.getResource("res/raw/web_runtime.js").reader().use { it.readText() }, "web_runtime.js")
	}
}
