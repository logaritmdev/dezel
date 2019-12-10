import { $selectedIndex } from './symbol/List'
import { $selectedValue } from './symbol/List'
import { bound } from '../decorator/bound'
import { Event } from '../event/Event'
import { Reference } from '../view/Reference'
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
	 * @property items
	 * @since 0.1.0
	 */
	public get items(): Slot {
		return this.refs.items.get()
	}

	/**
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
	 * @method render
	 * @since 0.7.0
	 */
	public render() {
		return (
			<Root>
				<Slot ref={this.refs.items} main="true" />
			</Root>
		)
	}

	/**
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
	 * @method onBeforeSelect
	 * @since 0.7.0
	 */
	protected onBeforeSelect(index: number) {

	}

	/**
	 * @method onSelect
	 * @since 0.7.0
	 */
	protected onSelect(index: number) {

	}

	/**
	 * @method onDeselect
	 * @since 0.7.0
	 */
	protected onDeselect(index: number) {

	}

	/**
	 * @method onInsert
	 * @since 0.1.0
	 */
	protected onInsert(child: View, index: number) {
		if (child instanceof ListItem) {
			child.on('press', this.onListItemPress)
			// TODO
			// Think about reselecting based on selected index
		}
	}

	/**
	 * @method onRemove
	 * @since 0.1.0
	 */
	protected onRemove(child: View, index: number) {
		if (child instanceof ListItem) {
			child.off('press', this.onListItemPress)

		}
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
	 * @property refs
	 * @since 0.7.0
	 * @hidden
	 */
	private refs = {
		items: new Reference<Slot>()
	}

	/**
	 * @method applySelection
	 * @since 0.4.0
	 * @hidden
	 */
	private applySelection(index: number) {

		let value = this.items.children[index]
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
	 * @method onSegmentedBarButtonPress
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onListItemPress(event: Event) {
		this.select(this.items.children.indexOf(event.sender as ListItem))
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