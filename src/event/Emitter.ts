import { $listeners } from './symbol/Emitter'
import { $responder } from './symbol/Emitter'
import { dispatchEvent } from './private/Emitter'
import { insertEventListener } from './private/Emitter'
import { removeEventListener } from './private/Emitter'
import { setEventSender } from './private/Event'
import { setEventTarget } from './private/Event'
import { Event } from './Event'
import { EventListener } from './Event'
import { EventListeners } from './Event'
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
		insertEventListener(this, type, listener as any)
		return this
	}

	/**
	 * @method one
	 * @since 0.7.0
	 */
	public one(type: string, listener: EventListener) {
		insertEventListener(this, type, listener as any, true)
		return this
	}

	/**
	 * @method off
	 * @since 0.1.0
	 */
	public off(type: string, listener: EventListener) {
		removeEventListener(this, type, listener as any)
		return this
	}

	/**
	 * @method emit
	 * @since 0.1.0
	 */
	public emit<T extends any = any>(event: Event | string, options: EventOptions<T> = {}) {

		if (typeof event == 'string') {

			let opts = Object.assign(
				{},
				OPTIONS,
				options
			)

			event = new Event<T>(event, {
				propagable: opts.propagable,
				cancelable: opts.cancelable,
				capturable: opts.capturable,
				data: opts.data
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
	private [$listeners]: Dictionary<EventListeners> = {}
}

/**
 * @const OPTIONS
 * @since 0.9.0
 */
const OPTIONS: Required<EventOptions> = {
	propagable: false,
	cancelable: false,
	capturable: false,
	data: {} as any
}