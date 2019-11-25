import { $cancelable } from './symbol/Event'
import { $canceled } from './symbol/Event'
import { $capturable } from './symbol/Event'
import { $captured } from './symbol/Event'
import { $data } from './symbol/Event'
import { $propagable } from './symbol/Event'
import { $sender } from './symbol/Event'
import { $stoppable } from './symbol/Event'
import { $stopped } from './symbol/Event'
import { $target } from './symbol/Event'
import { $type } from './symbol/Event'
import { Emitter } from './Emitter'

/**
 * @class Event
 * @since 0.1.0
 */
export class Event<T extends any = any> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property type
	 * @since 0.1.0
	 */
	public get type(): string {
		return this[$type]
	}

	/**
	 * @property propagable
	 * @since 0.1.0
	 */
	public get propagable(): boolean {
		return this[$propagable]
	}

	/**
	 * @property cancelable
	 * @since 0.1.0
	 */
	public get cancelable(): boolean {
		return this[$cancelable]
	}

	/**
	 * @property capturable
	 * @since 0.7.0
	 */
	public get capturable(): boolean {
		return this[$capturable]
	}

	/**
	 * @property stoppable
	 * @since 0.1.0
	 */
	public get stoppable(): boolean {
		return this[$stoppable]
	}

	/**
	 * @property canceled
	 * @since 0.1.0
	 */
	public get canceled(): boolean {
		return this[$canceled]
	}

	/**
	 * @property captured
	 * @since 0.7.0
	 */
	public get captured(): boolean {
		return this[$captured]
	}

	/**
	 * @property stopped
	 * @since 0.7.0
	 */
	public get stopped(): boolean {
		return this[$stopped]
	}

	/**
	 * @property target
	 * @since 0.1.0
	 */
	public get target(): Emitter {
		return this[$target]!
	}

	/**
	 * @property sender
	 * @since 0.1.0
	 */
	public get sender(): Emitter {
		return this[$sender]!
	}

	/**
	 * @property data
	 * @since 0.1.0
	 */
	public get data(): T {
		return this[$data]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(type: string, options: EventOptions<T> = {}) {
		this[$type] = type.toLowerCase()
		this[$data] = options.data || {} as any
		this[$propagable] = options.propagable || false
		this[$cancelable] = options.cancelable || false
		this[$capturable] = options.capturable || false
		this[$stoppable] = options.stoppable || true
	}

	/**
	 * @method cancel
	 * @since 0.1.0
	 */
	public cancel() {

		if (this.canceled) {
			return this
		}

		if (this.cancelable == false) {
			throw new Error(
				'Event error: ' +
				'This event cannot be canceled because it is not cancelable.'
			)
		}

		this[$canceled] = true

		return this
	}

	/**
	 * @method capture
	 * @since 0.1.0
	 */
	public capture() {

		if (this.captured) {
			return this
		}

		if (this.capturable == false) {
			throw new Error(
				'Event error: ' +
				'This event cannot be captured because it is not capturable.'
			)
		}

		this[$captured] = true

		this.retarget()

		return this
	}

	/**
	 * @method stop
	 * @since 0.7.0
	 */
	public stop() {

		if (this.stopped) {
			return this
		}

		if (this.stoppable == false) {
			throw new Error(
				'Event error: ' +
				'This event cannot be stopped because it is not stoppable.'
			)
		}

		this[$stopped] = true

		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $type
	 * @since 0.7.0
	 * @hidden
	 */
	private [$type]: string

	/**
	 * @property $propagable
	 * @since 0.7.0
	 * @hidden
	 */
	private [$propagable]: boolean = false

	/**
	 * @property $cancelable
	 * @since 0.7.0
	 * @hidden
	 */
	private [$cancelable]: boolean = false

	/**
	 * @property $capturable
	 * @since 0.7.0
	 * @hidden
	 */
	private [$capturable]: boolean = false

	/**
	 * @property $stoppable
	 * @since 0.7.0
	 * @hidden
	 */
	private [$stoppable]: boolean = false

	/**
	 * @property $canceled
	 * @since 0.7.0
	 * @hidden
	 */
	private [$canceled]: boolean = false

	/**
	 * @property $captured
	 * @since 0.7.0
	 * @hidden
	 */
	private [$captured]: boolean = false

	/**
	 * @property $stopped
	 * @since 0.7.0
	 * @hidden
	 */
	private [$stopped]: boolean = false

	/**
	 * @property $target
	 * @since 0.7.0
	 * @hidden
	 */
	private [$target]: Emitter | null = null

	/**
	 * @property $sender
	 * @since 0.7.0
	 * @hidden
	 */
	private [$sender]: Emitter | null = null

	/**
	 * @property $data
	 * @since 0.7.0
	 * @hidden
	 */
	private [$data]: T

	/**
	 * @method retarget
	 * @since 0.7.0
	 * @hidden
	 */
	protected retarget() {
		this[$target] = this[$sender]
		return this
	}
}

/**
 * @interface EventOptions
 * @since 0.1.0
 */
export interface EventOptions<T extends any = any> {
	propagable?: boolean
	cancelable?: boolean
	capturable?: boolean
	stoppable?: boolean
	data?: T
}

/**
 * @interface EventListener
 * @since 0.1.0
 */
export type EventListener = (event: any) => any | void
