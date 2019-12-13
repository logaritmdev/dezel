import { $target } from './Touch'
import { View } from '../../view/View'
import { Emitter } from '../Emitter'
import { TouchEvent } from '../TouchEvent'

/**
 * @symbol touches
 * @since 0.7.0
 * @hidden
 */
export const $touches = Symbol('touches')

/**
 * @symbol activeTouches
 * @since 0.7.0
 * @hidden
 */
export const $activeTouches = Symbol('activeTouches')

/**
 * @symbol targetTouches
 * @since 0.7.0
 * @hidden
 */
export const $targetTouches = Symbol('targetTouches')

/**
 * @function updateTouchTarget
 * @since 0.7.0
 * @hidden
 */
export function updateTouchTarget(event: TouchEvent, target: View) {
	for (let touch of event.touches) {
		touch[$target] = target
	}
}