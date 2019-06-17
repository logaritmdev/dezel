import { TouchEvent } from '../touch/TouchEvent'
import { View } from '../view/View'
import { Gesture } from './Gesture'

/**
 * @symbol VIEW
 * @since 0.7.0
 */
export const VIEW = Symbol('view')

/**
 * @symbol GESTURES
 * @since 0.7.0
 */
export const GESTURES = Symbol('gestures')

/**
 * @class Gesture
 * @since 0.7.0
 */
export class GestureManager {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The gesture manager's view.
	 * @property view
	 * @since 0.7.0
	 */
	public get view(): View {
		return this[VIEW]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(view: View) {
		this[VIEW] = view
	}

	/**
	 * Destroyes the gesture manager.
	 * @method destroy
	 * @since 0.7.0
	 */
	public destroy() {
		this.empty()
		return this
	}

	/**
	 * Appends a gesture at the end of the gesture list.
	 * @method append
	 * @since 0.7.0
	 */
	public append(gesture: Gesture) {
		return this.insert(gesture, this[GESTURES].length)
	}

	/**
	 * Inserts a gesture at a position of the gesture list.
	 * @method insert
	 * @since 0.7.0
	 */
	public insert(gesture: Gesture, index: number) {

		if (gesture.view) {
			gesture.view.gestures.remove(gesture)
		}

		gesture.setView(this.view)

		if (index > this[GESTURES].length) {
			index = this[GESTURES].length
		} else if (index < 0) {
			index = 0
		}

		insertGesture(this, gesture, index)

		return this
	}

	/**
	 * Removes a gesture from the gesture list.
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(gesture: Gesture) {

		let index = this[GESTURES].indexOf(gesture)
		if (index == -1) {
			return this
		}

		gesture.setView(null)

		removeGesture(this, gesture, index)

		return this
	}

	/**
	 * Remove all the gestures.
	 * @method empty
	 * @since 0.7.0
	 */
	public empty() {

		while (this[GESTURES].length) {
			this.remove(this[GESTURES][0])
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * Called when a touch cancel event occurs.
	 * @method dispatchTouchEvent
	 * @since 0.7.0
	 */
	public dispatchTouchEvent(event: TouchEvent) {

		for (let gesture of this[GESTURES]) {

			gesture.dispatchTouchEvent(event)

			/**
			 * If a touch event from a gesture cancels the touch, the next
			 * gesture will not receive the event. This has to be tested
			 * in order to find whether this is a good behavior.
			 */

			if (event.canceled) {
				break
			}
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property VIEW
	 * @since 0.7.0
	 * @hidden
	 */
	private [VIEW]: View

	/**
	 * @property GESTURES
	 * @since 0.7.0
	 * @hidden
	 */
	private [GESTURES]: Array<Gesture> = []

}

/**
 * @function insertGesture
 * @since 0.7.0
 * @hidden
 */
function insertGesture(manager: GestureManager, gesture: Gesture, index: number) {
	manager[GESTURES].splice(index, 0, gesture)
}

/**
 * @function removeGesture
 * @since 0.7.0
 * @hidden
 */
function removeGesture(manager: GestureManager, gesture: Gesture, index: number) {
	manager[GESTURES].splice(index, 1)
}