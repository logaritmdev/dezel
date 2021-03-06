
/**
 * @function decorate
 * @since 0.4.0
 */
const decorate = function (prototype: object, property: string) {

	const key = Symbol()
	const has = Symbol()

	const get = function (this: any) {
		return this[key]
	}

	const set = function (this: any, value: any) {

		if (this[has] == null) {
			this[has] = true
			this[key] = value
			return
		}

		let current = this[key]
		if (current == value) {
			return
		}

		this[key] = value

		if (this.onPropertyChange) {
			this.onPropertyChange(property, value, current)
		} else {
			console.error('Watched property does not implement onPropertyChange.')
		}
	}

	Object.defineProperty(prototype, property, { get, set })
}

/**
 * TODO: Decorator description
 * @function watch
 * @since 0.1.0
 */
export function watch(prototype: object, property: string) {
	decorate(prototype, property)
}