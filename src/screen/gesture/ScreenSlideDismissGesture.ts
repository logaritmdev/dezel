import { TouchEvent } from '../../touch/TouchEvent'
import { ScreenDismissGesture } from './ScreenDismissGesture'

/**
 * Dismisses a screen by sliding from the left side.
 * @class ScreenSlideDismissGesture
 * @super ScreenDismissGesture
 * @since 0.5.0
 */
export class ScreenSlideDismissGesture extends ScreenDismissGesture {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onTouchCancel
	 * @since 0.5.0
	 */
	public onTouchCancel(event: TouchEvent) {

		if (event.dispatcher == this.capturedEvent) {

			/*
			 * When an event is captured, it assigns the touchcancel event's
			 * dispatcher propery to the event that actually triggered the
			 * capture. In this case we ignore this event because its not
			 * meant for this gesture.
			 */

			return
		}

		this.onTouchEnd(event)
	}

	/**
	 * @inherited
	 * @method onTouchCancel
	 * @since 0.5.0
	 */
	public onTouchStart(event: TouchEvent) {

		if (this.touchStarted) {
			return
		}

		let touch = event.touches.item(0)
		if (touch.x > 20) {
			return
		}

		this.touchStarted = true
		this.touchDragged = false
		this.touchStartX = touch.x
		this.touchStartY = touch.y
		this.touchStartT = Date.now()
	}

	/**
	 * @inherited
	 * @method onTouchCancel
	 * @since 0.5.0
	 */
	public onTouchMove(event: TouchEvent) {

		if (this.touchStarted == false) {
			return
		}

		let screen = this.screen!

		let touch = event.touches.item(0)
		let dx = touch.x - this.touchStartX
		let dy = touch.y - this.touchStartY

		if (dx > 10 && dy < 100) {

			if (this.touchDragged == false) {
				this.touchDragged = true
				this.captureEvent(event)
				this.begin()
			}

			let p = this.state = (touch.x - 10) / screen.measuredWidth

			this.progress(p)

			if (p == 1) {
				this.finish()
			}
		}
	}

	/**
	 * @inherited
	 * @method onTouchCancel
	 * @since 0.5.0
	 */
	public onTouchEnd(event: TouchEvent) {

		if (this.touchStarted == false) {
			return
		}

		if (this.finished) {
			this.finish()
		} else {
			this.cancel()
		}

		this.touchStarted = false
		this.touchDragged = false
		this.touchStartT = 0
		this.touchStartX = 0
		this.touchStartY = 0

		this.capturedEvent = null
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property capturedEvent
	 * @since 0.5.0
	 * @hidden
	 */
	private capturedEvent: TouchEvent | null = null

	/**
	 * @property touchStarted
	 * @since 0.5.0
	 * @hidden
	 */
	private touchStarted: boolean = false

	/**
	 * @property touchDragged
	 * @since 0.5.0
	 * @hidden
	 */
	private touchDragged: boolean = false

	/**
	 * @property touchStartX
	 * @since 0.5.0
	 * @hidden
	 */
	private touchStartX: number = 0

	/**
	 * @property touchStartY
	 * @since 0.5.0
	 * @hidden
	 */
	private touchStartY: number = 0

	/**
	 * @property touchStartT
	 * @since 0.5.0
	 * @hidden
	 */
	private touchStartT: number = 0

	/**
	 * @property state
	 * @since 0.5.0
	 * @hidden
	 */
	private state: number = 0

	/**
	 * @property isFinished
	 * @since 0.5.0
	 * @hidden
	 */
	private get finished(): boolean {
		return this.touchStarted && this.touchDragged && (Date.now() - this.touchStartT < 350 || this.state > 0.5)
	}

	/**
	 * @method captureEvent
	 * @since 0.5.0
	 * @hidden
	 */
	private captureEvent(event: TouchEvent) {
		if (this.capturedEvent == null) {
			this.capturedEvent = event
			this.capturedEvent.capture()
		}
	}
}