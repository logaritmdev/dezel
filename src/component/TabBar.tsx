import { $selectedIndex } from './symbol/TabBar'
import { $selectedValue } from './symbol/TabBar'
import { bound } from '../decorator/bound'
import { Event } from '../event/Event'
import { Reference } from '../view/Reference'
import { View } from '../view/View'
import { Component } from './Component'
import { Root } from './Root'
import { Slot } from './Slot'
import { TabBarButton } from './TabBarButton'
import './style/TabBar.style'
import './style/TabBar.style.android'
import './style/TabBar.style.ios'

/**
 * @class TabBar
 * @super Component
 * @since 0.1.0
 */
export class TabBar extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property buttons
	 * @since 0.1.0
	 */
	public get buttons(): Slot {
		return this.refs.buttons.get()
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
				<Slot ref={this.refs.buttons} main={true}></Slot>
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

		let event = new Event<TabBarBeforeSelectEvent>('beforeselect', {
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
	 * @method onEvent
	 * @since 0.7.0
	 */
	public onEvent(event: Event) {

		switch (event.type) {

			case 'beforeselect':
				this.onBeforeSelect(event.data.index)
				break

			case 'select':
				this.onSelect(event.data.index)
				break

			case 'deselect':
				this.onDeselect(event.data.index)
				break
		}

		super.onEvent(event)
	}

	/**
	 * @method onBeforeSelect
	 * @since 0.1.0
	 */
	protected onBeforeSelect(index: number) {

	}

	/**
	 * @method onSelect
	 * @since 0.1.0
	 */
	protected onSelect(index: number) {

	}

	/**
	 * @method onDeselect
	 * @since 0.1.0
	 */
	protected onDeselect(index: number) {

	}

	/**
	 * @method onInsert
	 * @since 0.1.0
	 */
	protected onInsert(child: View, index: number) {
		if (child instanceof TabBarButton) {
			child.on('press', this.onTabBarButtonPress)
		}
	}

	/**
	 * @method onRemove
	 * @since 0.1.0
	 */
	protected onRemove(child: View, index: number) {
		if (child instanceof TabBarButton) {
			child.off('press', this.onTabBarButtonPress)
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
	private [$selectedValue]: TabBarButton | null = null

	/**
	 * @property refs
	 * @since 0.7.0
	 * @hidden
	 */
	private refs = {
		buttons: new Reference<Slot>()
	}

	/**
	 * @method applySelection
	 * @since 0.4.0
	 * @hidden
	 */
	private applySelection(index: number) {

		let value = this.buttons.children[index]
		if (value == null) {
			return this
		}

		if (value instanceof TabBarButton) {

			value.selected = true

			this[$selectedIndex] = index
			this[$selectedValue] = value

			this.emit<TabBarSelectEvent>('select', { data: { index } })
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

		this.emit<TabBarDeselectEvent>('deselect', { data: { index } })

		return this
	}

	//--------------------------------------------------------------------------
	// Private API - Events
	//--------------------------------------------------------------------------

	/**
	 * @method onTabBarButtonTap
	 * @since 0.1.0
	 */
	@bound private onTabBarButtonPress(event: Event) {
		this.select(this.buttons.children.indexOf(event.sender as TabBarButton))
	}
}

/**
 * @type TabBarBeforeSelectEvent
 * @since 0.5.0
 */
export type TabBarBeforeSelectEvent = {
	index: number | null
}

/**
 * @type TabBarSelectEvent
 * @since 0.4.0
 */
export type TabBarSelectEvent = {
	index: number
}

/**
 * @type TabBarDeselectEvent
 * @since 0.4.0
 */
export type TabBarDeselectEvent = {
	index: number
}