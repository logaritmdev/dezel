import { Emitter } from '../../event/Emitter'
import { View } from '../../view/View'
import { $canceled } from '../symbol/Touch'
import { $captured } from '../symbol/Touch'
import { $id } from '../symbol/Touch'
import { $target } from '../symbol/Touch'
import { $x } from '../symbol/Touch'
import { $y } from '../symbol/Touch'
import { Touch } from '../Touch'

/**
 * @function setTouchTarget
 * @since 0.7.0
 * @hidden
 */
export function setTouchTarget(touch: Touch, target: any) {
	touch[$target] = target
}

/**
 * @function setTouchCaptured
 * @since 0.7.0
 * @hidden
 */
export function setTouchCaptured(touch: Touch, captured: boolean) {
	touch[$captured] = captured
}

/**
 * @function setTouchCanceled
 * @since 0.7.0
 * @hidden
 */
export function setTouchCanceled(touch: Touch, canceled: boolean) {
	touch[$canceled] = canceled
}

/**
 * @function setTouchId
 * @since 0.7.0
 * @hidden
 */
export function setTouchId(touch: Touch, id: number) {
	touch[$id] = id
}

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
