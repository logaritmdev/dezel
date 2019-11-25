import { $responder } from '../symbol/Emitter'
import { Emitter } from '../Emitter'

/**
 * @function setEmitterResponder
 * @since 0.7.0
 * @hidden
 */
export function setEmitterResponder(emitter: Emitter, responder: Emitter | null) {
	emitter[$responder] = responder
}