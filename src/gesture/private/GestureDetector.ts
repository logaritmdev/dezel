import { $callback } from '../symbol/GestureDetector'
import { $canceled } from '../symbol/GestureDetector'
import { $detected } from '../symbol/GestureDetector'
import { $duration } from '../symbol/GestureDetector'
import { $finished } from '../symbol/GestureDetector'
import { $resolved } from '../symbol/GestureDetector'
import { $state } from '../symbol/GestureDetector'
import { $view } from '../symbol/GestureDetector'
import { Event } from '../../event/Event'
import { View } from '../../view/View'
import { GestureDetector } from '../GestureDetector'
import { State } from '../GestureDetector'

/**
 * @function setGestureView
 * @since 0.7.0
 * @hidden
 */
export function setGestureView(gesture: GestureDetector, view: View | null) {
	gesture[$view] = view
}

/**
 * @method setGestureState
 * @since 0.7.0
 * @hidden
 */
export function setGestureState(gesture: GestureDetector, state: State) {

	if (gesture.resolved) {
		throw new Error(
			`Gesture error: This gesture's state cannot be changed until it is reset.`
		)
	}

	if (gesture.state > state) {
		throw new Error(
			`Gesture error: This gesture's state cannot be changed to a lower value.`
		)
	}

	if (gesture.state == state &&
		gesture.state != State.Updated) {
		return
	}

	/*
	 * Allow a listener to cancel the gestire before it being detected. This
	 * can be useful for instance, when a pan gesture must start at a specific
	 * position.
	 */

	if (state == State.Detected) {

		let event = new Event('beforedetect', {
			propagable: false,
			cancelable: true,
		})

		gesture.emit(event)

		if (event.canceled) {
			state = State.Canceled
		}
	}

	gesture[$state] = state

	/*
	 * Dispatches state event for convenience.
	 */

	if (state == State.Detected) {

		gesture[$detected] = Date.now()
		gesture[$duration] = 0

		gesture.emit(
			new Event('detect', {
				propagable: false,
				cancelable: false,
			})
		)

	} else if (state == State.Canceled) {

		gesture[$canceled] = Date.now()
		gesture[$duration] = gesture[$finished] - gesture[$canceled]

		gesture.emit(
			new Event('cancel', {
				propagable: false,
				cancelable: false,
			})
		)

	} else if (state == State.Finished) {

		gesture[$finished] = Date.now()
		gesture[$duration] = gesture[$finished] - gesture[$detected]

		gesture.emit(
			new Event('finish', {
				propagable: false,
				cancelable: false,
			})
		)
	}

	if (state == State.Ignored ||
		state == State.Canceled ||
		state == State.Finished) {

		gesture[$resolved] = true

	} else {

		if (state == State.Updated ||
			state == State.Detected) {
			gesture[$callback].call(null, gesture)
		}

	}
}