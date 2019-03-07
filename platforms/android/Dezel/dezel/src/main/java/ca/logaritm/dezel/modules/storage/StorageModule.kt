package ca.logaritm.dezel.modules.storage

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class StorageModule
 * @since 0.1.0
 * @hidden
 */
open class StorageModule(context: JavaScriptContext) : Module(context) {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.storage.Storage", Storage::class.java)
	}
}