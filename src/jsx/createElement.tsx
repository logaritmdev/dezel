import { setRef } from '../component/Component'
import { Component } from '../component/Component'
import { setChildren } from '../component/Host'
import { setProperties } from '../component/Host'
import { Host } from '../component/Host'
import { Slot } from '../component/Slot'
import { Placeholder } from '../view/Placeholder'
import { View } from '../view/View'

/**
 * @const createElement
 * @since 0.4.0
 * @hidden
 */
export function createElement(Type: any, properties: any, ...children: Array<View>) {

	let view = create(Type, properties)

	if (view instanceof Host) {
		setChildren(view, children)
		setProperties(view, properties)
		return view
	}

	if (view instanceof Component) {
		view.build()
	}

	if (properties) {

		let style = properties.style as string
		let state = properties.state as string

		if (style) setStyles(view, ...style.split(' '))
		if (state) setStates(view, ...state.split(' '))

		delete properties.style
		delete properties.state

		let container = properties.for as Component
		if (container) {

			if (view instanceof Slot) {

				if (view.component == null) {
					container.useSlot(view)
				}

			} else {

				let identifier = properties.id
				if (identifier) {
					setRef(container, identifier, view)
				}

			}
		}

		delete properties.for

		for (let key in properties) {

			if (key == 'children') {
				console.error('Cannot assign the children property on the constructor')
				continue
			}

			set(view, key, properties[key])
		}
	}

	append(view, children)

	return view
}

/**
 * @const create
 * @since 0.5.0
 * @hidden
 */
function create(Type: any, properties: any) {

	if (Type == null) {
		throw new Error(`
			JSX Error:
			Unable to create element, type is null.
		`)
	}

	if (properties == null ||
		properties.init == null) {
		return new Type()
	}

	let args = properties.init

	switch (typeof args) {

		case 'number':
		case 'string':
		case 'boolean':
			args = [args]
			break

		case 'object':
			args = args && Object.values(args) || []
	}

	return new Type(...args)
}

/**
 * @const append
 * @since 0.5.0
 * @hidden
 */
function append(view: any, children: Array<any>) {

	for (let node of children) {

		let type = typeof node

		if (type == 'string' ||
			type == 'number' ||
			type == 'boolean') {
			view.text = String(node)
			continue
		}

		if (node instanceof Array) {
			append(view, node)
			continue
		}

		view.append(node)
	}
}

/**
 * @function setStyles
 * @since 0.7.0
 * @hidden
 */
function setStyles(view: View, ...styles: Array<string>) {
	for (let style of styles) view.setStyle(style)
}

/**
 * @function setStates
 * @since 0.7.0
 * @hidden
 */
function setStates(view: View, ...states: Array<string>) {
	for (let state of states) view.setState(state)
}

/**
 * @function set
 * @since 0.4.0
 * @hidden
 */
function set(view: any, key: string, value: any) {

	let type = typeof value

	let event = (
		key[0] == 'o' &&
		key[1] == 'n' &&
		type == 'function'
	)

	if (event) {

		let type = key.substring(2).toLowerCase()
		if (type == '') {
			return
		}

		view.on(type, value)

		return
	}

	let primitive = false

	switch (type) {
		case 'string':
		case 'number':
		case 'boolean':
			primitive = true
			break
	}

	if (primitive) {
		let receiver = view[key]
		if (receiver &&
			receiver.setDefaultValue) {
			receiver.setDefaultValue(value)
			return
		}
	}

	view[key] = value
}

/**
 * @const React
 * @since 0.3.0
 * @hidden
 */
Object.defineProperty(self, 'React', {

	value: {
		createElement
	},

	writable: false,
	enumerable: false,
	configurable: true
})