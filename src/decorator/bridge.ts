import { Dictionary } from 'lodash'

/**
 * Caches native imports.
 * @const imports
 * @since 0.2.0
 */
const imports: Dictionary<any> = {}

/**
 * @function decorate
 * @since 0.1.0
 * @hidden
 */
function decorate(constructor: Function, classname: string) {

	const key = Symbol('native')

	const get = function (this: any) {

		let native = this[key]
		if (native == null) {

			let Native = imports[classname]
			if (Native == null) {
				Native = imports[classname] = dezel.imports(classname)
			}

			native = this[key] = new Native()
			native.holder = this
		}

		return native
	}

	dezel.exports(classname, constructor)

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
