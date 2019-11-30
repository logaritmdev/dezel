import { bound } from '../decorator/bound'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { EventListener } from '../event/Event'
import { TouchEvent } from '../touch/TouchEvent'
import { View } from '../view/View'
import { $callback } from './symbol/GestureDetector'
import { $captured } from './symbol/GestureDetector'
import { $resolved } from './symbol/GestureDetector'
import { $state } from './symbol/GestureDetector'
import { $view } from './symbol/GestureDetector'
import { GestureManager } from './GestureManager'

/**
 * @class GestureDetector
 * @super Emitter
 * @since 0.7.0
 */
export abstract class GestureDetector extends Emitter {

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

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(callback: GestureCallback, options: GestureOptions = {}) {
		super()
		this[$callback] = callback
		this.enabled = options.enabled != null ? options.enabled : true
		this.capture = options.capture != null ? options.capture : false
	}

	//--------------------------------------------------------------------------
	// Protected API
	//--------------------------------------------------------------------------

	/**
	 * @method ignore
	 * @since 0.7.0
	 */
	protected ignore() {
		return this.setState(State.Ignored)
	}

	/**
	 * @method detect
	 * @since 0.7.0
	 */
	protected detect() {
		return this.setState(State.Detected)
	}

	/**
	 * @method update
	 * @since 0.5.0
	 */
	protected update() {
		return this.setState(State.Updated)
	}

	/**
	 * @method finish
	 * @since 0.7.0
	 */
	protected finish() {
		return this.setState(State.Finished)
	}

	/**
	 * @method cancel
	 * @since 0.5.0
	 */
	protected cancel() {
		return this.setState(State.Canceled)
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @method onTouchStart
	 * @since 0.7.0
	 */
	protected onTouchStart(event: TouchEvent) {

	}

	/**
	 * @method onTouchMove
	 * @since 0.7.0
	 */
	protected onTouchMove(event: TouchEvent) {

	}

	/**
	 * @method onTouchEnd
	 * @since 0.7.0
	 */
	protected onTouchEnd(event: TouchEvent) {

	}

	/**
	 * @method onTouchCancel
	 * @since 0.7.0
	 */
	protected onTouchCancel(event: TouchEvent) {
		this.cancel()
	}

	/**
	 * @method onReset
	 * @since 0.7.0
	 */
	protected onReset() {

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
	 * @property $callback
	 * @since 0.7.0
	 * @hidden
	 */
	private [$callback]: GestureCallback

	/**
	 * @method setState
	 * @since 0.7.0
	 */
	private setState(state: State) {

		if (this.resolved) {

			throw new Error(
				`Gesture error: ` +
				`This gesture's state cannot be changed until it is reset.`
			)

		}

		if (this.state > state) {

			throw new Error(
				`Gesture error: ` +
				`This gesture's state cannot be changed to a lower value.`
			)

		}

		if (this.state == state &&
			this.state != State.Updated) {
			return this
		}

		this[$state] = state

		if (state == State.Ignored ||
			state == State.Canceled ||
			state == State.Finished) {

			this[$resolved] = true

		} else {

			if (state == State.Updated ||
				state == State.Detected) {
				this[$callback].call(null, this)
			}

		}

		return this
	}
}

/**
 * @interface GestureCallback
 * @since 0.7.0
 */
export type GestureCallback = (gesture: GestureDetector) => void

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