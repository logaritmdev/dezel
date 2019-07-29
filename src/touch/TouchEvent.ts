import { Emitter } from '../event/Emitter'
import { LISTENERS } from '../event/Emitter'
import { Event } from '../event/Event'
import { EventOptions } from '../event/Event'
import { Touch } from './Touch'
import { TouchList } from './TouchList'

/**
 * The touch event options.
 * @interface TouchEventInit
 * @since 0.1.0
 */
export interface TouchEventOptions extends EventOptions {
	touches: TouchList
	activeTouches: TouchList
	targetTouches: TouchList
	dispatcher: object
}

/**
 * @symbol CAPTURED
 * @since 0.5.0
 */
export const CAPTURED = Symbol('captured')

/**
 * @symbol RECEIVER
 * @since 0.5.0
 */
export const RECEIVER = Symbol('receiver')

/**
 * A touch event.
 * @class TouchEvent
 * @super Event
 * @since 0.1.0
 */
export class TouchEvent extends Event<any> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The touches affected by this event.
	 * @property touches
	 * @since 0.1.0
	 */
	public readonly touches: TouchList

	/**
	 * The active touches.
	 * @property activeTouches
	 * @since 0.1.0
	 */
	public readonly activeTouches: TouchList

	/**
	 * The active from the initial target.
	 * @property targetTouches
	 * @since 0.1.0
	 */
	public readonly targetTouches: TouchList

	/**
	 * The emitter responsible to creating the event.
	 * @property dispatcher
	 * @since 0.5.0
	 */
	public readonly dispatcher: object

	/**
	 * Whether this touch event has been captured.
	 * @property captured
	 * @since 0.5.0
	 */
	public get captured(): boolean {
		return this[CAPTURED]
	}

	/**
	 * The receiver for future touch event after being captured.
	 * @property receiver
	 * @since 0.5.0
	 */
	public get receiver(): Emitter | null {
		return this[RECEIVER]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the touch event.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(type: string, options: TouchEventOptions) {
		super(type, options)
		this.touches = options.touches
		this.activeTouches = options.activeTouches
		this.targetTouches = options.targetTouches
		this.dispatcher = options.dispatcher
	}

	/**
	 * Send the following touch event to this event's sender.
	 * @method capture
	 * @since 0.5.0
	 */
	public capture() {

		if (this.type != 'touchstart' &&
			this.type != 'touchmove') {
			return
		}

		if (this[CAPTURED] == false) {

			this[RECEIVER] = this.sender
			this[CAPTURED] = true

			if (this.type == 'touchmove') {

				/*
				 * Only touchmove event are canceled (stopped). When a
				 * touchstart event is captured, the event will first bubble
				 * otherwise the touchcancel event that is emitted after will
				 * make no sense because for some views it will not have been
				 * preceded by a touchstart.
				 */

				this.cancel()
			}
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [CAPTURED]
	 * @since 0.5.0
	 * @hidden
	 */
	private [CAPTURED]: boolean = false

	/**
	 * @property [RECEIVER]
	 * @since 0.5.0
	 * @hidden
	 */
	private [RECEIVER]: Emitter | null = null
}
