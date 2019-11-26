import { $listeners } from './symbol/EventTarget'
import { Event } from './Event'

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

		let listeners = this[$listeners][type]
		if (listeners == null) {
			listeners = this[$listeners][type] = []
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

		let listeners = this[$listeners][type]
		if (listeners == null) {
			return
		}

		let index = listeners.indexOf(listener)
		if (index > -1) {
			listeners.splice(index, 1)
		}

		if (listeners.length == 0) {
			delete this[$listeners][type]
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

		let listeners = this[$listeners][event.type]
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
	private [$listeners]: any = {}
}
