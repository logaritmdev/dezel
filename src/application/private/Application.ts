import { setEmitterResponder } from '../../event/private/Emitter'
import { TouchEvent } from '../../touch/TouchEvent'

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
				propagable: true,
				cancelable: false,
				capturable: false,
				finishable: false,
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
				propagable: true,
				cancelable: false,
				capturable: false,
				finishable: false,
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
				propagable: true,
				cancelable: false,
				capturable: false,
				finishable: false,
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
					propagable: true,
					cancelable: false,
					capturable: false,
					finishable: false,
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
