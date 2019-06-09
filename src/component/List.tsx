import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'
import { Component } from './Component'
import { ListItem } from './ListItem'
import { ListManager } from './ListManager'
import { Refresher } from './Refresher'
import './List.ds'
import './List.ds.android'
import './List.ds.ios'

/**
 * Displays a scrollable array of elements.
 * @class List
 * @super Component
 * @since 0.1.0
 */
export class List extends Component {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * The list's items.
	 * @property items
	 * @since 0.1.0
	 */
	@watch public items: Array<ListItem> = []

	/**
	 * The list's manager.
	 * @property manager
	 * @since 0.4.0
	 */
	@watch public manager?: ListManager | null = null

	/**
	 * The list's refresher.
	 * @property refresher
	 * @since 0.2.0
	 */
	@watch public refresher?: Refresher | null = null

	/**
	 * Whether the list is selectable.
	 * @property selectable
	 * @since 0.1.0
	 */
	public selectable: boolean = true

	/**
	 * The list's selected item index.
	 * @property selectedIndex
	 * @since 0.1.0
	 */
	public get selectedIndex(): number | undefined | null {
		return this.manager ? this.manager.selectedIndex : this.getSelectedItemIndex()
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method destroy
	 * @since 0.2.0
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

	/**
	 * Selects an item at a specified index.
	 * @method select
	 * @since 0.1.0
	 */
	public select(index: ListItem | number | undefined | null) {

		if (this.manager) {
			this.manager.select(index)
			return this
		}

		if (index instanceof ListItem) {
			index = this.items.indexOf(index)
		}

		if (index == this.selectedIndex) {
			return this
		}

		this.clearSelection()

		if (index == null) {
			return this
		}

		this.applySelection(index)

		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onInsert
	 * @since 0.1.0
	 */
	public onInsert(event: Event<ViewInsertEvent>) {

		super.onInsert(event)

		if (event.data.view instanceof ListItem) {

			event.data.view.on('touchcancel', this.onListItemTouchCancel)
			event.data.view.on('touchstart', this.onListItemTouchStart)
			event.data.view.on('touchend', this.onListItemTouchEnd)

			this.insertListItem(
				event.data.view as ListItem,
				event.data.index
			)
		}
	}

	/**
	 * @inherited
	 * @method onRemove
	 * @since 0.1.0
	 */
	public onRemove(event: Event<ViewRemoveEvent>) {

		super.onRemove(event)

		if (event.data.view instanceof ListItem) {

			event.data.view.off('touchcancel', this.onListItemTouchCancel)
			event.data.view.off('touchstart', this.onListItemTouchStart)
			event.data.view.off('touchend', this.onListItemTouchEnd)

			this.removeListItem(
				event.data.view as ListItem,
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

			let newItems = newValue as Array<ListItem>
			let oldItems = oldValue as Array<ListItem>
			if (oldItems) for (let item of oldItems) this.remove(item)
			if (newItems) for (let item of newItems) this.append(item)

			return
		}

		if (property == 'manager') {

			let newProvider = newValue as ListManager<any>
			let oldProvider = oldValue as ListManager<any>
			if (oldProvider) oldProvider.detach()

			if (newProvider) {
				newProvider.attach(this)
			}

			return
		}

		if (property == 'refresher') {

			let newRefresher = newValue as Refresher
			let oldRefresher = oldValue as Refresher

			if (oldRefresher) {
				oldRefresher.view = null
				this.remove(oldRefresher)
			}

			if (newRefresher) {
				newRefresher.view = this
				this.insert(newRefresher, 0)
			}

			return
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property touch
	 * @since 0.1.0
	 * @hidden
	 */
	private touch?: Touch | null

	/**
	 * @property pressedItem
	 * @since 0.1.0
	 * @hidden
	 */
	private pressedItem?: ListItem | null

	/**
	 * @property selectedItem
	 * @since 0.1.0
	 * @hidden
	 */
	private selectedItem?: ListItem | null

	/**
	 * @method getSelectedItemIndex
	 * @since 0.1.0
	 * @hidden
	 */
	private getSelectedItemIndex() {
		return this.selectedItem ? this.children.indexOf(this.selectedItem) : undefined
	}

	/**
	 * @method applySelection
	 * @since 0.4.0
	 * @hidden
	 */
	private applySelection(index: number) {

		let item = this.items[index]
		if (item == null) {
			return this
		}

		this.selectedItem = item
		this.selectedItem.selected = true

		this.emit<ListSelectEvent>('select', { data: { index } })

		return this
	}

	/**
	 * @method clearSelection
	 * @since 0.4.0
	 * @hidden
	 */
	private clearSelection() {

		if (this.selectedItem) {
			this.selectedItem.selected = false
			this.emit<ListDeselectEvent>('deselect', { data: { index: this.selectedIndex! } })
		}

		this.selectedItem = null

		return this
	}

	/**
	 * @method insertListItem
	 * @since 0.4.0
	 * @hidden
	 */
	private insertListItem(item: ListItem, index: number) {

		if (this.items[index] != item) {
			this.items.splice(index, 0, item)
		}

		return this
	}

	/**
	 * @method removeListItem
	 * @since 0.4.0
	 * @hidden
	 */
	private removeListItem(item: ListItem, index: number) {

		if (this.pressedItem == item) {
			this.pressedItem.pressed = false
			this.pressedItem = null
		}

		if (this.selectedItem == item) {
			this.selectedItem.selected = false
			this.selectedItem = null
		}

		if (this.items[index] == item) {
			this.items.splice(index, 1)
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Private API - Events
	//--------------------------------------------------------------------------

	/**
	 * @method onListItemTouchCancel
	 * @since 0.1.0
	 * @hidden
	 */
	@bound private onListItemTouchCancel(event: TouchEvent) {

		if (this.selectable == false || this.pressedItem == null || this.touch == null) {
			return
		}

		let touch = event.touches.find(this.touch)
		if (touch) {
			this.pressedItem.pressed = false
			this.pressedItem = null
		}
	}

	/**
	 * @method onListItemTouchStart
	 * @since 0.1.0
	 * @hidden
	 */
	@bound private onListItemTouchStart(event: TouchEvent) {

		if (this.selectable == false || this.pressedItem) {
			return
		}

		let item = event.sender as ListItem
		if (item.selectable == false) {
			return
		}

		this.touch = event.touches.item(0)
		this.pressedItem = item as ListItem
		this.pressedItem.pressed = true
	}

	/**
	 * @method onListItemTouchEnd
	 * @since 0.1.0
	 * @hidden
	 */
	@bound private onListItemTouchEnd(event: TouchEvent) {

		if (this.selectable == false || this.pressedItem == null || this.touch == null) {
			return
		}

		let item = this.pressedItem

		let touch = event.touches.find(this.touch)
		if (touch) {

			this.pressedItem.pressed = false
			this.pressedItem = null

			if (touch.hits(item)) {

				if (this.manager) {
					this.manager.select(item)
					return
				}

				this.select(item)
			}
		}
	}
}

/**
 * @type ListSelectEvent
 * @since 0.4.0
 */
export type ListSelectEvent = {
	index: number
}

/**
 * @type ListDeselectEvent
 * @since 0.4.0
 */
export type ListDeselectEvent = {
	index: number
}