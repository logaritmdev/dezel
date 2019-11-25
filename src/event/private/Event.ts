import { $sender } from '../symbol/Event'
import { $target } from '../symbol/Event'
import { Emitter } from '../Emitter'
import { Event } from '../Event'

/**
 * @function setEventTarget
 * @since 0.7.0
 * @hidden
 */
export function setEventTarget(event: Event, target: Emitter) {
	event[$target] = target
}

/**
 * @function setEventSender
 * @since 0.7.0
 * @hidden
 */
export function setEventSender(event: Event, sender: Emitter) {
	event[$sender] = sender
}
