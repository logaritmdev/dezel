import { GestureEvent } from './GestureEvent'
import { GestureEventOptions } from './GestureEvent'

/**
 * The tap gesture event options.
 * @interface PanGestureEventOptions
 * @since 0.1.0
 */
export interface PanGestureEventOptions extends GestureEventOptions {
	x: number
	y: number
	viewX: number
	viewY: number
}

/**
 * @symbol X
 * @since 0.1.0
 */
export const X = Symbol('x')

/**
 * @symbol Y
 * @since 0.1.0
 */
export const Y = Symbol('y')

/**
 * @symbol VIEW_OFFSET_X
 * @since 0.4.0
 */
export const VIEW_X = Symbol('viewX')

/**
 * @symbol VIEW_OFFSET_Y
 * @since 0.4.0
 */
export const VIEW_Y = Symbol('viewY')

/**
 * The event received when a tap gesture is detected.
 * @class PanGestureEvent
 * @since 0.1.0
 */
export class PanGestureEvent extends GestureEvent {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The pan movement on the x axis.
	 * @property x
	 * @since 0.1.0
	 */
	public get x(): number {
		return this[X]
	}

	/**
	 * The pan movement on the y axis.
	 * @property y
	 * @since 0.1.0
	 */
	public get y(): number {
		return this[Y]
	}

	/**
	 * The position on the x axis that the view would be.
	 * @property viewX
	 * @since 0.4.0
	 */
	public get viewX(): number {
		return this[VIEW_X]
	}

	/**
	 * The position on the y axis that the view would be.
	 * @property viewY
	 * @since 0.4.0
	 */
	public get viewY(): number {
		return this[VIEW_Y]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the tap gesture event.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(type: string, options: PanGestureEventOptions) {
		super(type, options)
		this[X] = options.x
		this[Y] = options.y
		this[VIEW_X] = options.viewX
		this[VIEW_Y] = options.viewY
	}


	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [X]
	 * @since 0.1.0
	 * @hidden
	 */
	private [X]: number = 0

	/**
	 * @property [Y]
	 * @since 0.1.0
	 * @hidden
	 */
	private [Y]: number = 0

	/**
	 * @property [VIEW_X]
	 * @since 0.4.0
	 * @hidden
	 */
	private [VIEW_X]: number = 0

	/**
	 * @property [VIEW_Y]
	 * @since 0.4.0
	 * @hidden
	 */
	private [VIEW_Y]: number = 0
}
