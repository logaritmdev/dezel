import { $selectedIndex } from './private/List'
import { $selectedValue } from './private/List'
import { bound } from '../decorator/bound'
import { ref } from '../decorator/ref'
import { Event } from '../event/Event'
import { View } from '../view/View'
import { Component } from './Component'
import { ListItem } from './ListItem'
import { Root } from './Root'
import { Slot } from './Slot'
import './style/List.style'
import './style/List.style.android'
import './style/List.style.ios'

/**
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
	@ref public items: Slot

	/**
	 * The list's selected index.
	 * @property selectedIndex
	 * @since 0.1.0
	 */
	public get selectedIndex(): number | null {
		return this[$selectedIndex]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inhreited
	 * @method render
	 * @since 0.7.0
	 */
	public render() {
		return (
			<Root>
				<Slot ref={this.items} main="true" />
			</Root>
		)
	}

	/**
	 * Selects an item at a specified index.
	 * @method select
	 * @since 0.1.0
	 */
	public select(index: number | null) {

		if (index == this.selectedIndex) {
			return this
		}

		let event = new Event<ListBeforeSelectEvent>('beforeselect', {
			cancelable: true,
			propagable: false,
			data: {
				index
			}
		})

		this.emit(event)

		if (event.canceled) {
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
	 * Called before an item is selected.
	 * @method onBeforeSelect
	 * @since 0.7.0
	 */
	public onBeforeSelect(index: number) {

	}

	/**
	 * Called after an item is selected.
	 * @method onSelect
	 * @since 0.7.0
	 */
	public onSelect(index: number) {

	}

	/**
	 * Called after an item is deselected.
	 * @method onDeselect
	 * @since 0.7.0
	 */
	public onDeselect(index: number) {

	}

	/**
	 * @inherited
	 * @method onInsert
	 * @since 0.1.0
	 */
	public onInsert(child: View, index: number) {
		if (child instanceof ListItem) this.onInsertItem(child, index)
	}

	/**
	 * @inherited
	 * @method onRemove
	 * @since 0.1.0
	 */
	public onRemove(child: View, index: number) {
		if (child instanceof ListItem) this.onRemoveItem(child, index)
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method onInsertItem
	 * @since 0.7.0
	 * @hidden
	 */
	public onInsertItem(item: ListItem, index: number) {

		if (this[$selectedIndex] &&
			this[$selectedIndex]! >= index) {
			this[$selectedIndex]!++
		}

		item.on('press', this.onListItemPress)
	}

	/**
	 * @method onRemoveItem
	 * @since 0.7.0
	 * @hidden
	 */
	public onRemoveItem(item: ListItem, index: number) {

		item.pressed = false

		if (this[$selectedIndex] &&
			this[$selectedIndex]! > index) {
			this[$selectedIndex]!--
		} else if (this[$selectedIndex] == index) {
			this[$selectedIndex] = null
			this[$selectedValue] = null
			item.selected = false
		}

		item.off('press', this.onListItemPress)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property selectedIndex
	 * @since 0.7.0
	 * @hidden
	 */
	private [$selectedIndex]: number | null = null

	/**
	 * @property selectedValue
	 * @since 0.7.0
	 * @hidden
	 */
	private [$selectedValue]: ListItem | null = null

	/**
	 * @method applySelection
	 * @since 0.4.0
	 * @hidden
	 */
	private applySelection(index: number) {

		let value = this.items.get(index)
		if (value == null) {
			return this
		}

		if (value instanceof ListItem) {

			value.selected = true

			this[$selectedIndex] = index
			this[$selectedValue] = value

			this.emit<ListSelectEvent>('select', { data: { index } })
		}

		return this
	}

	/**
	 * @method clearSelection
	 * @since 0.4.0
	 * @hidden
	 */
	private clearSelection() {

		let index = this[$selectedIndex]
		let value = this[$selectedValue]

		if (value == null ||
			index == null) {
			return this
		}

		value.selected = false

		this[$selectedIndex] = null
		this[$selectedValue] = null

		this.emit<ListDeselectEvent>('deselect', { data: { index } })

		return this
	}

	/**
	 * @method onListItemPress
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onListItemPress(event: Event) {
		this.select(this.items.index(event.sender as ListItem))
	}
}

/**
 * @type ListBeforeSelectEvent
 * @since 0.7.0
 */
export type ListBeforeSelectEvent = {
	index: number | null
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