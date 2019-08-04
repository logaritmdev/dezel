import { Dezel } from '../core/Dezel'
import { NATIVE } from '../native/symbols'

/**
 * @function decorate
 * @since 0.1.0
 * @hidden
 */
function decorate(constructor: any, className: string) {

	let Class = Dezel.importClass(className)
	if (Class == null) {
		throw new Error(
			`Bridge error: ` +
			`The native class ${className} does not exist.`
		)
	}

	for (let key in Class.statics) {
		Class[key] = Class.statics[key]
	}

	constructor[NATIVE] = Class
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
