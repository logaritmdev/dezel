/**
 * Symbols
 */
export const LISTENERS = Symbol('listeners')

/**
 * @class Event
 * @since 0.1.0
 */
export class EventTarget {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method addEventListener
	 * @since 0.1.0
	 */
	addEventListener(type: string, listener?: EventListenerOrEventListenerObject, options?: boolean | AddEventListenerOptions) {

		let listeners = this[LISTENERS][type]
		if (listeners == null) {
			listeners = this[LISTENERS][type] = []
		}

		if (listeners.indexOf(listener) == -1) {
			listeners.push(listener)
		}

		return this
	}

	/**
	 * @method dispatchEvent
	 * @since 0.1.0
	 */
	dispatchEvent(event: Event): boolean {

		let callback = this['on' + event.type]
		if (callback) {
			callback.apply(this, arguments)
		}

		let listeners = this[LISTENERS][event.type]
		if (listeners == null) {
			return false
		}

		listeners = listeners.slice(0)

		for (let listener of listeners) {
			listener.call(event)
		}

		return true
	}

	/**
	 * @method removeEventListener
	 * @since 0.1.0
	 */
	removeEventListener(type: string, listener?: EventListenerOrEventListenerObject, options?: boolean | EventListenerOptions) {

		let listeners = this[LISTENERS][type]
		if (listeners == null) {
			return
		}

		let index = listeners.indexOf(listener)
		if (index > -1) {
			listeners.splice(index, 1)
		}

		if (listeners.length == 0) {
			delete this[LISTENERS][type]
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Private api
	//--------------------------------------------------------------------------

	/**
	 * @property listeners
	 * @since 0.1.0
	 */
	private [LISTENERS]: any = {}
}

/**
 * @global EventTarget
 * @since 0.1.0
 */
Object.defineProperty(self, "EventTarget", {
	value: EventTarget,
	writable: false,
	enumerable: false,
	configurable: true
})
