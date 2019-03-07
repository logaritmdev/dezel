import { BUILT } from '../view/View'
import { addRef } from '../view/View'
import { getRef } from '../view/View'
import { Component } from '../component/Component'

const decorate = function (prototype: object, property: string) {

	const key = Symbol(property)
	const has = Symbol(property)

	const get = function (this: any) {
		if (this[BUILT] == false) {
			if (this instanceof Component) {
				this.build()
			}
		}

		return this[key]
	}

	const set = function (this: any, value: any) {

		if (this[has] == null) {
			this[has] = true
			this[key] = value
			return
		}

		console.error(`
			Ref error:
			The ref ${property} has already been initialized on ${this.constructor.name}.
		`)
	}

	addRef(prototype, property, property)

	Object.defineProperty(prototype, property, { get, set })
}

/**
 * TODO: Decorator description
 * @function ref
 * @since 0.2.0
 */
export function ref(prototype: object, property: string): void {
	return decorate(prototype, property)
}