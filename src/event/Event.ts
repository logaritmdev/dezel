import { Emitter } from './emitter'

/**
 * @symbol SENDER
 * @since 0.1.0
 */
export const SENDER = Symbol('sender')

/**
 * @symbol TARGET
 * @since 0.1.0
 */
export const TARGET = Symbol('target')

/**
 * @symbol CANCELED
 * @since 0.1.0
 */
export const CANCELED = Symbol('canceled')

/**
 * The event data interface.
 * @interface EventListener
 * @since 0.1.0
 */
export type EventListener = (event: any) => any | void

/**
 * The event options interface.
 * @interface EventOptions
 * @since 0.1.0
 */
export interface EventOptions<T extends any = any> {
	propagable?: boolean
	cancelable?: boolean
	data?: T
}

/**
 * An event being dispatched.
 * @class Event
 * @since 0.1.0
 */
export class Event<T extends any = any> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The event's type.
	 * @property type
	 * @since 0.1.0
	 */
	public readonly type: string

	/**
	 * Whether this event is propagable.
	 * @property propagable
	 * @since 0.1.0
	 */
	public readonly propagable: boolean

	/**
	 * Whether this event is cancelable.
	 * @property cancelable
	 * @since 0.1.0
	 */
	public readonly cancelable: boolean

	/**
	 * The initial emitter of the event.
	 * @property sender
	 * @since 0.1.0
	 */
	public get sender(): Emitter {
		return this[SENDER]!
	}

	/**
	 * The current emitter of the event.
	 * @property target
	 * @since 0.1.0
	 */
	public get target(): Emitter {
		return this[TARGET]!
	}

	/**
	 * Whether this event has been stopped.
	 * @property canceled
	 * @since 0.1.0
	 */
	public get canceled(): boolean {
		return this[CANCELED]
	}

	/**
	 * The event's data.
	 * @property data
	 * @since 0.1.0
	 */
	public readonly data: T

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the event.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(type: string, options: EventOptions<T> = {}) {

		type = type.toLowerCase()

		this.type = type
		this.data = options.data || {} as any
		this.propagable = options.propagable || false
		this.cancelable = options.cancelable || false

		this[CANCELED] = false
	}

	/**
	 * Cancels this event.
	 * @method cancel
	 * @since 0.1.0
	 */
	public cancel() {

		if (this.cancelable == false) {
			throw new Error(`
				Event error:
				This event cannot be stopped because it is not cancelable.
			`)
		}

		this[CANCELED] = true

		return this
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method setSender
	 * @since 0.1.0
	 * @hidden
	 */
	public setSender(sender?: Emitter) {
		this[SENDER] = sender
	}

	/**
	 * @method setTarget
	 * @since 0.1.0
	 * @hidden
	 */
	public setTarget(target?: Emitter) {
		this[TARGET] = target
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [SENDER]
	 * @since 0.1.0
	 * @hidden
	 */
	private [SENDER]?: Emitter | null

	/**
	 * @property [TARGET]
	 * @since 0.1.0
	 * @hidden
	 */
	private [TARGET]?: Emitter | null

	/**
	 * @property [CANCELED]
	 * @since 0.1.0
	 * @hidden
	 */
	private [CANCELED]: boolean
}
