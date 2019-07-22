import { Event } from './Event'

/**
 * Symbols
 */
export const LISTENERS = Symbol('listeners')

/**
 * @class EventTarget
 * @since 0.1.0
 * @hidden
 */
export class EventTarget {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method addEventListener
	 * @since 0.1.0
	 * @hidden
	 */
	public addEventListener(type: string, listener?: any, options?: any) {

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
	 * @method removeEventListener
	 * @since 0.1.0
	 * @hidden
	 */
	public removeEventListener(type: string, listener?: any, options?: any) {

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

	/**
	 * @method dispatchEvent
	 * @since 0.1.0
	 * @hidden
	 */
	public dispatchEvent(event: Event): boolean {

		let wat = this as any // TODO

		let callback = wat['on' + event.type]
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

	//--------------------------------------------------------------------------
	// Private api
	//--------------------------------------------------------------------------

	/**
	 * @property listeners
	 * @since 0.1.0
	 * @hidden
	 */
	private [LISTENERS]: any = {}
}
