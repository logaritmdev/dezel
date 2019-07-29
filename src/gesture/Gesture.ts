import { bound } from '../decorator/bound'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { EventListener } from '../event/Event'
import { TouchEvent } from '../touch/TouchEvent'
import { View } from '../view/View'
import { GestureEvent } from './GestureEvent'

/**
 * @symbol VIEW
 * @since 0.1.0
 */
export const VIEW = Symbol('view')

/**
 * @symbol EVENT
 * @since 0.7.0
 */
export const EVENT = Symbol('event')

/**
 * @symbol DETECTED
 * @since 0.1.0
 */
export const DETECTED = Symbol('detected')

/**
 * @symbol CAPTURED
 * @since 0.1.0
 */
export const CAPTURED = Symbol('captured')

/**
 * @symbol CAPTURED_EVENT
 * @since 0.7.0
 */
export const CAPTURED_EVENT = Symbol('capturedEvent')

/**
 * The gesture options.
 * @interface GestureOptions
 * @since 0.1.0
 */
export interface GestureOptions {
	enabled?: boolean
	capture?: boolean
}

/**
 * The base class for gesture detection.
 * @class Gesture
 * @super Emitter
 * @since 0.1.0
 */
export abstract class Gesture extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the gesture is enabled.
	 * @property enabled
	 * @since 0.1.0
	 */
	public enabled: boolean = true

	/**
	 * Whether touches will be captured when this gesture is detected.
	 * @property capture
	 * @since 0.1.0
	 */
	public capture: boolean = false

	/**
	 * The gesture's view.
	 * @property view
	 * @since 0.1.0
	 */
	public get view(): View | null {
		return this[VIEW]
	}

	/**
	 * The event being processed by the gesture.
	 * @property event
	 * @since 0.7.0
	 */
	public get event(): TouchEvent | null {
		return this[EVENT]
	}

	/**
	 * Whether the gesture has been detected.
	 * @property detected
	 * @since 0.1.0
	 */
	public get detected(): boolean {
		return this[DETECTED]
	}

	/**
	 * Whether the gesture has been capture.
	 * @property captured
	 * @since 0.1.0
	 */
	public get captured(): boolean {
		return this[CAPTURED]
	}

	/**
	 * The event that has been captured.
	 * @property capturedEvent
	 * @since 0.7.0
	 */
	public get capturedEvent(): TouchEvent | null {
		return this[CAPTURED_EVENT]
	}

	/**
	 * The gesture's name.
	 * @property view
	 * @since 0.1.0
	 */
	public abstract get name(): string

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(options: GestureOptions = {}) {
		super()
		this.enabled = 'enabled' in options ? !!options.enabled : true
		this.capture = 'capture' in options ? !!options.capture : false
	}

	/**
	 * Indicates that the gestion has started.
	 * @method start
	 * @since 0.7.0
	 */
	protected start(data: any = undefined) {

		if (this.detected) {
			throw new Error(
				'Gesture error: ' +
				'Gesture has already begun. Did you forget to call finish() ?'
			)
		}

		if (this.view == null) {
			throw new Error(
				'Gesture error: ' +
				'The gestures has no view.'
			)
		}

		this.view.emit(new GestureEvent('gesturestart', this, this.event!.touches, { data }))

		this[DETECTED] = true
		this[CAPTURED] = false

		this.captureEvent()

		return this
	}

	/**
	 * Indicates that the gesture has been detected.
	 * @method detect
	 * @since 0.5.0
	 */
	protected detect(data: any = undefined) {

		if (this.detected == false) {
			throw new Error(`
				Gesture Error :
				Gesture has not begun. Did you forget to call begin() ?
			`)
		}

		if (this.view == null) {
			throw new Error(
				'Gesture error: \n' +
				'The gestures has no view.'
			)
		}

		this.captureEvent()

		this.view.emit(new GestureEvent('gesturedetect', this, this.event!.touches, { data }))

		return this
	}

	/**
	 * Indicates that the gesture has ended.
	 * @method end
	 * @since 0.7.0
	 */
	protected end(data: any = undefined) {

		if (this.detected == false) {
			throw new Error(`
				Gesture error:
				Gesture has not begun. Did you forget to call begin() ?
			`)
		}

		if (this.view == null) {
			throw new Error(
				'Gesture error: \n' +
				'The gestures has no view.'
			)
		}

		this.view.emit(new GestureEvent('gestureend', this, this.event!.touches, { data }))

		this[DETECTED] = false
		this[CAPTURED] = false

		return this
	}

	/**
	 * Indicates that the gesture has been canceled.
	 * @method cancel
	 * @since 0.5.0
	 */
	protected cancel(data: any = undefined) {

		if (this.detected == false) {
			throw new Error(`
				Gesture error:
				Gesture has not begun. Did you forget to call begin() ?
			`)
		}

		if (this.view == null) {
			throw new Error(
				'Gesture error: \n' +
				'The gestures has no view.'
			)
		}

		this.view.emit(new GestureEvent('gesturecancel', this, this.event!.touches, { data }))

		this[DETECTED] = false
		this[CAPTURED] = false

		return this
	}

	/**
	 * Called when a touch cancel event occurs.
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	protected onTouchCancel(event: TouchEvent) {

	}

	/**
	 * Called when a touch start event occurs.
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	protected onTouchStart(event: TouchEvent) {

	}

	/**
	 * Called when a touch move event occurs.
	 * @method onTouchMove
	 * @since 0.1.0
	 */
	protected onTouchMove(event: TouchEvent) {

	}

	/**
	 * Called when a touch end event occurs.
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	protected onTouchEnd(event: TouchEvent) {

	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method setView
	 * @since 0.7.0
	 * @hidden
	 */
	public setView(view: View | null) {
		this[VIEW] = view
	}

	/**
	 * @method dispatchTouchEvent
	 * @since 0.7.0
	 * @hidden
	 */
	public dispatchTouchEvent(event: TouchEvent) {

		this[EVENT] = event

		switch (event.type) {

			case 'touchcancel':
				this.dispatchTouchCancel(event)
				break

			case 'touchstart':
				this.dispatchTouchStart(event)
				break

			case 'touchmove':
				this.dispatchTouchMove(event)
				break

			case 'touchend':
				this.dispatchTouchEnd(event)
				break
		}

		this[EVENT] = null
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property VIEW
	 * @since 0.1.0
	 * @hidden
	 */
	private [VIEW]: View | null = null

	/**
	 * @property EVENT
	 * @since 0.7.0
	 * @hidden
	 */
	private [EVENT]: TouchEvent | null = null

	/**
	 * @property DETECTED
	 * @since 0.1.0
	 * @hidden
	 */
	private [DETECTED]: boolean = false

	/**
	 * @property CAPTURED
	 * @since 0.1.0
	 * @hidden
	 */
	private [CAPTURED]: boolean = false

	/**
	 * @property CAPTURED_EVENT
	 * @since 0.7.0
	 * @hidden
	 */
	private [CAPTURED_EVENT]: TouchEvent | null = null

	/**
	 * @method captureEvent
	 * @since 0.1.0
	 * @hidden
	 */
	private captureEvent() {

		if (this.capture == false) {
			return this
		}

		let event = this[EVENT]
		if (event == null) {
			return this
		}

		if (this[CAPTURED] == false) {
			this[CAPTURED] = true
			this[CAPTURED_EVENT] = event
			event.capture()
		}

		return this
	}

	/**
	 * @method dispatchTouchCancel
	 * @since 0.7.0
	 * @hidden
	 */
	private dispatchTouchCancel(event: TouchEvent) {

		if (event.dispatcher == this[CAPTURED_EVENT]) {

			/*
			 * When an event is captured, it assigns the touchcancel event's
			 * dispatcher propery to the event that actually triggered the
			 * capture. In this case we ignore this event because its not
			 * meant for this gesture.
			 */

			return
		}

		this.onTouchCancel(event)
	}

	/**
	 * @method dispatchTouchStart
	 * @since 0.7.0
	 * @hidden
	 */
	private dispatchTouchStart(event: TouchEvent) {
		this.onTouchStart(event)
	}

	/**
	 * @method dispatchTouchMove
	 * @since 0.7.0
	 * @hidden
	 */
	private dispatchTouchMove(event: TouchEvent) {
		this.onTouchMove(event)
	}

	/**
	 * @method dispatchTouchEnd
	 * @since 0.5.0
	 * @hidden
	 */
	private dispatchTouchEnd(event: TouchEvent) {
		this.onTouchEnd(event)
	}
}

/**
 * @const GestureRegistry
 * @since 0.1.0
 * @hidden
 */
export const GestureRegistry: Map<string, typeof Gesture> = new Map()