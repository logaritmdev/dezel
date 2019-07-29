import { Placeholder } from '../placeholder/Placeholder'
import { View } from '../view/View'
import { Component } from './Component'

/**
 * @symbol CONTAINER
 * @since 0.7.0
 */
export const CONTAINER = Symbol('container')

/**
 * TODO
 * @class Slot
 * @super Placeholder
 * @since 0.7.0
 */
export abstract class Slot extends Placeholder {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The slot's name.
	 * @property name
	 * @since 0.7.0
	 */
	public abstract get name(): string

	/**
	 * The slot's container.
	 * @property container
	 * @since 0.7.0
	 */
	public get container(): Component | null {
		return this[CONTAINER]
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property CONTAINER
	 * @since 0.7.0
	 * @hidden
	 */
	private [CONTAINER]: Component | null = null

	//--------------------------------------------------------------------------
	// JSX
	//--------------------------------------------------------------------------

	/**
	 * @property __jsxProps
	 * @since 0.4.0
	 * @hidden
	 */
	public __jsxProps: any

}

/**
 * @function setContainer
 * @since 0.7.0
 * @hidden
 */
export function setContainer(slot: Slot, component: Component | null) {
	slot[CONTAINER] = component
}
