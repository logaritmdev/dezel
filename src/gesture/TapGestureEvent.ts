import { GestureEvent } from './GestureEvent'
import { GestureEventOptions } from './GestureEvent'

/**
 * The tap gesture event options.
 * @interface TapGestureEventOptions
 * @since 0.1.0
 */
export interface TapGestureEventOptions extends GestureEventOptions {

}

/**
 * The event received when a tap gesture is detected.
 * @class TapGestureEvent
 * @since 0.1.0
 */
export class TapGestureEvent extends GestureEvent {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the tap gesture event.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(type: string, options: TapGestureEventOptions) {
		super(type, options)
	}
}
