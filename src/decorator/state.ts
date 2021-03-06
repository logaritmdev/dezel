const decorate = function (prototype: object, property: string) {
	// TODO
	// Inherit existing property descriptor
	const descriptor = Object.getOwnPropertyDescriptor(prototype, property)
	const getter = descriptor && descriptor.get
	const setter = descriptor && descriptor.set

	const key = Symbol()
	// TODO use a has key to detect if the value has been set
	let get = function (this: any) {
		return getter ? getter.call(this) : this[key]
	}

	let set = function (this: any, value: boolean) {

		if (this[key] === undefined) {
			this[key] = value
			return
		}

		this.setState(property, value)

		this[key] = value
	}

	Object.defineProperty(prototype, property, { get, set })
}

/**
 * TODO: Decorator description
 * @function state
 * @since 0.1.0
 */
export function state(prototype: object, property: string) {
	decorate(prototype, property)
}
