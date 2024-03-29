import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { Window } from '../view/Window'
import { Gesture } from './Gesture'
import { GestureRegistry } from './Gesture'
import { TapGestureEvent } from './TapGestureEvent'

/**
 * Detects a tap gesture.
 * @class TapGesture
 * @super Gesture
 * @since 0.1.0
 */
export class TapGesture extends Gesture {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Called when a touch cancel event occurs.
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	public onTouchCancel(event: TouchEvent) {

		if (this.touch == null) {
			return
		}

		let touch = event.touches.find(this.touch)
		if (touch) {
			this.touch = null
		}
	}

	/**
	 * Called when a touch start event occurs.
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	public onTouchStart(event: TouchEvent) {
		if (this.touch == null) {
			this.touch = event.touches.item(0)
		}
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

		if (this.touch == null) {
			return
		}

		let touch = event.touches.find(this.touch)
		if (touch == null) {
			return
		}

		this.touch = null

		let valid = this.validate(touch)
		if (valid) {
			this.begin()
			this.detect(new TapGestureEvent('tap', { touches: event.touches }), event)
			this.finish()
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property touch
	 * @since 0.1.0
	 * @hidden
	 */
	private touch?: Touch | null

	/**
	 * @method validate
	 * @since 0.1.0
	 * @hidden
	 */
	private validate(touch: Touch) {

		let view = this.view
		if (view == null) {
			return false
		}

		if (view instanceof Window) {
			return true
		}

		let window = view.window
		if (window) {

			let target = window.viewFromPoint(
				touch.x,
				touch.y
			)

			while (target) {

				if (target == this.view) {
					return true
				}

				target = target.parent
			}
		}

		return false
	}
}

GestureRegistry.set('tap', TapGesture)