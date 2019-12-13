import { Event } from '../../event/Event'
import { View } from '../../view/View'
import { GestureDetector } from '../GestureDetector'
import { State } from '../GestureDetector'

/**
 * @symbol view
 * @since 0.7.0
 * @hidden
 */
export const $view = Symbol('view')

/**
 * @symbol state
 * @since 0.7.0
 * @hidden
 */
export const $state = Symbol('state')

/**
 * @symbol captured
 * @since 0.7.0
 * @hidden
 */
export const $captured = Symbol('captured')

/**
 * @symbol resolved
 * @since 0.7.0
 * @hidden
 */
export const $resolved = Symbol('resolved')

/**
 * @symbol duration
 * @since 0.7.0
 * @hidden
 */
export const $duration = Symbol('duration')

/**
 * @symbol callback
 * @since 0.7.0
 * @hidden
 */
export const $callback = Symbol('callback')

/**
 * @symbol detected
 * @since 0.7.0
 * @hidden
 */
export const $detected = Symbol('detected')

/**
 * @symbol canceled
 * @since 0.7.0
 * @hidden
 */
export const $canceled = Symbol('canceled')

/**
 * @symbol finished
 * @since 0.7.0
 * @hidden
 */
export const $finished = Symbol('finished')

/**
 * @function setGestureState
 * @since 0.7.0
 * @hidden
 */
export function setGestureState(gesture: GestureDetector, state: State) {

	if (gesture.resolved) {
		throw new Error(`Gesture error: This gesture's state cannot be changed until it is reset.`)
	}

	if (gesture.state > state) {
		throw new Error(`Gesture error: This gesture's state cannot be changed to a lower value.`)
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