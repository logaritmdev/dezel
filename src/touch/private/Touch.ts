import { Emitter } from '../../event/Emitter'
import { View } from '../../view/View'
import { $target } from '../symbol/Touch'
import { $x } from '../symbol/Touch'
import { $y } from '../symbol/Touch'
import { Touch } from '../Touch'

/**
 * @function setTouchX
 * @since 0.7.0
 * @hidden
 */
export function setTouchX(touch: Touch, x: number) {
	touch[$x] = x
}

/**
 * @function setTouchY
 * @since 0.7.0
 * @hidden
 */
export function setTouchY(touch: Touch, y: number) {
	touch[$y] = y
}

/**
 * @function setTouchTarget
 * @since 0.7.0
 * @hidden
 */
export function setTouchTarget(touch: Touch, target: View) {
	touch[$target] = target
}