/**
 * @class EventTarget
 * @since 0.1.0
 * @hidden
 */
open class EventTarget : JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method dispatchEvent
	 * @since 0.1.0
	 * @hidden
	 */
	open func dispatchEvent(type: String, event: String, inits: [String: Any] = [:])  {

		let constructor = self.context.global.property(type)
		if (constructor.isNull ||
			constructor.isUndefined) {
			fatalError("Event of type \(type) does not exists.")
		}

		let eventType = self.context.createString(event)
		let eventInit = self.context.createEmptyObject()

		for (name, value) in inits {

			if (value is String) {
				eventInit.property(name, string: value as! String)
				continue
			}

			if (value is Double) {
				eventInit.property(name, number: value as! Double)
				continue
			}

			if (value is Bool) {
				eventInit.property(name, boolean: value as! Bool)
				continue
			}
		}

		let instance = self.context.createReturnValue()
		constructor.construct([eventType, eventInit], result: instance)
		self.holder.callMethod("dispatchEvent", arguments: [instance])
	}
}
