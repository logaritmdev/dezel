import { setRef } from '../component/Component'
import { Component } from '../component/Component'
import { setChildren } from '../component/Host'
import { setProperties } from '../component/Host'
import { Host } from '../component/Host'
import { Slot } from '../component/Slot'
import { Placeholder } from '../placeholder/Placeholder'
import { View } from '../view/View'

/**
 * @symbol MAIN
 * @since 0.7.0
 */
export const MAIN = Symbol('main')

/**
 * @symbol CONTAINER
 * @since 0.7.0
 */
export const CONTAINER = Symbol('container')

/**
 * @function createElement
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

			let identifier = properties.id
			if (identifier) {
				setRef(container, identifier, view)
			}

			setContainer(view, container)
		}

		delete properties.for

		let main = properties.main
		if (main) {
			setMain(view, main)
		}

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

		if (node instanceof Slot) {

			/*
			 * When appending a slot to a view we must check first if its
			 * bound to a containing component. In that case we can safely
			 * treat this slot as a definition and execute the define
			 * method from its container.
			 */

			let container = getContainer(node)
			if (container) {
				container.defineSlot(node, view, getMain(view))
				continue
			}
		}

		if (node instanceof Placeholder) {
			node.enter(view, view.children.length)
			continue
		}

		view.append(node)
	}
}

/**
 * @function setMain
 * @since 0.7.0
 * @hidden
 */
function setMain(slot: any, main: boolean) {
	slot[MAIN] = main
}

/**
 * @function getMain
 * @since 0.7.0
 * @hidden
 */
function getMain(slot: any) {
	return slot[MAIN]
}

/**
 * @function setContainer
 * @since 0.7.0
 * @hidden
 */
function setContainer(view: any, container: Component) {
	view[CONTAINER] = container
}

/**
 * @function getContainer
 * @since 0.7.0
 * @hidden
 */
function getContainer(view: any): Component | null | undefined {
	return view[CONTAINER]
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