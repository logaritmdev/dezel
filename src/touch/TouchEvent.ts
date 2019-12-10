import { $activeTouches } from './symbol/TouchEvent'
import { $targetTouches } from './symbol/TouchEvent'
import { $touches } from './symbol/TouchEvent'
import { setTouchCanceled } from './private/Touch'
import { setTouchCaptured } from './private/Touch'
import { Event } from '../event/Event'
import { EventOptions } from '../event/Event'
import { View } from '../view/View'
import { TouchList } from './TouchList'

/**
 * @class TouchEvent
 * @super Event
 * @since 0.1.0
 */
export class TouchEvent extends Event<any> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property touches
	 * @since 0.1.0
	 */
	public get touches(): TouchList {
		return this[$touches]
	}

	/**
	 * @property activeTouches
	 * @since 0.1.0
	 */
	public get activeTouches(): TouchList {
		return this[$activeTouches]
	}

	/**
	 * @property targetTouches
	 * @since 0.1.0
	 */
	public get targetTouches(): TouchList {
		return this[$targetTouches]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(type: string, options: TouchEventOptions) {
		super(type, options)
		this[$touches] = options.touches
		this[$activeTouches] = options.activeTouches
		this[$targetTouches] = options.targetTouches
	}

	/**
	 * @method hits
	 * @since 0.4.0
	 */
	public hits(view: View) {
		return this.touches.hits(view)
	}

	//--------------------------------------------------------------------------
	// Protected API
	//--------------------------------------------------------------------------

	/**
	 * @method onCancel
	 * @since 0.7.0
	 */
	protected onCancel() {
		for (let touch of this.touches) {
			setTouchCanceled(touch, true)
		}
	}

	/**
	 * @method onCapture
	 * @since 0.7.0
	 */
	protected onCapture() {
		for (let touch of this.touches) {
			setTouchCaptured(touch, true)
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $touches
	 * @since 0.7.0
	 * @hidden
	 */
	private [$touches]: TouchList

	/**
	 * @property $activeTouches
	 * @since 0.7.0
	 * @hidden
	 */
	private [$activeTouches]: TouchList

	/**
	 * @property $targetTouches
	 * @since 0.7.0
	 * @hidden
	 */
	private [$targetTouches]: TouchList
}

/**
 * @interface TouchEventOptions
 * @since 0.1.0
 */
export interface TouchEventOptions extends EventOptions {
	touches: TouchList
	activeTouches: TouchList
	targetTouches: TouchList
}