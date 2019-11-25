import { Dictionary } from 'lodash'
import { setEventSender } from './private/Event'
import { setEventTarget } from './private/Event'
import { $listeners } from './symbol/Emitter'
import { $responder } from './symbol/Emitter'
import { Event } from './Event'
import { EventListener } from './Event'
import { EventOptions } from './Event'

/**
 * @class Emitter
 * @since 0.1.0
 */
export class Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property responder
	 * @since 0.1.0
	 */
	public get responder(): Emitter | null {
		return this[$responder]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method destroy
	 * @since 0.1.0
	 */
	public destroy() {
		this[$responder] = null
		this[$listeners] = {}
		return this
	}

	/**
	 * @method on
	 * @since 0.1.0
	 */
	public on(type: string, listener: EventListener) {
		insertItem(this, type, listener)
		return this
	}

	/**
	 * @method one
	 * @since 0.7.0
	 */
	public one(type: string, listener: EventListener) {
		insertItem(this, type, listener, true)
		return this
	}

	/**
	 * @method off
	 * @since 0.1.0
	 */
	public off(type: string, listener: EventListener) {
		removeItem(this, type, listener)
		return this
	}

	/**
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

		setEventTarget(event, this)
		setEventSender(event, this)

		dispatchEvent(this, event)

		return this
	}

	/**
	 * @method onEvent
	 * @since 0.7.0
	 */
	public onEvent(event: Event) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $responder
	 * @since 0.7.0
	 * @hidden
	 */
	private [$responder]: Emitter | null = null

	/**
	 * @property $listeners
	 * @since 0.7.0
	 * @hidden
	 */
	private [$listeners]: Dictionary<Array<Function>> = {}
}


/**
 * @function insertItem
 * @since 0.7.0
 * @hidden
 */
function insertItem(emitter: Emitter, type: string, listener: EventListener, one: boolean = false) {

	type = type.toLowerCase()

	let listeners = emitter[$listeners][type]
	if (listeners == null) {
		listeners = emitter[$listeners][type] = []
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
 * @function removeItem
 * @since 0.7.0
 * @hidden
 */
function removeItem(emitter: Emitter, type: string, listener: EventListener) {

	type = type.toLowerCase()

	let listeners = emitter[$listeners][type]
	if (listeners == null) {
		return
	}

	let index = listeners.indexOf(listener)
	if (index > -1) {
		listeners.splice(index, 1)
	}
}

/**
 * @function dispatchEvent
 * @since 0.7.0
 * @hidden
 */
function dispatchEvent(sender: Emitter, event: Event) {

	setEventSender(event, sender)

	sender.onEvent(event)

	if (event.stopped ||
		event.canceled ||
		event.captured) {
		return
	}

	invokeListeners(sender, event)

	if (event.stopped ||
		event.canceled ||
		event.captured) {
		return
	}

	if (event.propagable == false) {
		return
	}

	let responder = sender.responder
	if (responder) {
		dispatchEvent(responder, event)
	}
}

/**
 * @function invokeListeners
 * @since 0.7.0
 * @hidden
 */
function invokeListeners(sender: Emitter, event: Event) {
	let listeners = sender[$listeners][event.type]
	if (listeners) {
		listeners.forEach(listener => {
			listener.call(null, event)
		})
	}
}