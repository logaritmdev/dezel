import { Collection } from '../Collection'
import { View } from '../View'

/**
 * @symbol target
 * @since 0.7.0
 * @hidden
 */
export const $target = Symbol('target')

/**
 * @symbol offset
 * @since 0.7.0
 * @hidden
 */
export const $offset = Symbol('offset')

/**
 * @symbol length
 * @since 0.7.0
 * @hidden
 */
export const $length = Symbol('length')

/**
 * @symbol items
 * @since 0.7.0
 * @hidden
 */
export const $items = Symbol('items')

/**
 * @function insertItem
 * @since 0.7.0
 * @hidden
 */
export function insertItem(collection: Collection, child: View, index: number) {
	collection[$items].splice(index, 0, child)
}

/**
 * @function removeItem
 * @since 0.7.0
 * @hidden
 */
export function removeItem(collection: Collection, child: View, index: number) {
	collection[$items].splice(index, 1)
}

/**
 * @function insertView
 * @since 0.7.0
 * @hidden
 */
export function insertView(collection: Collection, child: View, index: number) {
	if (collection[$target]) {
		collection[$target].insert(child, index + collection[$offset])
	}
}

/**
 * @function removeView
 * @since 0.7.0
 * @hidden
 */
export function removeView(collection: Collection, child: View, index: number) {
	if (collection[$target]) {
		collection[$target].remove(child)
	}
}