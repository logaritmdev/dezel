import { Reference } from '../Reference'

/**
 * @symbol value
 * @since 0.7.0
 * @hidden
 */
export const $value = Symbol('value')

/**
 * @symbol references
 * @since 0.7.0
 * @hidden
 */
export const $references = Symbol('references')

/**
 * @function createRef
 * @since 0.7.0
 * @hidden
 */
export function createRef(prototype: any, property: string) {

	let accessor = Symbol(property)

	Object.defineProperty(prototype, property, {

		set(value) {
			this[accessor].set(value)
		},

		get() {

			let reference = this[accessor]
			if (reference == null) {
				reference = this[accessor] = new Reference()
			}

			return reference.value == null ? reference : reference.value
		}

	})

	if (prototype[$references] == null) {
		prototype[$references] = []
	}

	prototype[$references].push(accessor)
}

/**
 * @function validateRefs
 * @since 0.7.0
 * @hidden
 */
export function validateRefs(object: any) {

	let references = object[$references]
	if (references == null) {
		return
	}

	for (let accessor of references) {

		let reference = object[accessor]
		if (reference &&
			reference.value) {
			continue
		}

		throw new Error(`Reference ${getRefName(accessor)} on ${object.constructor.name} has not been set.`)
	}
}

/**
 * @function getRefName
 * @since 0.7.0
 * @hidden
 */
export function getRefName(accessor: Symbol) {
	return accessor.toString().slice(7, -1)
}