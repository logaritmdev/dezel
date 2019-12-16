import { $selectedIndex } from './private/TabBar'
import { $selectedValue } from './private/TabBar'
import { bound } from '../decorator/bound'
import { ref } from '../decorator/ref'
import { Event } from '../event/Event'
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
	 * The tab bar's buttons.
	 * @property buttons
	 * @since 0.1.0
	 */
	@ref public buttons: Slot

	/**
	 * The tab bar's selected index.
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
	 * @inherited
	 * @method render
	 * @since 0.7.0
	 */
	public render() {
		return (
			<Root>
				<Slot ref={this.buttons} main={true}></Slot>
			</Root>
		)
	}

	/**
	 * Selects a button at a specified index.
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
	 * @inherited
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
	 * Called before a button is selected.
	 * @method onBeforeSelect
	 * @since 0.1.0
	 */
	public onBeforeSelect(index: number) {

	}

	/**
	 * Called after a button is selected.
	 * @method onSelect
	 * @since 0.1.0
	 */
	public onSelect(index: number) {

	}

	/**
	 * Called after a button is deselected.
	 * @method onDeselect
	 * @since 0.1.0
	 */
	public onDeselect(index: number) {

	}

	/**
	 * @inherited
	 * @method onInsert
	 * @since 0.1.0
	 */
	public onInsert(child: View, index: number) {
		if (child instanceof TabBarButton) this.onInsertButton(child, index)
	}

	/**
	 * @inherited
	 * @method onRemove
	 * @since 0.1.0
	 */
	public onRemove(child: View, index: number) {
		if (child instanceof TabBarButton) this.onRemoveButton(child, index)
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method onInsertItem
	 * @since 0.7.0
	 * @hidden
	 */
	public onInsertButton(button: TabBarButton, index: number) {

		if (this[$selectedIndex] &&
			this[$selectedIndex]! >= index) {
			this[$selectedIndex]!++
		}

		button.on('press', this.onTabBarButtonPress)
	}

	/**
	 * @method onRemoveButton
	 * @since 0.7.0
	 * @hidden
	 */
	public onRemoveButton(button: TabBarButton, index: number) {

		button.pressed = false

		if (this[$selectedIndex] &&
			this[$selectedIndex]! > index) {
			this[$selectedIndex]!--
		} else if (this[$selectedIndex] == index) {
			this[$selectedIndex] = null
			this[$selectedValue] = null
			button.selected = false
		}

		button.off('press', this.onTabBarButtonPress)
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
	 * @method applySelection
	 * @since 0.4.0
	 * @hidden
	 */
	private applySelection(index: number) {

		let value = this.buttons.get(index)
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

	/**
	 * @method onTabBarButtonTap
	 * @since 0.1.0
	 */
	@bound private onTabBarButtonPress(event: Event) {
		this.select(this.buttons.index(event.sender as TabBarButton))
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