import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
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
	 * @method onTouchStart
	 * @since 0.7.0
	 */
	protected onTouchStart(event: TouchEvent) {

		let touches = event.touches
		if (touches.length > 1) {
			this.ignore()
			return
		}

		if (this.touch == null) {
			this.touch = touches.get(0)
		}
	}

	/**
	 * @method onTouchEnd
	 * @since 0.7.0
	 */
	protected onTouchEnd(event: TouchEvent) {

		let touch = this.touch
		if (touch == null ||
			event.touches.has(touch) == false) {
			return
		}

		let valid = this.validate(touch)
		if (valid) {
			this.detect()
			this.finish()
		}
	}

	/**
	 * @method onTouchCancel
	 * @since 0.7.0
	 */
	protected onTouchCancel(event: TouchEvent) {
		let touch = this.touch
		if (touch == null ||
			event.touches.has(touch) == false) {
			this.cancel()
		}
	}

	/**
	 * @method onReset
	 * @since 0.7.0
	 */
	protected onReset() {
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
			return false
		}

		if (view instanceof Window) {
			return true
		}

		let window = view.window
		if (window) {

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
		}

		return false
	}
}