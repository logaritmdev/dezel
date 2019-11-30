import { getComponent } from '../component/private/Component'
import { renderComponent } from '../component/private/Component'
import { setComponentSlot } from '../component/private/Component'
import { Component } from '../component/Component'
import { Root } from '../component/Root'
import { Slot } from '../component/Slot'
import { View } from '../view/View'

/**
 * @function createElement
 * @since 0.4.0
 * @hidden
 */
export function createElement(Type: any, properties: any, ...children: Array<View>) {

	let node = create(Type, properties)

	if (node instanceof Root) {
		node.reset(children)
		return node
	}

	if (node instanceof Component) {
		renderComponent(node)
	}

	if (properties) {

		let style = properties.style as string
		let state = properties.state as string

		if (style) setStyles(node, ...style.split(' '))
		if (state) setStates(node, ...state.split(' '))

		delete properties.style
		delete properties.state

		for (let key in properties) {

			if (key == 'children') {
				console.error('Cannot assign the children property on the constructor')
				continue
			}

			assign(node, key, properties[key])
		}
	}

	append(node, children)

	return node
}

/**
 * @const create
 * @since 0.5.0
 * @hidden
 */
function create(Type: any, properties: any) {

	if (Type == null) {

		throw new Error(
			`JSX error: ` +
			`Unable to create element, type is null.`
		)

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

		if (node instanceof Slot) {

			/*
			 * When appending a slot to a view we must check first if its
			 * bound to a containing component. In that case we can safely
			 * treat this slot as a definition and execute the define
			 * method from its container.
			 */

			let component = getComponent()
			if (component) {
				setComponentSlot(component, node)
			}
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
	for (let style of styles) view.styles.append(style)
}

/**
 * @function setStates
 * @since 0.7.0
 * @hidden
 */
function setStates(view: View, ...states: Array<string>) {
	for (let state of states) view.states.append(state)
}

/**
 * @function set
 * @since 0.4.0
 * @hidden
 */
function assign(view: any, key: string, value: any) {

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

	let coherse = primitive || value instanceof Array
	// TODO
	// Finish this
	if (coherse) {
		let receiver = view[key]
		if (receiver &&
			receiver.setDefaultValue) {
			let handled = receiver.setDefaultValue(value)
			if (handled) {
				return
			}
		}
	}

	view[key] = value
}

/**
 * @const React
 * @since 0.3.0
 * @hidden
 */
Object.defineProperty(global, 'React', {

	value: {
		createElement
	},

	writable: false,
	enumerable: false,
	configurable: true
})