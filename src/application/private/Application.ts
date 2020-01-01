import { native } from '../../native/native'
import { Touch } from '../../event/Touch'
import { TouchEvent } from '../../event/TouchEvent'
import { TouchList } from '../../event/TouchList'
import { View } from '../../view/View'
import { Application } from '../Application'
import { InputTouch } from '../Application'

/**
 * @symbol screen
 * @since 0.7.0
 * @hidden
 */
export const $screen = Symbol('screen')

/**
 * @symbol touches
 * @since 0.7.0
 * @hidden
 */
export const $touches = Symbol('touches')

/**
 * @function registerTouch
 * @since 0.7.0
 * @hidden
 */
export function registerTouch(application: Application, input: InputTouch, touch: Touch) {

	if (application[$touches][input.id] == null) {
		application[$touches][input.id] = touch
		return
	}

	throw new Error(`Application error: Touch ${input.id} has already been registered.`)
}

/**
 * @function getActiveTouch
 * @since 0.7.0
 * @hidden
 */
export function getActiveTouch(application: Application, input: InputTouch) {

	let touch = application[$touches][input.id]
	if (touch &&
		touch.canceled) {
		return null
	}

	return touch
}

/**
 * @function mapTarget
 * @since 0.7.0
 * @hidden
 */
export function mapTarget(touch: Touch, targets: Map<any, any>) {

	let changes = targets.get(touch.target)
	if (changes == null) {
		targets.set(touch.target, changes = [])
	}

	changes.push(touch)
}

/**
 * @function cancelTouchStart
 * @since 0.7.0
 * @hidden
 */
export function cancelTouchStart(event: TouchEvent) {

	/*
	 * Dispatches a touchcancel event to all the node that have received
	 * the original touchstart event which include the sender who canceled
	 * the touch event.
	 */

	let node = event.target
	let last = event.sender

	while (true) {

		node.emit(
			new TouchEvent('touchcancel', {
				propagable: false,
				cancelable: false,
				capturable: false,
				touches: event.touches,
				activeTouches: event.activeTouches,
				targetTouches: event.targetTouches
			})
		)

		if (node == last) {
			break
		}

		let next = node.responder
		if (next == null) {
			break
		}

		node = next
	}
}

/**
 * @function cancelTouchMove
 * @since 0.7.0
 * @hidden
 */
export function cancelTouchMove(event: TouchEvent) {

	/*
	 * Dispatches a touchcancel event to all the node that have received
	 * the original touchstart event including the sender who canceled
	 * the touch event.
	 */

	let node = event.target

	while (true) {

		node.emit(
			new TouchEvent('touchcancel', {
				propagable: false,
				cancelable: false,
				capturable: false,
				touches: event.touches,
				activeTouches: event.activeTouches,
				targetTouches: event.targetTouches
			})
		)

		let next = node.responder
		if (next == null) {
			break
		}

		node = next
	}
}

/**
 * @function captureTouchStart
 * @since 0.7.0
 * @hidden
 */
export function captureTouchStart(event: TouchEvent) {

	/*
	 * Dispatches a touchcancel event to all the node that have received
	 * the original touchstart event which exclude the sender who captured
	 * the touch event.
	 */

	let node = event.target
	let last = event.sender

	while (true) {

		if (node == last) {
			break
		}

		node.emit(
			new TouchEvent('touchcancel', {
				propagable: false,
				cancelable: false,
				capturable: false,
				touches: event.touches,
				activeTouches: event.activeTouches,
				targetTouches: event.targetTouches
			})
		)

		let next = node.responder
		if (next == null) {
			break
		}

		node = next
	}
}

/**
 * @function captureTouchMove
 * @since 0.7.0
 * @hidden
 */
export function captureTouchMove(event: TouchEvent) {

	/*
	 * Dispatches a touchcancel event to all the node that have received
	 * the original touchstart event except the sender who captured the
	 * touch event.
	 */

	let node = event.target
	let skip = event.sender

	while (true) {

		if (node != skip) {

			node.emit(
				new TouchEvent('touchcancel', {
					propagable: false,
					cancelable: false,
					capturable: false,
					touches: event.touches,
					activeTouches: event.activeTouches,
					targetTouches: event.targetTouches
				})
			)

		}

		let next = node.responder
		if (next == null) {
			break
		}

		node = next
	}
}


/**
 * @method updateEventInputs
 * @since 0.7.0
 * @hidden
 */
export function updateEventInputs(event: TouchEvent, inputs: Array<InputTouch>) {

	let map: Dictionary<InputTouch> = {}

	for (let input of inputs) {
		if (map[input.id] == null) {
			map[input.id] = input
		}
	}

	for (let touch of event.touches) {

		let input = map[touch.id]
		if (input == null) {
			continue
		}

		if (input.canceled ||
			input.captured) {
			continue
		}

		input.canceled = touch.canceled
		input.captured = touch.captured

		if (input.captured) {
			input.receiver = native(event.sender)
		}
	}
}

/**
 * @function toTouchList
 * @since 0.5.0
 * @hidden
 */
export function toTouchList(touches: Array<Touch>) {
	return new TouchList(touches)
}

/**
 * @function toActiveTouchList
 * @since 0.5.0
 * @hidden
 */
export function toActiveTouchList(touches: Dictionary<Touch>) {
	return new TouchList(Object.values(touches))
}

/**
 * @function toTargetTouchList
 * @since 0.4.0
 * @hidden
 */
export function toTargetTouchList(touches: Dictionary<Touch>, target: View) {
	return new TouchList(Object.values(touches).filter(touch => touch.target == target))
}
