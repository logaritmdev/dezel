import { bound } from '../decorator/bound'
import { Event } from '../event/Event'
import { View } from '../view/View'
import { Component } from './Component'
import { Host } from './Host'
import { SegmentedBarButton } from './SegmentedBarButton'
import { Slot } from './Slot'
import './SegmentedBar.ds'
import './SegmentedBar.ds.android'
import './SegmentedBar.ds.ios'

/**
 * The internal references.
 * @interface Refs
 * @since 0.7.0
 */
export interface Refs {

}

/**
 * The internal slots.
 * @interface Slots
 * @since 0.7.0
 */
export interface Slots {
	buttons: SegmentedBar.Buttons
}

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
	public get buttons(): SegmentedBar.Buttons {
		return this.slots.buttons
	}

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
		return (
			<Host>
				<SegmentedBar.Buttons main={true} />
			</Host>
		)
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
	 * Called before a segmented bar button is selected.
	 * @method onBeforeSelect
	 * @since 0.1.0
	 */
	protected onBeforeSelect(index: number) {

	}

	/**
	 * Called when a segmented bar button is selected.
	 * @method onSelect
	 * @since 0.1.0
	 */
	protected onSelect(index: number) {

	}

	/**
	 * Called when a segmented bar button is deselected.
	 * @method onDeselect
	 * @since 0.1.0
	 */
	protected onDeselect(index: number) {

	}

	/**
	 * @inherited
	 * @method onInsert
	 * @since 0.1.0
	 */
	protected onInsert(child: View, index: number) {

		super.onInsert(child, index)

		if (child instanceof SegmentedBarButton) {
			child.on('press', this.onSegmentedBarButtonPress)
		}
	}

	/**
	 * @inherited
	 * @method onRemove
	 * @since 0.1.0
	 */
	protected onRemove(child: View, index: number) {

		super.onRemove(child, index)

		if (child instanceof SegmentedBarButton) {
			child.off('press', this.onSegmentedBarButtonPress)
		}
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

		let button = this.buttons.children[index] as SegmentedBarButton
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

		if (this.selectedButton == null) {
			return this
		}

		this.emit<SegmentedBarSelectEvent>('deselect', { data: { index: this.selectedIndex! } })

		this.selectedButton.selected = false
		this.selectedButton = null

		return this
	}

	/**
	 * @method onSegmentedBarButtonPress
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onSegmentedBarButtonPress(event: Event) {
		this.select(this.buttons.children.indexOf(event.sender as SegmentedBarButton))
	}
}

/**
 * @module SegmentedBar
 * @since 0.7.0
 */
export module SegmentedBar {

	/**
	 * @class Buttons
	 * @super Slot
	 * @since 0.7.0
	 */
	export class Buttons extends Slot {

		/**
		 * @inherited
		 * @property name
		 * @since 0.7.0
		 */
		public get name(): string {
			return 'buttons'
		}
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