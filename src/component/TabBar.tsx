
import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'
import { Component } from './Component'
import { TabBarButton } from './TabBarButton'

import './TabBar.ds'
import './TabBar.ds.ios'
import './TabBar.ds.android'

/**
 * Displays an horizontal element made of multiple tab bar button.
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
	@watch public buttons: Array<TabBarButton> = []

	/**
	 * The tab bar's selected button index.
	 * @property selectedIndex
	 * @since 0.1.0
	 */
	public get selectedIndex(): number | undefined {
		return this.getSelectedButtonIndex()
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Selects the tab bar button at the specified index.
	 * @method select
	 * @since 0.1.0
	 */
	public select(index: number | undefined | null) {

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
	 * @method onEmit
	 * @since 0.1.0
	 */
	public onEmit(event: Event) {

		switch (event.type) {

			case 'beforeselect':
				this.onBeforeSelect(event)
				break

			case 'select':
				this.onSelect(event)
				break

			case 'deselect':
				this.onDeselect(event)
				break
		}

		super.onEmit(event)
	}

	/**
	 * Called before a tab bar button is selected.
	 * @method onBeforeSelect
	 * @since 0.1.0
	 */
	public onBeforeSelect(event: Event<TabBarSelectEvent>) {

	}

	/**
	 * Called when a tab bar button is selected.
	 * @method onSelect
	 * @since 0.1.0
	 */
	public onSelect(event: Event<TabBarSelectEvent>) {

	}

	/**
	 * Called when a tab bar button is deselected.
	 * @method onDeselect
	 * @since 0.1.0
	 */
	public onDeselect(event: Event<TabBarDeselectEvent>) {

	}

	/**
	 * @inherited
	 * @method onInsert
	 * @since 0.1.0
	 */
	public onInsert(event: Event<ViewInsertEvent>) {

		super.onInsert(event)

		if (event.data.view instanceof TabBarButton) {

			event.data.view.on('tap', this.onTabBarButtonTap)

			this.insertTabBarButton(
				event.data.view,
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

		if (event.data.view instanceof TabBarButton) {

			event.data.view.off('tap', this.onTabBarButtonTap)

			this.removeTabBarButton(
				event.data.view,
				event.data.index
			)
		}
	}

	/**
	 * Called when a property receives a new value.
	 * @method onPropertyChange
	 * @since 0.4.0
	 */
	public onPropertyChange(property: string, newValue: any, oldValue: any) {

		if (property == 'buttons') {

			this.select(null)

			let newButtons = newValue as Array<TabBarButton>
			let oldButtons = oldValue as Array<TabBarButton>
			if (oldButtons) for (let button of oldButtons) this.remove(button)
			if (newButtons) for (let button of newButtons) this.append(button)

			return
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property selectedButton
	 * @since 0.1.0
	 * @hidden
	 */
	private selectedButton?: TabBarButton | null

	/**
	 * @method getSelectedButtonIndex
	 * @since 0.1.0
	 * @hidden
	 */
	private getSelectedButtonIndex() {
		return this.selectedButton ? this.children.indexOf(this.selectedButton) : undefined
	}

	/**
	 * @method applySelection
	 * @since 0.4.0
	 * @hidden
	 */
	private applySelection(index: number) {

		let button = this.buttons[index]
		if (button == null) {
			return this
		}

		this.selectedButton = button
		this.selectedButton.selected = true

		this.emit<TabBarSelectEvent>('select', { data: { index } })

		return this
	}

	/**
	 * @method clearSelection
	 * @since 0.4.0
	 * @hidden
	 */
	private clearSelection() {

		if (this.selectedButton) {
			this.selectedButton.selected = false
			this.emit<TabBarSelectEvent>('deselect', { data: { index: this.selectedIndex! } })
		}

		this.selectedButton = null

		return this
	}

	/**
	 * @method insertTabBarButton
	 * @since 0.4.0
	 * @hidden
	 */
	private insertTabBarButton(item: TabBarButton, index: number) {

		if (this.buttons[index] != item) {
			this.buttons.splice(index, 0, item)
		}

		return this
	}

	/**
	 * @method removeTabBarButton
	 * @since 0.4.0
	 * @hidden
	 */
	private removeTabBarButton(item: TabBarButton, index: number) {

		if (this.buttons[index] == item) {
			this.buttons.splice(index, 1)
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Private API - Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onTabBarButtonTap
	 * @since 0.1.0
	 */
	@bound private onTabBarButtonTap(event: Event) {
		this.select(this.buttons.indexOf(event.sender as TabBarButton))
	}
}

/**
 * @type TabBarBeforeSelectEvent
 * @since 0.5.0
 */
export type TabBarBeforeSelectEvent = {
	index?: number | null
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