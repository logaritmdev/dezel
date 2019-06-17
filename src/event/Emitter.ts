import { Dictionary } from 'lodash'
import { Event } from './Event'
import { EventListener } from './Event'
import { EventOptions } from './Event'

/**
 * @symbol RESPONDER
 * @since 0.4.0
 */
export const RESPONDER = Symbol('responder')

/**
 * @symbol LISTENERS
 * @since 0.4.0
 */
export const LISTENERS = Symbol('listeners')

/**
 * Manages event listening and dispatching.
 * @class Emitter
 * @since 0.1.0
 */
export class Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The emitter that responds to a bubbled event.
	 * @property responder
	 * @since 0.1.0
	 */
	public get responder(): Emitter | null | undefined {
		return this[RESPONDER]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Prepare this emitter to be garbage collected.
	 * @method destroy
	 * @since 0.1.0
	 */
	public destroy() {
		this[RESPONDER] = null
		this[LISTENERS] = {}
	}

	/**
	 * Add an event handler for a specified event.
	 * @method on
	 * @since 0.1.0
	 */
	public on(type: string, listener: EventListener) {
		insertListener(this, type.toLowerCase(), listener)
		return this
	}

	/**
	 * Add an event handler for a specified event that will be run only once.
	 * @method one
	 * @since 0.7.0
	 */
	public one(type: string, listener: EventListener) {
		insertListener(this, type.toLowerCase(), listener, true)
		return this
	}

	/**
	 * Remove an event handler for a specified event.
	 * @method off
	 * @since 0.1.0
	 */
	public off(type: string, listener: EventListener) {
		removeListener(this, type.toLowerCase(), listener)
		return this
	}

	/**
	 * Emits and event to the eventListeners.
	 * @method emit
	 * @since 0.1.0
	 */
	public emit<T extends any = any>(event: Event | string, options: EventOptions<T> = {}) {

		if (typeof event == 'string') {

			event = new Event<T>(event, {
				propagable: options.propagable,
				cancelable: options.cancelable,
				data: options.data
			})

		}

		event.setTarget(this)
		event.setSender(this)

		this.dispatch(event)

		return this
	}

	/**
	 * Called before the event is emited to its listener.
	 * @method onEmit
	 * @since 0.1.0
	 */
	public onEmit(event: Event) {

	}

	/**
	 * Called once the event has been dispatched.
	 * @method onDispatch
	 * @since 0.1.0
	 */
	public onDispatch(event: Event) {

	}

	/**
	 * Called when a property receives a new value.
	 * @method onPropertyChange
	 * @since 0.4.0
	 */
	public onPropertyChange(property: string, newValue: any, oldValue: any) {

	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method setResponder
	 * @since 0.4.0
	 * @hidden
	 */
	public setResponder(responder: Emitter | null | undefined) {
		this[RESPONDER] = responder
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [RESPONDER]
	 * @since 0.4.0
	 * @hidden
	 */
	private [RESPONDER]: Emitter | null | undefined

	/**
	 * @property [LISTENERS]
	 * @since 0.4.0
	 * @hidden
	 */
	private [LISTENERS]: Dictionary<Array<Function>> = {}

	/**
	 * @method dispatch
	 * @since 0.1.0
	 * @hidden
	 */
	private dispatch(event: Event) {

		event.setSender(this)

		this.onEmit(event)

		if (event.canceled == false) {
			issue(this, event)
		}

		this.onDispatch(event)

		if (event.canceled ||
			event.propagable == false) {
			return
		}

		if (this.responder) {
			this.responder.dispatch(event)
		}
	}
}

/**
 * @function insertListener
 * @since 0.7.0
 * @hidden
 */
function insertListener(emitter: Emitter, type: string, listener: EventListener, one: boolean = false) {

	let listeners = emitter[LISTENERS][type]
	if (listeners == null) {
		listeners = emitter[LISTENERS][type] = []
	}

	if (one) {

		function callback(event: Event) {

			if (emitter) {
				emitter.off(type, callback)
			}

			listener(event)
		}

		listeners.push(callback)

	} else {

		listeners.push(listener)

	}
}

/**
 * @function removeListener
 * @since 0.7.0
 * @hidden
 */
function removeListener(emitter: Emitter, type: string, listener: EventListener) {

	let listeners = emitter[LISTENERS][type]
	if (listeners == null) {
		return
	}

	let index = listeners.indexOf(listener)
	if (index > -1) {
		listeners.splice(index, 1)
	}
}

/**
 * @function issue
 * @since 0.7.0
 * @hidden
 */
function issue(emitter: Emitter, event: Event) {

	let listeners = emitter[LISTENERS][event.type]
	if (listeners == null) {
		return
	}

	for (let listener of listeners) {
		listener.call(
			emitter,
			event
		)
	}
}