import { $listeners } from './private/Emitter'
import { $responder } from './private/Emitter'
import { $sender } from './private/Event'
import { $target } from './private/Event'
import { dispatchEvent } from './private/Emitter'
import { insertListener } from './private/Emitter'
import { removeListener } from './private/Emitter'
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
		insertListener(this, type, listener as any)
		return this
	}

	/**
	 * @method one
	 * @since 0.7.0
	 */
	public one(type: string, listener: EventListener) {
		insertListener(this, type, listener, true)
		return this
	}

	/**
	 * @method off
	 * @since 0.1.0
	 */
	public off(type: string, listener: EventListener) {
		removeListener(this, type, listener)
		return this
	}

	/**
	 * @method emit
	 * @since 0.1.0
	 */
	public emit<T extends any = any>(event: Event | string, options: EventOptions<T> = {}) {

		if (typeof event == 'string') {
			event = new Event<T>(event, options)
		}

		event[$target] = this
		event[$sender] = this

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
