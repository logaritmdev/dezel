import { Component } from '../Component'
import { Slot } from '../Slot'

/**
 * @symbol locked
 * @since 0.7.0
 * @hidden
 */
export const $locked = Symbol('locked')

/**
 * @symbol sealed
 * @since 0.7.0
 * @hidden
 */
export const $sealed = Symbol('sealed')

/**
 * @symbol rendered
 * @since 0.7.0
 * @hidden
 */
export const $rendered = Symbol('rendered')

/**
 * @symbol slots
 * @since 0.7.0
 * @hidden
 */
export const $slots = Symbol('slots')

/**
 * @symbol body
 * @since 0.7.0
 * @hidden
 */
export const $body = Symbol("body")

/**
 * @const renderComponentStack
 * @since 0.7.0
 * @hidden
 */
const renderComponentStack: Array<Component> = []

/**
 * @function getSlot
 * @since 0.7.0
 * @hidden
 */
export function getSlot(component: Component, name: string) {
	return component[$slots][name]
}

/**
 * @function setSlot
 * @since 0.7.0
 * @hidden
 */
export function setSlot(component: Component, slot: Slot) {

	if (slot.name == '' &&
		slot.main == false) {
		throw new Error(`Component error: Component received a slot with an empty name.`)
	}

	if (slot.main) {

		if (component[$body] == null) {
			component[$body] = slot
			return
		}

		throw new Error(`Component error: Component already have a main slot.`)
	}

	if (component[$slots][slot.name] == null) {
		component[$slots][slot.name] = slot
		return
	}

	throw new Error(`Component error: Component already have a slot named ${slot.name}.`)
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

	pushRenderingComponent(component)
	makeComponent(component)
	pullRenderingComponent(component)

	component.emit('render')

	component[$sealed] = true
	component[$locked] = false
}

/**
 * @function makeComponent
 * @since 0.7.0
 * @hidden
 */
export function makeComponent(component: Component) {

	let host = component.render()
	if (host == null) {
		return
	}

	for (let child of host.children) {
		component.append(child)
	}
}

/**
 * @function pushComponent
 * @since 0.7.0
 * @hidden
 */
export function pushRenderingComponent(component: Component) {

	let current = getRenderingComponent()
	if (current == component) {
		throw new Error(`Unexpected error.`)
	}

	renderComponentStack.push(component)
}

/**
 * @function pullComponent
 * @since 0.7.0
 * @hidden
 */
export function pullRenderingComponent(component: Component) {

	let current = getRenderingComponent()
	if (current != component) {
		throw new Error(`Unexpected error.`)
	}

	renderComponentStack.pop()
}

/**
 * @function getComponent
 * @since 0.7.0
 * @hidden
 */
export function getRenderingComponent() {
	return renderComponentStack[renderComponentStack.length - 1]
}
