import { Event } from '../event/Event'
import { EventOptions } from '../event/Event'
import { Touch } from '../touch/Touch'
import { TouchList } from '../touch/TouchList'

/**
 * The gesture event options.
 * @interface GestureEventOptions
 * @since 0.1.0
 */
export interface GestureEventOptions extends EventOptions {
	touches: TouchList
}

/**
 * The base class for gesture events.
 * @class GestureEvent
 * @since 0.1.0
 */
export abstract class GestureEvent extends Event<any> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The touches affected by this event.
	 * @property touches
	 * @since 0.1.0
	 */
	public readonly touches: TouchList

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the touch event.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(type: string, options: GestureEventOptions) {
		super(type, options)
		this.touches = options.touches
	}
}
