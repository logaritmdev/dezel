import { Placeholder } from '../view/Placeholder'
import { Component } from './Component'

/**
 * @symbol CONTAINER
 * @since 0.7.0
 */
export const CONTAINER = Symbol('component')

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
	 * The slot name.
	 * @property name
	 * @since 0.7.0
	 */
	public abstract get name(): string

	/**
	 * The container that defines this slot.
	 * @property container
	 * @since 0.7.0
	 */
	public get container(): Component | null | undefined {
		return this[CONTAINER]
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property REFS
	 * @since 0.7.0
	 * @hidden
	 */
	private [CONTAINER]: Component | null | undefined

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
export function setContainer(slot: Slot, component: Component | null | undefined) {
	slot[CONTAINER] = component
}