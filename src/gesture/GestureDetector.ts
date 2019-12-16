import { $callback } from './private/GestureDetector'
import { $canceled } from './private/GestureDetector'
import { $captured } from './private/GestureDetector'
import { $detected } from './private/GestureDetector'
import { $duration } from './private/GestureDetector'
import { $finished } from './private/GestureDetector'
import { $resolved } from './private/GestureDetector'
import { $state } from './private/GestureDetector'
import { $view } from './private/GestureDetector'
import { setGestureState } from './private/GestureDetector'
import { Emitter } from '../event/Emitter'
import { TouchEvent } from '../event/TouchEvent'
import { View } from '../view/View'

/**
 * @class GestureDetector
 * @super Emitter
 * @since 0.7.0
 */
export abstract class GestureDetector<T = any> extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property enabled
	 * @since 0.7.0
	 */
	public enabled: boolean = true

	/**
	 * @property capture
	 * @since 0.7.0
	 */
	public capture: boolean = false

	/**
	 * @property view
	 * @since 0.7.0
	 */
	public get view(): View | null {
		return this[$view]
	}

	/**
	 * @property state
	 * @since 0.7.0
	 */
	public get state(): State {
		return this[$state]
	}

	/**
	 * @property captured
	 * @since 0.7.0
	 */
	public get captured(): boolean {
		return this[$captured]
	}

	/**
	 * @property resolved
	 * @since 0.7.0
	 */
	public get resolved(): boolean {
		return this[$resolved]
	}

	/**
	 * @property duration
	 * @since 0.7.0
	 */
	public get duration(): number {
		return this[$duration]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(callback: GestureCallback<T>, options: GestureOptions = {}) {

		super()

		let opts = Object.assign(
			{},
			OPTIONS,
			options
		)

		this.enabled = opts.enabled
		this.capture = opts.capture

		this[$callback] = callback
	}

	/**
	 * @method attach
	 * @since 0.7.0
	 */
	public attach(view: View) {
		this[$view] = view
	}

	/**
	 * @method detach
	 * @since 0.7.0
	 */
	public detach() {
		this[$view] = null
	}

	/**
	 * @method ignore
	 * @since 0.7.0
	 */
	public ignore() {
		return setGestureState<T>(this, State.Ignored)
	}

	/**
	 * @method detect
	 * @since 0.7.0
	 */
	public detect() {
		return setGestureState<T>(this, State.Detected)
	}

	/**
	 * @method update
	 * @since 0.5.0
	 */
	public update() {
		return setGestureState<T>(this, State.Updated)
	}

	/**
	 * @method finish
	 * @since 0.7.0
	 */
	public finish() {
		return setGestureState<T>(this, State.Finished)
	}

	/**
	 * @method cancel
	 * @since 0.5.0
	 */
	public cancel() {
		return setGestureState<T>(this, State.Canceled)
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @method onTouchStart
	 * @since 0.7.0
	 */
	public onTouchStart(event: TouchEvent) {

	}

	/**
	 * @method onTouchMove
	 * @since 0.7.0
	 */
	public onTouchMove(event: TouchEvent) {

	}

	/**
	 * @method onTouchEnd
	 * @since 0.7.0
	 */
	public onTouchEnd(event: TouchEvent) {

	}

	/**
	 * @method onTouchCancel
	 * @since 0.7.0
	 */
	public onTouchCancel(event: TouchEvent) {
		this.cancel()
	}

	/**
	 * @method onReset
	 * @since 0.7.0
	 */
	public onReset() {

	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method dispatchTouchEvent
	 * @since 0.7.0
	 * @hidden
	 */
	public dispatchTouchEvent(event: TouchEvent) {

		switch (event.type) {

			case 'touchstart':
				this.onTouchStart(event)
				break

			case 'touchmove':
				this.onTouchMove(event)
				break

			case 'touchend':
				this.onTouchEnd(event)
				break

			case 'touchcancel':
				this.onTouchCancel(event)
				break
		}

		return this
	}

	/**
	 * @method captureTouchEvent
	 * @since 0.7.0
	 * @hidden
	 */
	public captureTouchEvent(event: TouchEvent) {

		if (this[$captured] == false) {
			this[$captured] = true
			event.capture()
		}

		return this
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public reset() {

		this[$state] = State.Allowed
		this[$captured] = false
		this[$resolved] = false
		this[$detected] = -1
		this[$canceled] = -1
		this[$finished] = -1

		this.onReset()

		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $view
	 * @since 0.7.0
	 * @hidden
	 */
	private [$view]: View | null = null

	/**
	 * @property $state
	 * @since 0.7.0
	 * @hidden
	 */
	private [$state]: State = State.Allowed

	/**
	 * @property $captured
	 * @since 0.7.0
	 * @hidden
	 */
	private [$captured]: boolean = false

	/**
	 * @property $resolved
	 * @since 0.7.0
	 * @hidden
	 */
	private [$resolved]: boolean = false

	/**
	 * @property $duration
	 * @since 0.7.0
	 * @hidden
	 */
	private [$duration]: number = -1

	/**
	 * @property $callback
	 * @since 0.7.0
	 * @hidden
	 */
	private [$callback]: GestureCallback<T>

	/**
	 * @property $detectTime
	 * @since 0.7.0
	 * @hidden
	 */
	private [$detected]: number = 0

	/**
	 * @property $cancelTime
	 * @since 0.7.0
	 * @hidden
	 */
	private [$canceled]: number = 0

	/**
	 * @property $finishTime
	 * @since 0.7.0
	 * @hidden
	 */
	private [$finished]: number = 0
}

/**
 * @const OPTIONS
 * @since 0.7.0
 * @hidden
 */
const OPTIONS: Required<GestureOptions> = {
	enabled: true,
	capture: false
}

/**
 * @interface GestureCallback
 * @since 0.7.0
 */
export type GestureCallback<T> = (gesture: T) => void

/**
 * @interface GestureOptions
 * @since 0.7.0
 */
export interface GestureOptions {
	enabled?: boolean
	capture?: boolean
}

/**
 * @interface GestureState
 * @since 0.7.0
 */
export enum State {
	Allowed,
	Ignored,
	Detected,
	Updated,
	Canceled,
	Finished
}