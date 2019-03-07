import { bound } from '../decorator/bound'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { EventListener } from '../event/Event'
import { TouchEvent } from '../touch/TouchEvent'
import { View } from '../view/View'

/**
 * @symbol VIEW
 * @since 0.1.0
 */
export const VIEW = Symbol('view')

/**
 * @symbol LISTENER
 * @since 0.1.0
 */
export const LISTENER = Symbol('listener')

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
 * The gesture options.
 * @interface GestureOptions
 * @since 0.1.0
 */
export interface GestureOptions {
	capture?: boolean
}

/**
 * The base class for gesture detection.
 * @class Gesture
 * @super Emitter
 * @since 0.1.0
 */
export class Gesture extends Emitter {

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
	private get captured(): boolean {
		return this[CAPTURED]
	}

	/**
	 * The view that gesture will be detected upon.
	 * @property view
	 * @since 0.1.0
	 */
	public get view(): View {
		return this[VIEW]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(options: GestureOptions = {}) {
		super()
		this.capture = options.capture || false
	}

	/**
	 * Indicates to the detector that the gesture has begun.
	 * @method begin
	 * @since 0.5.0
	 */
	public begin() {

		if (this.detected) {
			throw new Error(`
				Gesture error:
				Gesture has already begun. Did you forget to call finish() ?
			`)
		}

		this.emit('begin')

		this[DETECTED] = true
		this[CAPTURED] = false

		this.captureEvent()

		return this
	}

	/**
	 * Emits a gesture event to the receiver.
	 * @method detect
	 * @since 0.5.0
	 */
	public detect(event: Event, source: TouchEvent) {

		if (this.detected == false) {
			throw new Error(`
				Gesture Error :
				Gesture has not begun. Did you forget to call begin() ?
			`)
		}

		this.captureEvent()

		event.setSender(this.view)
		event.setTarget(this.view)

		let listener = this[LISTENER]
		if (listener) {
			listener(event)
		}

		return this
	}

	/**
	 * Indicates to the detector that the gesture has begun.
	 * @method finish
	 * @since 0.5.0
	 */
	public finish() {

		if (this.detected == false) {
			throw new Error(`
				Gesture error:
				Gesture has not begun. Did you forget to call begin() ?
			`)
		}

		this.emit('finish')

		this[DETECTED] = false
		this[CAPTURED] = false

		return this
	}

	/**
	 * Called when the gestured is attached to a view.
	 * @method onAttach
	 * @since 0.5.0
	 */
	public onAttach() {

	}

	/**
	 * Called when the gestured is detached from a view.
	 * @method onDetach
	 * @since 0.5.0
	 */
	public onDetach() {

	}

	/**
	 * Called when a touch cancel event occurs.
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	public onTouchCancel(event: TouchEvent) {

	}

	/**
	 * Called when a touch start event occurs.
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	public onTouchStart(event: TouchEvent) {

	}

	/**
	 * Called when a touch move event occurs.
	 * @method onTouchMove
	 * @since 0.1.0
	 */
	public onTouchMove(event: TouchEvent) {

	}

	/**
	 * Called when a touch end event occurs.
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	public onTouchEnd(event: TouchEvent) {

	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * Attach the gesture to the specified view.
	 * @method attach
	 * @since 0.5.0
	 */
	public attach(view: View, listener: EventListener) {

		this[LISTENER] = listener

		this[VIEW] = view
		this[VIEW].on('touchcancel', this.onTouchCancelDefault)
		this[VIEW].on('touchstart', this.onTouchStartDefault)
		this[VIEW].on('touchmove', this.onTouchMoveDefault)
		this[VIEW].on('touchend', this.onTouchEndDefault)

		this.onAttach()

		return this
	}

	/**
	 * Detach the gesture from the specified view.
	 * @method attach
	 * @since 0.5.0
	 */
	public detach() {

		this[VIEW].off('touchcancel', this.onTouchCancelDefault)
		this[VIEW].off('touchstart', this.onTouchStartDefault)
		this[VIEW].off('touchmove', this.onTouchMoveDefault)
		this[VIEW].off('touchend', this.onTouchEndDefault)

		this.onDetach()

		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [VIEW]
	 * @since 0.1.0
	 * @hidden
	 */
	private [VIEW]: View

	/**
	 * @property [LISTENER]
	 * @since 0.1.0
	 * @hidden
	 */
	private [LISTENER]: Function

	/**
	 * @property [DETECTED]
	 * @since 0.1.0
	 * @hidden
	 */
	private [DETECTED]: boolean = false

	/**
	 * @property [CAPTURED]
	 * @since 0.1.0
	 * @hidden
	 */
	private [CAPTURED]: boolean = false

	/**
	 * @property currentEvent
	 * @since 0.5.0
	 * @hidden
	 */
	private currentEvent?: TouchEvent | null

	/**
	 * @property capturedEvent
	 * @since 0.5.0
	 * @hidden
	 */
	private capturedEvent?: TouchEvent | null

	/**
	 * @method captureEvent
	 * @since 0.1.0
	 * @hidden
	 */
	private captureEvent() {

		if (this.capture == false) {
			return this
		}

		let event = this.currentEvent
		if (event == null) {
			return this
		}

		if (this[CAPTURED] == false) {
			this[CAPTURED] = true
			this.capturedEvent = event
			event.capture()
		}

		return this
	}

	/**
	 * @method onTouchEvent
	 * @since 0.5.0
	 * @hidden
	 */
	private onTouchEvent(event: TouchEvent) {

		this.currentEvent = event

		switch (event.type) {

			case 'touchcancel':
				this.onTouchCancel(event)
				break

			case 'touchstart':
				this.onTouchStart(event)
				break

			case 'touchmove':
				this.onTouchMove(event)
				break

			case 'touchend':
				this.onTouchEnd(event)
				break
		}

		this.currentEvent = null
	}

	/**
	 * @method onTouchCancelDefault
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onTouchCancelDefault(event: TouchEvent) {

		if (event.dispatcher == this.capturedEvent) {

			/*
			 * When an event is captured, it assigns the touchcancel event's
			 * dispatcher propery to the event that actually triggered the
			 * capture. In this case we ignore this event because its not
			 * meant for this gesture.
			 */

			return
		}

		this.onTouchEvent(event)
	}

	/**
	 * @method onTouchStartDefault
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onTouchStartDefault(event: TouchEvent) {
		this.onTouchEvent(event)
	}

	/**
	 * @method onTouchMoveDefault
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onTouchMoveDefault(event: TouchEvent) {
		this.onTouchEvent(event)
	}

	/**
	 * @method onTouchEndDefault
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onTouchEndDefault(event: TouchEvent) {
		this.onTouchEvent(event)
	}
}

/**
 * @const GestureRegistry
 * @since 0.1.0
 * @hidden
 */
export const GestureRegistry: Map<string, typeof Gesture> = new Map()