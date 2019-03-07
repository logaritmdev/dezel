package ca.logaritm.dezel.modules.web

import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext

/**
 * @class EventTarget
 * @since 0.1.0
 * @hidden
 */
open class EventTarget(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	//  JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method dispatchEvent
	 * @since 0.1.0
	 * @hidden
	 */
	open fun dispatchEvent(type: String, event: String, inits: MutableMap<String, Any> = mutableMapOf())  {

		val constructor = this.context.global.property(type)
		if (constructor.isNull ||
			constructor.isUndefined) {
			throw Exception("Event of type $type does not exists.")
		}

		val eventType = this.context.createString(event)
		val eventInit = this.context.createEmptyObject()

		for ((name, value) in inits) {

			if (value is String) {
				eventInit.property(name, value)
				continue
			}

			if (value is Double) {
				eventInit.property(name, value)
				continue
			}

			if (value is Boolean) {
				eventInit.property(name, value)
				continue
			}
		}

		val instance = this.context.createReturnValue()
		constructor.construct(arrayOf(eventType, eventInit), instance)
		this.holder.callMethod("dispatchEvent", arrayOf(instance))
	}
}
