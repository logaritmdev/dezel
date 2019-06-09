import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'
import { Component } from './Component'
import { PagerItem } from './PagerItem'
import { PagerManager } from './PagerManager'
import './Pager.ds'
import './Pager.ds.android'
import './Pager.ds.ios'

/**
 * @symbol RESETTING
 * @since 0.4.0
 */
export const RESETTING = Symbol('resetting')

/**
 * Displays a pressable element that performs an action.
 * @class Pager
 * @super Component
 * @since 0.3.0
 */
export class Pager<T extends PagerItem = PagerItem> extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The pager's items.
	 * @property items
	 * @since 0.4.0
	 */
	@watch public items: Array<T> = []

	/**
	 * The pager's manager.
	 * @property manager
	 * @since 0.4.0
	 */
	@watch public manager?: PagerManager | null = null

	/**
	 * The pager's current page.
	 * @property page
	 * @since 0.4.0
	 */
	public get page(): number {
		return Math.floor(this.scrollLeft / this.measuredInnerWidth)
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method destroy
	 * @since 0.4.0
	 */
	public destroy() {

		this.items = []

		if (this.manager) {
			this.manager.detach()
			this.manager.destroy()
			this.manager = null
		}

		super.destroy()
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onInsert
	 * @since 0.4.0
	 */
	public onInsert(event: Event<ViewInsertEvent>) {

		super.onInsert(event)

		if (event.data.view instanceof PagerItem) {

			if (this.manager) {
				return
			}

			this.insertPagerItem(
				event.data.view as T,
				event.data.index
			)
		}
	}

	/**
	 * @inherited
	 * @method onRemove
	 * @since 0.4.0
	 */
	public onRemove(event: Event<ViewRemoveEvent>) {

		super.onRemove(event)

		if (event.data.view instanceof PagerItem) {

			if (this.manager) {
				return
			}

			this.removePagerItem(
				event.data.view as T,
				event.data.index
			)
		}
	}

	/**
	 * @inherited
	 * @method onPropertyChange
	 * @since 0.4.0
	 */
	public onPropertyChange(property: string, newValue: any, oldValue: any) {

		if (property == 'items') {

			let newItems = newValue as Array<PagerItem>
			let oldItems = oldValue as Array<PagerItem>
			if (oldItems) for (let item of oldItems) this.remove(item)
			if (newItems) for (let item of newItems) this.append(item)

			return
		}

		if (property == 'manager') {

			this.items = []

			let newManager = newValue as PagerManager<any>
			let oldManager = oldValue as PagerManager<any>
			if (oldManager) oldManager.detach()
			if (newManager) newManager.attach(this)

			return
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method insertPagerItem
	 * @since 0.4.0
	 * @hidden
	 */
	private insertPagerItem(item: T, index: number) {

		if (this.items[index] != item) {
			this.items.splice(index, 0, item)
		}

		return this
	}

	/**
	 * @method removePagerItem
	 * @since 0.4.0
	 * @hidden
	 */
	private removePagerItem(item: T, index: number) {

		if (this.items[index] == item) {
			this.items.splice(index, 1)
		}

		return this
	}
}
