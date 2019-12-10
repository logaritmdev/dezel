import { $body } from '../symbol/Component'
import { $locked } from '../symbol/Component'
import { $rendered } from '../symbol/Component'
import { $sealed } from '../symbol/Component'
import { $slots } from '../symbol/Component'
import { Component } from '../Component'
import { Slot } from '../Slot'

/**
 * @const renderComponentStack
 * @since 0.7.0
 * @hidden
 */
const renderComponentStack: Array<Component> = []

/**
 * @function lockComponent
 * @since 0.7.0
 * @hidden
 */
export function lockComponent(component: Component) {
	component[$locked] = true
}

/**
 * @function sealComponent
 * @since 0.7.0
 * @hidden
 */
export function sealComponent(component: Component) {
	component[$sealed] = true
}

/**
 * @function unlockComponent
 * @since 0.7.0
 * @hidden
 */
export function unlockComponent(component: Component) {
	component[$locked] = false
}

/**
 * @function unsealComponent
 * @since 0.7.0
 * @hidden
 */
export function unsealComponent(component: Component) {
	component[$sealed] = false
}

/**
 * @function renderComponent
 * @since 0.7.0
 * @hidden
 */
export function renderComponent(component: Component) {

	if (component.rendered) {
		return
	}

	component[$rendered] = true

	pushComponent(component)

	let host = component.render()
	if (host) {

		for (let child of host.children) {
			component.append(child)
		}

	}

	component.emit('render')

	pullComponent(component)
	sealComponent(component)
}

/**
 * @function pushComponent
 * @since 0.7.0
 * @hidden
 */
export function pushComponent(component: Component) {

	let current = getComponent()
	if (current == component) {
		throw new Error(
			`Component error: Component is already being rendered.`
		)
	}

	renderComponentStack.push(component)
}

/**
 * @function pullComponent
 * @since 0.7.0
 * @hidden
 */
export function pullComponent(component: Component) {

	let current = getComponent()
	if (current != component) {
		throw new Error(
			`Component error: Component is not being rendered.`
		)
	}

	renderComponentStack.pop()
}

/**
 * @function getComponent
 * @since 0.7.0
 * @hidden
 */
export function getComponent() {
	return renderComponentStack[renderComponentStack.length - 1]
}

/**
 * @function setComponentSlot
 * @since 0.7.0
 * @hidden
 */
export function setComponentSlot(component: Component, slot: Slot) {

	if (slot.name == '') {
		throw new Error(
			`Component error: Component received a slot with an empty name.`
		)
	}

	if (component[$slots][slot.name] == null) {
		component[$slots][slot.name] = slot
	} else {

		throw new Error(
			`Component error: Component already have a slot named ${slot.name}.`
		)

	}

	if (slot.main) {

		if (component[$body] == null) {
			component[$body] = slot
		} else {

			throw new Error(
				`Component error: Component already have a main slot.`
			)

		}
	}
}

/**
 * @function getComponentSlot
 * @since 0.7.0
 * @hidden
 */
export function getComponentSlot(component: Component, name: string) {
	return component[$slots][name]
}

/**
 * @function getComponentBody
 * @since 0.7.0
 * @hidden
 */
export function getComponentBody(component: Component) {
	return component[$body]
}