import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { Window } from '../view/Window'
import { Gesture } from './Gesture'
import { GestureRegistry } from './Gesture'

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
	 * @inherited
	 * @property name
	 * @since 0.7.0
	 */
	public get name(): string {
		return 'tap'
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Called when a touch cancel event occurs.
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	protected onTouchCancel(event: TouchEvent) {

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
	protected onTouchStart(event: TouchEvent) {
		if (this.touch == null) {
			this.touch = event.touches.item(0)
		}
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
			this.start()
			this.detect()
			this.end()
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
	private touch: Touch | null = null

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