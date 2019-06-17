import { Placeholder } from '../view/Placeholder'
import { Component } from './Component'

/**
 * @symbol COMPONENT
 * @since 0.7.0
 */
export const COMPONENT = Symbol('component')

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
	 * The component that owns this slot.
	 * @property component
	 * @since 0.7.0
	 */
	public get component(): Component | null | undefined {
		return this[COMPONENT]
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property REFS
	 * @since 0.7.0
	 * @hidden
	 */
	private [COMPONENT]: Component | null | undefined

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
 * @function setComponent
 * @since 0.7.0
 * @hidden
 */
export function setComponent(slot: Slot, component: Component | null | undefined) {
	slot[COMPONENT] = component
}