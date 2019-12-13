import { getRenderingComponent } from '../component/private/Component'
import { renderComponent } from '../component/private/Component'
import { setSlot } from '../component/private/Component'
import { setValueOf } from './private/createElement'
import { Component } from '../component/Component'
import { Slot } from '../component/Slot'
import { Emitter } from '../event/Emitter'
import { View } from '../view/View'

/**
 * @function createElement
 * @since 0.4.0
 * @hidden
 */
export function createElement(Type: any, properties: any, ...children: Array<View>) {

	let node = new Type()

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

			if (key == 'ref') {
				properties[key].set(node)
				continue
			}

			setValue(node, key, properties[key])
		}
	}

	if (node.onCompose) {

		for (let child of children) {
			node.onCompose(child)
		}

		return children

	} else {

		append(node, children)

	}

	return node
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
 * @function setValue
 * @since 0.7.0
 * @hidden
 */
function setValue(view: any, key: string, value: any) {

	let type = typeof value

	let event = (
		key[0] == 'o' &&
		key[1] == 'n' &&
		type == 'function' &&
		view instanceof Emitter
	)

	if (event) {

		let type = key.substring(2).toLowerCase()
		if (type) {
			view.on(type, value)
		}

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

		/*
		 * Allow primitive values to be assigned to object for convenience. In
		 * this case it will invoke the setValueOf symbol of the object with
		 * the primitive value
		 */

		if (receiver && typeof receiver == 'object') {
			if (receiver[setValueOf]) {
				receiver[setValueOf].call(receiver, value)
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