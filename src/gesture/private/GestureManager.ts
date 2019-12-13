import { GestureDetector } from '../GestureDetector'
import { GestureManager } from '../GestureManager'

/**
 * @symbol view
 * @since 0.7.0
 * @hidden
 */
export const $view = Symbol('view')

/**
 * @symbol gestures
 * @since 0.7.0
 * @hidden
 */
export const $gestures = Symbol('gestures')

/**
 * @function insertItem
 * @since 0.7.0
 * @hidden
 */
export function insertItem(manager: GestureManager, gesture: GestureDetector) {
	manager[$gestures].push(gesture)
}

/**
 * @function removeItem
 * @since 0.7.0
 * @hidden
 */
export function removeItem(manager: GestureManager, gesture: GestureDetector, index: number) {
	manager[$gestures].splice(index, 1)
}