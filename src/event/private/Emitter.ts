import { $handler } from '../symbol/Emitter'
import { $listeners } from '../symbol/Emitter'
import { $responder } from '../symbol/Emitter'
import { Emitter } from '../Emitter'
import { Event } from '../Event'
import { setEventSender } from './Event'

/**
 * @function setEmitterResponder
 * @since 0.7.0
 * @hidden
 */
export function setEmitterResponder(emitter: Emitter, responder: Emitter | null) {
	emitter[$responder] = responder
}

/**
 * @function getEventListeners
 * @since 0.7.0
 * @hidden
 */
export function getEventListeners(emitter: Emitter, type: string) {

	type = type.toLowerCase()

	let listeners = emitter[$listeners][type]
	if (listeners == null) {
		listeners = emitter[$listeners][type] = []
	}

	return listeners
}

/**
 * @function insertEventListener
 * @since 0.7.0
 * @hidden
 */
export function insertEventListener(emitter: Emitter, type: string, listener: any, one: boolean = false) {

	let listeners = getEventListeners(emitter, type)

	if (one) {

		/*
		 * Wraps the listener with a function that will remove itself
		 * once called. Keep a reference to the original function using
		 * a symbol.
		 */

		let callback = listener[$handler]
		if (callback == null) {
			listener = createSingleListener(emitter, type, listener)
		} else {
			listener = callback
		}
	}

	let index = listeners.indexOf(listener)
	if (index > -1) {
		return
	}

	listeners.push(listener)
}

/**
 * @function removeEventListener
 * @since 0.7.0
 * @hidden
 */
export function removeEventListener(emitter: Emitter, type: string, listener: any) {

	let listeners = getEventListeners(emitter, type)

	let callback = listener[$handler]
	if (callback) {
		listener = callback
	}

	let index = listeners.indexOf(listener)
	if (index == -1) {
		return
	}

	listeners.splice(index, 1)
}

/**
 * @function dispatchEvent
 * @since 0.7.0
 * @hidden
 */
export function dispatchEvent(emitter: Emitter, event: Event) {

	setEventSender(event, emitter)

	emitter.onEvent(event)

	if (event.canceled ||
		event.captured) {
		return
	}

	invokeListeners(emitter, event)

	if (event.canceled ||
		event.captured) {
		return
	}

	if (event.propagable == false) {
		return
	}

	let responder = emitter.responder
	if (responder) {
		dispatchEvent(responder, event)
	}
}

/**
 * @function invokeListeners
 * @since 0.7.0
 * @hidden
 */
export function invokeListeners(emitter: Emitter, event: Event) {
	getEventListeners(emitter, event.type).forEach(listener => listener.call(emitter, event))
}

/**
 * @function createSingleListener
 * @since 0.7.0
 * @hidden
 */
export function createSingleListener(emitter: Emitter, type: string, listener: any) {

	let callback = listener[$handler]

	if (callback == null) {
		callback = listener[$handler] = function (event: Event) {
			invokeSingleListener(event.sender, listener, event)
			removeSingleListener(event.sender, listener, event)
		}
	}

	return callback
}

/**
 * @function removeSingleListener
 * @since 0.7.0
 * @hidden
 */
export function removeSingleListener(emitter: Emitter, listener: any, event: Event) {

	let listeners = getEventListeners(emitter, event.type)

	let callback = listener[$handler]
	if (callback == null) {
		throw new Error(
			`Cannot remove listener.`
		)
	}

	let index = listeners.indexOf(callback)
	if (index == -1) {
		return
	}

	listeners.splice(index, 1)
}

/**
 * @function invokeSingleListener
 * @since 0.7.0
 * @hidden
 */
export function invokeSingleListener(emitter: Emitter, listener: any, event: Event) {
	listener.call(emitter, event)
}