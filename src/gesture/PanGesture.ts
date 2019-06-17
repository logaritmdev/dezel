import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { Gesture } from './Gesture'
import { GestureRegistry } from './Gesture'

/**
 * Detects a pan gesture.
 * @class PanGesture
 * @super Gesture
 * @since 0.1.0
 */
export class PanGesture extends Gesture {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @property name
	 * @since 0.7.0
	 */
	public get name(): string {
		return 'pan'
	}

	/**
	 * @property threshold
	 * @since 0.1.0
	 */
	public threshold: number = 10

	/**
	 * @property direction
	 * @since 0.1.0
	 */
	public direction: 'vertical' | 'horizontal' | 'both' = 'horizontal'

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	public onTouchCancel(event: TouchEvent) {

		super.onTouchCancel(event)

		let tracked = this.trackedTouch
		if (tracked == null) {
			return
		}

		let touch = event.touches.find(tracked)
		if (touch) {

			this.cancel()

			this.trackedTouch = null
			this.touchStartX = -1
			this.touchStartY = -1
			this.touchStartViewX = -1
			this.touchStartViewY = -1
			this.touchDetectedX = -1
			this.touchDetectedY = -1
		}
	}

	/**
	 * @inherited
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	public onTouchStart(event: TouchEvent) {

		super.onTouchStart(event)

		if (this.trackedTouch == null) {

			this.trackedTouch = event.touches.item(0)
			this.touchStartX = this.trackedTouch.x
			this.touchStartY = this.trackedTouch.y

			let view = this.view
			if (view) {
				this.touchStartViewX = view.measuredLeft
				this.touchStartViewY = view.measuredTop
			}
		}
	}

	/**
	 * @inherited
	 * @method onTouchMove
	 * @since 0.1.0
	 */
	public onTouchMove(event: TouchEvent) {

		super.onTouchMove(event)

		let tracked = this.trackedTouch
		if (tracked == null) {
			return
		}

		let dh = this.direction == 'both' || this.direction == 'horizontal'
		let dv = this.direction == 'both' || this.direction == 'vertical'

		let touch = event.touches.find(tracked)
		if (touch == null) {
			return
		}

		let x = touch.x - this.touchStartX
		let y = touch.y - this.touchStartY

		if (this.detected == false) {

			let mx = Math.abs(x) > this.threshold && dh
			let my = Math.abs(y) > this.threshold && dv

			if (mx) this.touchDetectedX = touch.x
			if (my) this.touchDetectedY = touch.y

			if (mx || my) {
				this.start()
			}
		}

		if (this.detected) {

			let options = {
				touches: event.touches,
				x: dh ? touch.x - this.touchDetectedX : 0,
				y: dv ? touch.y - this.touchDetectedY : 0,
				viewX: this.touchStartViewX + x,
				viewY: this.touchStartViewY + y
			}

			this.detect(options)
		}
	}

	/**
	 * @inherited
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	public onTouchEnd(event: TouchEvent) {

		super.onTouchEnd(event)

		let tracked = this.trackedTouch
		if (tracked == null) {
			return
		}

		let touch = event.touches.find(tracked)
		if (touch) {

			if (this.detected) {
				this.end()
			}

			this.trackedTouch = null
			this.touchStartX = -1
			this.touchStartY = -1
			this.touchDetectedX = -1
			this.touchDetectedY = -1
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property trackedTouch
	 * @since 0.1.0
	 * @hidden
	 */
	private trackedTouch?: Touch | null

	/**
	 * @property touchStartX
	 * @since 0.1.0
	 * @hidden
	 */
	private touchStartX: number = -1

	/**
	 * @property touchStartY
	 * @since 0.1.0
	 * @hidden
	 */
	private touchStartY: number = -1

	/**
	 * @property touchStartTargetX
	 * @since 0.4.0
	 * @hidden
	 */
	private touchStartViewX: number = -1

	/**
	 * @property touchStartTargetY
	 * @since 0.4.0
	 * @hidden
	 */
	private touchStartViewY: number = -1

	/**
	 * @property touchDetectedX
	 * @since 0.1.0
	 * @hidden
	 */
	private touchDetectedX: number = -1

	/**
	 * @property touchDetectedY
	 * @since 0.1.0
	 * @hidden
	 */
	private touchDetectedY: number = -1
}

GestureRegistry.set('pan', PanGesture)