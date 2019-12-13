import { $items } from './Collection'
import { Recycler } from '../Recycler'
import { View } from '../View'

/**
 * @symbol data
 * @since 0.7.0
 * @hidden
 */
export const $data = Symbol('data')

/**
 * @symbol view
 * @since 0.7.0
 * @hidden
 */
export const $view = Symbol('view')

/**
 * @symbol collection
 * @since 0.7.0
 * @hidden
 */
export const $collection = Symbol('collection')

/**
 * @symbol getViewType
 * @since 0.7.0
 * @hidden
 */
export const $getViewType = Symbol('getViewType')

/**
 * @symbol onInsertView
 * @since 0.7.0
 * @hidden
 */
export const $onInsertView = Symbol('onInsertView')

/**
 * @symbol onRemoveView
 * @since 0.7.0
 * @hidden
 */
export const $onRemoveView = Symbol('onRemoveView')

/**
 * @function insertView
 * @since 0.7.0
 * @hidden
 */
export function insertView<T>(recycler: Recycler<T>, child: View, index: number) {
	recycler[$collection][$items][index] = child
}

/**
 * @function removeView
 * @since 0.7.0
 * @hidden
 */
export function removeView<T>(recycler: Recycler<T>, child: View, index: number) {
	delete recycler[$collection][$items][index]
}