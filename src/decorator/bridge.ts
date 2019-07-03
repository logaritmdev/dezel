import { Dezel } from '../core/Dezel'

/**
 * @function decorate
 * @since 0.1.0
 * @hidden
 */
function decorate(constructor: Function, className: string) {

	const key = Symbol('native')

	function get(this: any) {

		let native = this[key]
		if (native == null) {
			native = this[key] = Dezel.import(className, true)
			native.holder = this
		}

		return native
	}

	Object.defineProperty(constructor.prototype, 'native', { get })
}

/**
 * TODO: Decorator description
 * @function bridge
 * @since 0.1.0
 */
export function bridge(classname: string) {
	return function (constructor: Function) {
		decorate(constructor, classname)
	}
}
