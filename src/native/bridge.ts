import { Dezel } from '../core/Dezel'
import { $native } from './symbol/native'

/**
 * @function decorate
 * @since 0.1.0
 * @hidden
 */
function decorate(constructor: any, className: string) {

	let klass = Dezel.importClass(className)
	if (klass == null) {
		throw new Error(
			`Dezel error: ` +
			`The native class ${className} does not exist.`
		)
	}

	for (let key in klass.statics) {
		klass[key] = klass.statics[key]
	}

	constructor[$native] = klass
}

/**
 * @decorator bridge
 * @since 0.1.0
 */
export function bridge(classname: string) {
	return function (constructor: Function) {
		decorate(constructor, classname)
	}
}
