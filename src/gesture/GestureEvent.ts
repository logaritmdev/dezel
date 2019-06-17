import { Event } from '../event/Event'
import { EventOptions } from '../event/Event'
import { Gesture } from '../gesture/Gesture'
import { Touch } from '../touch/Touch'
import { TouchList } from '../touch/TouchList'

/**
 * @symbol TOUCHES
 * @since 0.7.0
 */
export const TOUCHES = Symbol('touches')

/**
 * @symbol GESTURE
 * @since 0.7.0
 */
export const GESTURE = Symbol('gesture')

/**
 * The gesture event options.
 * @interface GestureEventOptions
 * @since 0.1.0
 */
export interface GestureEventOptions extends EventOptions {

}

/**
 * The base class for gesture events.
 * @class GestureEvent
 * @since 0.1.0
 */
export class GestureEvent<T = any> extends Event<T> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The gesture event's name.
	 * @property name
	 * @since 0.7.0
	 */
	public get name(): string {
		return this.gesture.name
	}

	/**
	 * The gesture event's detector.
	 * @property gesture
	 * @since 0.7.0
	 */
	public get gesture(): Gesture {
		return this[GESTURE]
	}

	/**
	 * The gesture event's touches.
	 * @property touches
	 * @since 0.1.0
	 */
	public get touches(): TouchList {
		return this[TOUCHES]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the touch event.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(type: string, gesture: Gesture, touches: TouchList, options: GestureEventOptions) {
		super(type, options)
		this[GESTURE] = gesture
		this[TOUCHES] = touches
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property PRESENTER
	 * @since 0.7.0
	 * @hidden
	 */
	private [GESTURE]: Gesture

	/**
	 * @property PRESENTEE
	 * @since 0.7.0
	 * @hidden
	 */
	private [TOUCHES]: TouchList
}
