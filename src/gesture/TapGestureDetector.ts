import { Touch } from '../event/Touch'
import { TouchEvent } from '../event/TouchEvent'
import { Window } from '../view/Window'
import { GestureDetector } from './GestureDetector'

/**
 * @class TapGestureDetector
 * @super GestureDetector
 * @since 0.7.0
 */
export class TapGestureDetector extends GestureDetector {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onTouchStart
	 * @since 0.7.0
	 */
	public onTouchStart(event: TouchEvent) {

		let touches = event.touches
		if (touches.length > 1) {

			/*
			 * Automatically ignore the gesture if the touch event has more
			 * than a single touch.
			 */

			this.ignore()
			return
		}

		if (this.touch == null) {
			this.touch = touches.get(0)
		}
	}

	/**
	 * @inherited
	 * @method onTouchEnd
	 * @since 0.7.0
	 */
	public onTouchEnd(event: TouchEvent) {

		let touch = this.touch
		if (touch == null) {
			throw new Error('TapGesture error: An error occured.')
		}

		if (event.touches.has(touch) == false) {
			return
		}

		if (this.validate(touch)) {
			this.detect()
			this.finish()
		}
	}

	/**
	 * @inherited
	 * @method onTouchCancel
	 * @since 0.7.0
	 */
	public onTouchCancel(event: TouchEvent) {

		let touch = this.touch
		if (touch == null) {
			throw new Error('TapGesture error: An error occured.')
		}

		if (event.touches.has(touch) == false) {
			return
		}

		this.cancel()
	}

	/**
	 * @inherited
	 * @method onReset
	 * @since 0.7.0
	 */
	public onReset() {
		this.touch = null
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property touch
	 * @since 0.7.0
	 * @hidden
	 */
	private touch: Touch | null = null

	/**
	 * @method validate
	 * @since 0.7.0
	 * @hidden
	 */
	private validate(touch: Touch) {

		let view = this.view
		if (view == null) {
			throw new Error('TapGesture error: An error occured.')
		}

		if (view instanceof Window) {
			return true
		}

		let window = view.window
		if (window == null) {
			throw new Error('TapGesture error: An error occured.')
		}

		let target = window.findViewAt(
			touch.x,
			touch.y
		)

		while (target) {

			if (target == this.view) {
				return true
			}

			target = target.parent
		}

		return false
	}
}