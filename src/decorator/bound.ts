/**
 * @function decorate
 * @since 0.1.0
 * @hidden
 */
function decorate(prototype: object, property: string, descriptor: PropertyDescriptor) {

	let callback = descriptor.value

	function get(this: any) {

		let self = this

		let value = function () {
			return callback.apply(self, arguments)
		}

		let descriptor = {
			value: value,
			writable: true,
			enumerable: false,
			configurable: true
		}

		Object.defineProperty(this, property, descriptor)

		return value
	}

	descriptor.configurable = true
	descriptor.get = get
	descriptor.set = undefined

	delete descriptor.value
	delete descriptor.writable

	return descriptor
}

/**
 * TODO: Decorator description
 * @function bound
 * @since 0.1.0
 */
export function bound(prototype: object, property: string, descriptor: PropertyDescriptor) {
	return decorate(prototype, property, descriptor)
}