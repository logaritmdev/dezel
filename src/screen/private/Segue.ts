import { State } from '../../gesture/GestureDetector'
import { SegueRegistry } from '../..'
import { Segue } from '../Segue'

/**
 * @symbol enter
 * @since 0.7.0
 * @hidden
 */
export const $screen = Symbol('screen')

/**
 * @symbol deferred
 * @since 0.7.0
 * @hidden
 */
export const $waiter = Symbol('waiter')

/**
 * @symbol dismissGestureState
 * @since 0.7.0
 * @hidden
 */
export const $dismissGestureState = Symbol('dismissGestureState')

/**
 * @method getRegisteredSegue
 * @since 0.7.0
 * @hidden
 */
export function getRegisteredSegue(segue: string) {

	let Segue = SegueRegistry.get(segue)
	if (Segue) {
		return new Segue()
	}

	throw new Error(`Segue error: The segue named ${segue} has not been registered.`)
}

/**
 * @method setDismissGestureState
 * @since 0.7.0
 * @hidden
 */
export function setDismissGestureState(segue: Segue, state: State) {

	if (segue[$dismissGestureState] > state) {
		throw new Error(`Gesture error: This gesture's state cannot be changed to a lower value.`)
	}

	if (segue[$dismissGestureState] == state &&
		segue[$dismissGestureState] != State.Updated) {
		return
	}

	segue[$dismissGestureState] = state
}