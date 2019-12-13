import { $container } from './private/Slot'
import { getRenderingComponent } from './private/Component'
import { setSlot } from './private/Component'
import { Collection } from '../view/Collection'
import { View } from '../view/View'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'
import { Component } from './Component'

/**
 * @class Slot
 * @super Collection
 * @since 0.7.0
 */
export class Slot extends Collection {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The slot's name.
	 * @property name
	 * @since 0.7.0
	 */
	public name: string = ""

	/**
	 * Whether this slot is the main slot.
	 * @property main
	 * @since 0.7.0
	 */
	public main: boolean = false

	/**
	 * The slot's container.
	 * @property container
	 * @since 0.7.0
	 */
	public get container(): Component | null {
		return this[$container]
	}

	//--------------------------------------------------------------------------
	// Protected
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onInsert
	 * @since 0.7.0
	 */
	public onInsert(child: View, index: number) {
		if (this.container) {
			this.container.emit<ViewInsertEvent>('insert', { data: { child, index } })
		}
	}

	/**
	 * @inherited
	 * @method onRemove
	 * @since 0.7.0
	 */
	public onRemove(child: View, index: number) {
		if (this.container) {
			this.container.emit<ViewRemoveEvent>('remove', { data: { child, index } })
		}
	}

	/**
	 * @inherited
	 * @method onMoveToParent
	 * @since 0.7.0
	 */
	public onMoveToParent(parent: View | null) {

		if (parent == null) {
			return
		}

		let component = getRenderingComponent()
		if (component == null) {
			return
		}

		this[$container] = component

		setSlot(component, this)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property container
	 * @since 0.7.0
	 * @hidden
	 */
	private [$container]: Component | null = null
}