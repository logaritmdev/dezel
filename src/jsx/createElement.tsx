import { Fragment } from '../view/Fragment'
import { TextView } from '../view/TextView'

/**
 * @const createElement
 * @since 0.4.0
 * @hidden
 */
export function createElement(Type: any, properties: any, ...children: Array<Node>) {

	let view = create(Type, properties)

	if (properties) {

		let style = properties.style as string
		let state = properties.state as string

		if (style) view.addStyles(...style.split(' '))
		if (state) view.setStates(...state.split(' '))

		delete properties.style
		delete properties.state

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

			if (view instanceof TextView) {
				view.text = node
				continue
			}

			view.append(<TextView text={node} />)

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
		Fragment,
		createElement
	},

	writable: false,
	enumerable: false,
	configurable: true
})