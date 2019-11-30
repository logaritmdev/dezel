import { $cancelable } from './symbol/Event'
import { $canceled } from './symbol/Event'
import { $capturable } from './symbol/Event'
import { $captured } from './symbol/Event'
import { $data } from './symbol/Event'
import { $propagable } from './symbol/Event'
import { $sender } from './symbol/Event'
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
	 * @property capturable
	 * @since 0.7.0
	 */
	public get capturable(): boolean {
		return this[$capturable]
	}

	/**
	 * @property cancelable
	 * @since 0.1.0
	 */
	public get cancelable(): boolean {
		return this[$cancelable]
	}

	/**
	 * @property captured
	 * @since 0.7.0
	 */
	public get captured(): boolean {
		return this[$captured]
	}

	/**
	 * @property canceled
	 * @since 0.1.0
	 */
	public get canceled(): boolean {
		return this[$canceled]
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
		this[$propagable] = options.propagable != null ? options.propagable : false
		this[$capturable] = options.capturable != null ? options.capturable : false
		this[$cancelable] = options.cancelable != null ? options.cancelable : false
	}

	/**
	 * @method capture
	 * @since 0.7.0
	 */
	public capture() {

		if (this.captured ||
			this.canceled) {
			return this
		}

		if (this.capturable == false) {

			throw new Error(
				`Event error: ` +
				`This event cannot be captured because it is not capturable.`
			)

		}

		this[$captured] = true

		this.onCapture()

		return this
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
				`Event error: ` +
				`This event cannot be canceled because it is not cancelable.`
			)

		}

		this[$canceled] = true

		this.onCancel()

		return this
	}

	//--------------------------------------------------------------------------
	// Protected API
	//--------------------------------------------------------------------------

	/**
	 * @method onCancel
	 * @since 0.7.0
	 */
	protected onCancel() {

	}

	/**
	 * @method onCapture
	 * @since 0.7.0
	 */
	protected onCapture() {

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
}

/**
 * @interface EventOptions
 * @since 0.1.0
 */
export interface EventOptions<T extends any = any> {
	propagable?: boolean
	cancelable?: boolean
	capturable?: boolean
	data?: T
}

/**
 * @type EventListener
 * @since 0.1.0
 */
export type EventListener = (event: any) => void

/**
 * @type EventListeners
 * @since 0.1.0
 */
export type EventListeners = Array<EventListener>