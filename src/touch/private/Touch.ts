import { Emitter } from '../../event/Emitter'
import { View } from '../../view/View'
import { $canceled } from '../symbol/Touch'
import { $captured } from '../symbol/Touch'
import { $identifier } from '../symbol/Touch'
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
 * @function setTouchIdentifier
 * @since 0.7.0
 * @hidden
 */
export function setTouchIdentifier(touch: Touch, identifier: number) {
	touch[$identifier] = identifier
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
 * @function setTouchLocationX
 * @since 0.7.0
 * @hidden
 */
export function setTouchLocationX(touch: Touch, x: number) {
	touch[$x] = x
}

/**
 * @function setTouchLocationY
 * @since 0.7.0
 * @hidden
 */
export function setTouchLocationY(touch: Touch, y: number) {
	touch[$y] = y
}
