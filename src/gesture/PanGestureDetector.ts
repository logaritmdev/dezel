import { $detectX } from './private/PanGestureDetector'
import { $detectY } from './private/PanGestureDetector'
import { $originX } from './private/PanGestureDetector'
import { $originY } from './private/PanGestureDetector'
import { $touch } from './private/PanGestureDetector'
import { $translationX } from './private/PanGestureDetector'
import { $translationY } from './private/PanGestureDetector'
import { $x } from './private/PanGestureDetector'
import { $y } from './private/PanGestureDetector'
import { Touch } from '../event/Touch'
import { TouchEvent } from '../event/TouchEvent'
import { GestureDetector } from './GestureDetector'
import { State } from './GestureDetector'

/**
 * @class PanGestureDetector
 * @super GestureDetector
 * @since 0.7.0
 */
export class PanGestureDetector extends GestureDetector {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property x
	 * @since 0.7.0
	 */
	public get x(): number {
		return this[$x]
	}

	/**
	 * @property y
	 * @since 0.7.0
	 */
	public get y(): number {
		return this[$y]
	}

	/**
	 * @property originX
	 * @since 0.7.0
	 */
	public get originX(): number {
		return this[$originX]
	}

	/**
	 * @property originY
	 * @since 0.7.0
	 */
	public get originY(): number {
		return this[$originY]
	}

	/**
	 * @property translationX
	 * @since 0.7.0
	 */
	public get translationX(): number {
		return this[$translationX]
	}

	/**
	 * @property translationY
	 * @since 0.7.0
	 */
	public get translationY(): number {
		return this[$translationX]
	}

	/**
	 * @property threshold
	 * @since 0.7.0
	 */
	public threshold: number = 10

	/**
	 * @property direction
	 * @since 0.7.0
	 */
	public direction: 'vertical' | 'horizontal' | 'both' = 'horizontal'

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method onTouchStart
	 * @since 0.7.0
	 */
	public onTouchStart(event: TouchEvent) {
		if (this[$touch] == null) {
			this[$touch] = event.touches.get(0)
			this[$originX] = event.touches.get(0).x
			this[$originY] = event.touches.get(0).y
		}
	}

	/**
	 * @method onTouchMove
	 * @since 0.7.0
	 */
	public onTouchMove(event: TouchEvent) {

		let touch = this[$touch]
		if (touch == null) {
			return
		}

		if (event.touches.has(touch) == false) {
			return
		}

		let dh = this.direction == 'both' || this.direction == 'horizontal'
		let dv = this.direction == 'both' || this.direction == 'vertical'

		if (this.state == State.Allowed) {

			let x = touch.x - this[$originX]
			let y = touch.y - this[$originY]

			let mx = Math.abs(x) > this.threshold && dh
			let my = Math.abs(y) > this.threshold && dv

			if (mx) this[$detectX] = touch.x
			if (my) this[$detectY] = touch.y

			if (mx || my) {
				this.detect()
			}

		} else if (this.state == State.Detected || this.state == State.Updated) {

			this[$x] = touch.x
			this[$y] = touch.y
			this[$translationX] = touch.x - this[$detectX]
			this[$translationY] = touch.y - this[$detectY]

			this.update()
		}
	}

	/**
	 * @method onTouchEnd
	 * @since 0.7.0
	 */
	public onTouchEnd(event: TouchEvent) {

		let touch = this[$touch]
		if (touch == null) {
			return
		}

		if (event.touches.has(touch) == false) {
			return
		}

		if (this.state == State.Detected ||
			this.state == State.Updated) {
			this.finish()
		}
	}

	/**
	 * @method onTouchCancel
	 * @since 0.7.0
	 */
	public onTouchCancel(event: TouchEvent) {

		let touch = this[$touch]
		if (touch == null) {
			return
		}

		if (event.touches.has(touch) == false) {
			return
		}

		if (this.state == State.Detected ||
			this.state == State.Updated) {
			this.finish()
		}
	}

	/**
	 * @method onTouchCancel
	 * @since 0.7.0
	 */
	public onReset() {
		this[$x] = -1
		this[$y] = -1
		this[$originX] = -1
		this[$originX] = -1
		this[$detectX] = -1
		this[$detectY] = -1
		this[$translationX] = -1
		this[$translationY] = -1
		this[$touch] = null
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $touch
	 * @since 0.7.0
	 * @hidden
	 */
	private [$touch]: Touch | null = null

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
	 * @property $originX
	 * @since 0.7.0
	 * @hidden
	 */
	private [$originX]: number = -1

	/**
	 * @property $originY
	 * @since 0.7.0
	 * @hidden
	 */
	private [$originY]: number = -1

	/**
	 * @property $detectX
	 * @since 0.7.0
	 * @hidden
	 */
	private [$detectX]: number = -1

	/**
	 * @property $detectY
	 * @since 0.7.0
	 * @hidden
	 */
	private [$detectY]: number = -1

	/**
	 * @property $translationX
	 * @since 0.7.0
	 * @hidden
	 */
	private [$translationX]: number = -1

	/**
	 * @property $translationY
	 * @since 0.7.0
	 * @hidden
	 */
	private [$translationY]: number = -1

}
