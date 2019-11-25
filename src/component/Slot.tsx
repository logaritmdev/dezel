import { Placeholder } from '../view/Placeholder'
import { View } from '../view/View'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'
import { getComponent } from './private/Component'
import { setComponentSlot } from './private/Component'
import { $container } from './symbol/Slot'
import { Component } from './Component'

/**
 * @class Slot
 * @super Placeholder
 * @since 0.7.0
 */
export class Slot extends Placeholder {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property name
	 * @since 0.7.0
	 */
	public name: string = ""

	/**
	 * @property main
	 * @since 0.7.0
	 */
	public main: boolean = false

	/**
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
	 * @method onInsert
	 * @since 0.7.0
	 */
	protected onInsert(child: View, index: number) {
		if (this.container) {
			this.container.emit<ViewInsertEvent>('insert', { data: { child, index } })
		}
	}

	/**
	 * @method onRemove
	 * @since 0.7.0
	 */
	protected onRemove(child: View, index: number) {
		if (this.container) {
			this.container.emit<ViewRemoveEvent>('remove', { data: { child, index } })
		}
	}

	/**
	 * @method onMoveToParent
	 * @since 0.7.0
	 */
	protected onMoveToParent(parent: View | null) {

		if (parent) {

			let component = getComponent()
			if (component == null) {
				return
			}

			this[$container] = component

			setComponentSlot(component, this)

		} else {
			// TODO
		}
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