/**
 * @function decorate
 * @since 0.1.0
 * @hidden
 */
function decorate(prototype: object, property: string) {

	let descriptor = Object.getOwnPropertyDescriptor(prototype, property)
	let getter = descriptor && descriptor.get
	let setter = descriptor && descriptor.set

	let key = Symbol()

	let get = function (this: any) {
		return getter ? getter.call(this) : this[key]
	}

	let set = function (this: any, value: boolean) {

		if (this[key] === undefined) {
			this[key] = value
			return
		}

		if (value) {
			this.states.append(property)
		} else {
			this.states.remove(property)
		}

		if (setter) {
			setter.call(this, value)
		}

		this[key] = value
	}

	Object.defineProperty(prototype, property, { get, set })
}

/**
 * @decorator state
 * @since 0.1.0
 */
export function state(prototype: object, property: string) {
	decorate(prototype, property)
}
