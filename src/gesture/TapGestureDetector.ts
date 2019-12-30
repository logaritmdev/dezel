import { $x } from './private/TapGestureDetector'
import { $y } from './private/TapGestureDetector'
import { Touch } from '../event/Touch'
import { TouchEvent } from '../event/TouchEvent'
import { Window } from '../view/Window'
import { GestureDetector } from './GestureDetector'
import { State } from './GestureDetector'

/**
 * @class TapGestureDetector
 * @super GestureDetector
 * @since 0.7.0
 */
export class TapGestureDetector extends GestureDetector<TapGestureDetector> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The pointer position on the x axis.
	 * @property x
	 * @since 0.7.0
	 */
	public get x(): number {
		return this[$x]
	}

	/**
	 * The pointer position on the y axis.
	 * @property y
	 * @since 0.7.0
	 */
	public get y(): number {
		return this[$y]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onTouchStart
	 * @since 0.7.0
	 */
	public onTouchStart(event: TouchEvent) {

		if (this.touch) {
			this.cancel()
			return
		}

		if (event.touches.length > 1) {

			/*
			 * Automatically ignore the gesture if the touch event has more
			 * than a single touch.
			 */

			this.ignore()
			return
		}

		if (this.touch == null) {
			this.touch = event.touches.get(0)
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
			throw new Error('Unexpected error.')
		}

		if (event.touches.has(touch) == false) {
			return
		}

		let target = this.findViewAt(touch.x, touch.y)

		while (target) {

			if (target == this.view) {

				this[$x] = touch.x
				this[$y] = touch.y

				this.detect()
				this.finish()
			}

			let parent = target.parent
			if (parent == null) {
				break
			}

			target = parent
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
			throw new Error('Unexpected error.')
		}

		if (event.touches.has(touch) == false) {
			return
		}

		if (this.state == State.Detected) {
			this.cancel()
		}
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
	 * @property $x
	 * @since 0.7.0
	 * @hidden
	 */
	private [$x]: number = -1

	/**
	 * @property $y
	 * @since 0.7.0
	 * @hidden
	 */
	private [$y]: number = -1

	/**
	 * @property touch
	 * @since 0.7.0
	 * @hidden
	 */
	private touch: Touch | null = null

	/**
	 * @method findViewAt
	 * @since 0.7.0
	 * @hidden
	 */
	private findViewAt(x: number, y: number) {

		let view = this.view
		if (view == null) {
			throw new Error('Unexpected error.')
		}

		let window: Window | null

		if (view instanceof Window) {
			window = view
		} else {
			window = view.window
		}

		if (window == null) {
			throw new Error('Unexpected error.')
		}

		return window.findViewAt(x, y)
	}

}