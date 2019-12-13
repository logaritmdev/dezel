import { native } from '../../native/native'
import { View } from '../View'

/**
 * @symbol children
 * @since 0.7.0
 * @hidden
 */
export const $children = Symbol('children')

/**
 * @symbol gestures
 * @since 0.7.0
 * @hidden
 */
export const $gestures = Symbol('gestures')

/**
 * @symbol states
 * @since 0.7.0
 * @hidden
 */
export const $states = Symbol('states')

/**
 * @symbol styles
 * @since 0.7.0
 * @hidden
 */
export const $styles = Symbol('states')

/**
 * @const classNames
 * @since 0.7.0
 * @hidden
 */
export const classNames = new Map<any, any>()

/**
 * @function insertItem
 * @since 0.7.0
 * @hidden
 */
export function insertItem(view: View, child: View, index: number) {
	view[$children].splice(index, 0, child)
}

/**
 * @function removeItem
 * @since 0.7.0
 * @hidden
 */
export function removeItem(view: View, child: View, index: number) {
	view[$children].splice(index, 1)
}

/**
 * @function insertView
 * @since 0.7.0
 * @hidden
 */
export function insertView(view: View, child: View, index: number) {
	native(view).insert(native(child), index)
}

/**
 * @function removeView
 * @since 0.7.0
 * @hidden
 */
export function removeView(view: View, child: View, index: number) {
	native(view).remove(native(child), index)
}

/**
 * @function getClassName
 * @since 0.2.0
 * @hidden
 */
export function getClassName(view: View) {

	if (view.constructor == View) {
		return 'View'
	}

	let className = classNames.get(view.constructor)
	if (className == null) {
		classNames.set(view.constructor, className = getClassList(view))
	}

	return className
}

/**
 * @function getClassList
 * @since 0.4.0
 * @hidden
 */
export function getClassList(view: View) {

	let klass = view.constructor.name
	let proto = view.constructor.prototype

	while (proto) {

		proto = Object.getPrototypeOf(proto)

		let constructor = proto.constructor
		if (constructor == View) {
			proto = null
		}

		klass = klass + ' ' + constructor.name
	}

	return klass
}
