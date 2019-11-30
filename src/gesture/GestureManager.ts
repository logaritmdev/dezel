import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { View } from '../view/View'
import { setGestureView } from './private/GestureDetector'
import { insertItem } from './private/GestureManager'
import { removeItem } from './private/GestureManager'
import { $gestures } from './symbol/GestureManager'
import { $view } from './symbol/GestureManager'
import { GestureDetector } from './GestureDetector'
import { State } from './GestureDetector'

/**
 * @class Gesture
 * @since 0.7.0
 */
export class GestureManager {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.7.0
	 */
	public get view(): View {
		return this[$view]
	}

	/**
	 * @property gestures
	 * @since 0.7.0
	 */
	public get gestures(): ReadonlyArray<GestureDetector> {
		return this[$gestures]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(view: View) {
		this[$view] = view
	}

	/**
	 * @method append
	 * @since 0.7.0
	 */
	public append(gesture: GestureDetector) {

		if (gesture.view) {

			throw new Error(
				`Gesture error: ` +
				`This gesture has already been registered to another view.`
			)

		}

		let index = this.gestures.indexOf(gesture)
		if (index > -1) {
			return this
		}

		setGestureView(gesture, this.view)

		gesture.reset()

		insertItem(this, gesture)

		return this
	}

	/**
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(gesture: GestureDetector) {

		let index = this.gestures.indexOf(gesture)
		if (index == -1) {
			return this
		}

		setGestureView(gesture, null)

		gesture.reset()

		removeItem(this, gesture, index)

		return this
	}

	//--------------------------------------------------------------------------
	// Methods - Events
	//--------------------------------------------------------------------------

	/**
	 * @method onTouchEvent
	 * @since 0.7.0
	 */
	public onTouchEvent(event: TouchEvent) {

		if (event.canceled) {
			console.log('Stopped here')
			return this
		}

		let captured = this.gestures.find(gesture => {
			return (
				gesture.enabled &&
				gesture.captured &&
				gesture.resolved == false
			)
		})
		console.log('WAT', captured)

		if (captured) {

			captured.dispatchTouchEvent(event)

		} else {

			for (let gesture of this.gestures) {

				if (gesture.resolved ||
					gesture.enabled == false) {
					console.log('continue here', gesture.resolved, gesture.enabled)
					continue
				}

				gesture.dispatchTouchEvent(event)

				if (gesture.capture == false) {
					continue
				}

				/*
				 * A gesture can capture a touch event when the gesture is
				 * detected for the first time. Once done, the following touch
				 * events will be forwarded to this gesture.
				 */

				if (gesture.state == State.Detected) {

					if (gesture.captured == false) {

						gesture.captureTouchEvent(event)

						this.gestures.forEach(gesture => {
							if (gesture.captured == false) {
								gesture.reset()
							}
						})
					}

					break
				}
			}
		}

		/*
		 * Resets all the gesture when there are no more touch so they'll be
		 * usable again.
		 */

		if (event.activeTouches.length == 0) {
			this.reset()
		}
	}

	//--------------------------------------------------------------------------
	// Protected API
	//--------------------------------------------------------------------------

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	protected reset() {
		this.gestures.forEach(gesture => gesture.reset())
		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $gestures
	 * @since 0.7.0
	 * @hidden
	 */
	private [$view]: View

	/**
	 * @property $gestures
	 * @since 0.7.0
	 * @hidden
	 */
	private [$gestures]: Array<GestureDetector> = []
}
