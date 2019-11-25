import { $native } from './symbol/native'

/**
 * @function create
 * @since 0.7.0
 * @hidden
 */
function create(object: any) {

	let klass = object.constructor[$native]
	if (klass == null) {
		throw new Error(`Class ${object.constructor.name} has not been bridged.`)
	}

	return new klass(object)
}

/**
 * @function toNative
 * @since 0.7.0
 * @hidden
 */
function toNative(object: any) {

	let native = object[$native]
	if (native == null) {
		native = object[$native] = create(object)
	}

	return native
}

/**
 * @function isNative
 * @since 0.7.0
 * @hidden
 */
function isNative(object: any) {
	return object && typeof object == 'object' && object.constructor[$native]
}

/**
 * @function decorate
 * @since 0.1.0
 * @hidden
 */
function decorate(prototype: object, property: string) {

	function get(this: any) {

		let object = native(this)
		if (object == null) {
			throw new Error(`Dezel error: Unable to retrieve native object.`)
		}

		return object[property]
	}

	function set(this: any, value: any) {

		let object = native(this)
		if (object == null) {
			throw new Error(`Dezel error: Unable to retrieve native object.`)
		}

		object[property] = (
			isNative(value) ?
				toNative(value) :
				value
		)
	}

	Object.defineProperty(prototype, property, { get, set })
}

/**
 * @decorator native
 * @since 0.1.0
 */
export function native(object: object): any
export function native(target: object, property: string): void
export function native(...args: Array<any>): any {

	if (args.length == 1) {

		let object = args[0]
		if (object == null) {
			return null
		}

		return toNative(object)
	}

	decorate(args[0], args[1])
}