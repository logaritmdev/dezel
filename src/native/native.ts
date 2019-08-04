import { NATIVE } from './symbols'

/**
 * @function decorate
 * @since 0.1.0
 * @hidden
 */
function decorate(prototype: object, property: string) {

	function get(this: any) {
		return native(this)[property]
	}

	function set(this: any, value: any) {
		native(this)[property] = isNative(value) ? toNative(value) : value
	}

	Object.defineProperty(prototype, property, { get, set })
}

/**
 * TODO: Decorator description
 * @function native
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

/**
 * @function connect
 * @since 0.7.0
 * @hidden
 */
function connect(object: any) {

	let Class = object.constructor[NATIVE]
	if (Class == null) {
		throw new Error(
			`Class ${object.constructor.name} has not been bridged.`
		)
	}

	let native = new Class()
	native.holder = object
	return native
}

/**
 * @function toNative
 * @since 0.7.0
 * @hidden
 */
function toNative(object: any) {

	let native = object[NATIVE]
	if (native == null) {
		native = object[NATIVE] = connect(object)
	}

	return native
}

/**
 * @function isNative
 * @since 0.7.0
 * @hidden
 */
function isNative(object: any) {
	return object && typeof object == 'object' && object.constructor[NATIVE]
}