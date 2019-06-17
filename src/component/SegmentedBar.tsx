import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { View } from '../view/View'
import { ViewInsertEvent } from '../view/View'
import { Component } from './Component'
import { SegmentedBarButton } from './SegmentedBarButton'
import './SegmentedBar.ds'
import './SegmentedBar.ds.android'
import './SegmentedBar.ds.ios'

/**
 * Displays an horizontal element made of multiple segmented bar button.
 * @class SegmentedBar
 * @super Component
 * @since 0.1.0
 */
export class SegmentedBar extends Component<Component> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The select bar buttons.
	 * @property buttons
	 * @since 0.1.0
	 */
	@watch public buttons: Array<SegmentedBarButton> = []

	/**
	 * The select bar selected button index.
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
	 * @inherited
	 * @method render
	 * @since 0.7.0
	 */
	public render() {
		return null
	}

	/**
	 * Selects a button button using the specified index.
	 * @method select
	 * @since 0.1.0
	 */
	public select(index: number | undefined | null) {

		if (index == this.selectedIndex) {
			return this
		}

		let event = new Event<SegmentedBarBeforeSelectEvent>('beforeselect', {
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
				this.onBeforeSelect(event.data.index)
				break

			case 'select':
				this.onSelect(event.data.index)
				break

			case 'deselect':
				this.onDeselect(event.data.index)
				break
		}

		super.onEmit(event)
	}

	/**
	 * Called before a segmented bar button is selected.
	 * @method onBeforeSelect
	 * @since 0.1.0
	 */
	public onBeforeSelect(index: number) {

	}

	/**
	 * Called when a segmented bar button is selected.
	 * @method onSelect
	 * @since 0.1.0
	 */
	public onSelect(index: number) {

	}

	/**
	 * Called when a segmented bar button is deselected.
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

		super.onInsert(child, index)

		if (child instanceof SegmentedBarButton) {
			child.on('press', this.onSegmentedBarButtonPress)
			this.insertSegmentedBarButton(child, index)
		}
	}

	/**
	 * @inherited
	 * @method onRemove
	 * @since 0.1.0
	 */
	public onRemove(child: View, index: number) {

		super.onRemove(child, index)

		if (child instanceof SegmentedBarButton) {
			child.off('press', this.onSegmentedBarButtonPress)
			this.removeSegmentedBarButton(child, index)
		}
	}

	/**
	 * @inherited
	 * @method onPropertyChange
	 * @since 0.4.0
	 */
	public onPropertyChange(property: string, newValue: any, oldValue: any) {

		if (property == 'buttons') {

			this.select(null)

			let newButtons = newValue as Array<SegmentedBarButton>
			let oldButtons = oldValue as Array<SegmentedBarButton>
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
	private selectedButton?: SegmentedBarButton | null

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

		this.emit<SegmentedBarSelectEvent>('select', { data: { index } })

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
			this.emit<SegmentedBarSelectEvent>('deselect', { data: { index: this.selectedIndex! } })
		}

		this.selectedButton = null

		return this
	}

	/**
	 * @method insertSegmentedBarButton
	 * @since 0.4.0
	 * @hidden
	 */
	private insertSegmentedBarButton(item: SegmentedBarButton, index: number) {

		if (this.buttons[index] != item) {
			this.buttons.splice(index, 0, item)
		}

		return this
	}

	/**
	 * @method removeSegmentedBarButton
	 * @since 0.4.0
	 * @hidden
	 */
	private removeSegmentedBarButton(item: SegmentedBarButton, index: number) {

		if (this.buttons[index] == item) {
			this.buttons.splice(index, 1)
		}

		return this
	}

	/**
	 * @method onSegmentedBarButtonPress
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onSegmentedBarButtonPress(event: Event) {
		this.select(this.buttons.indexOf(event.sender as SegmentedBarButton))
	}
}

/**
 * @type SegmentedBarBeforeSelectEvent
 * @since 0.4.0
 */
export type SegmentedBarBeforeSelectEvent = {
	index?: number | null
}

/**
 * @type SegmentedBarSelectEvent
 * @since 0.4.0
 */
export type SegmentedBarSelectEvent = {
	index: number
}

/**
 * @type SegmentedBarDeselectEvent
 * @since 0.4.0
 */
export type SegmentedBarDeselectEvent = {
	index: number
}