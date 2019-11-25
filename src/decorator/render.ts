import { renderComponent } from '../component/private/Component'
import { Component } from '../component/Component'

/**
 * @function decorate
 * @since 0.7.0
 * @hidden
 */
function decorate(prototype: object, property: string, descriptor: PropertyDescriptor | undefined) {

	let define = descriptor == null

	let setter: any = null
	let getter: any = null

	if (descriptor == null) {
		descriptor = Object.getOwnPropertyDescriptor(prototype, property)
	}

	if (descriptor) {
		setter = descriptor.set
		getter = descriptor.get
	}

	let get = getter && function (this: Component) {

		if (this.rendered == false) {
			renderComponent(this)
		}

		return getter.call(this)

	} || undefined

	let set = setter && function (this: Component, value: any) {

		if (this.rendered == false) {
			renderComponent(this)
		}

		return setter.call(this, value)

	} || undefined

	if (define) {

		Object.defineProperty(prototype, property, { get, set })

	} else {

		if (descriptor) {
			descriptor.set = set
			descriptor.get = get
		}

	}
}

/**
 * @decorator render
 * @since 0.7.0
 */
export function render(prototype: object, property: string, descriptor: PropertyDescriptor | undefined) {
	decorate(prototype, property, descriptor)
}
