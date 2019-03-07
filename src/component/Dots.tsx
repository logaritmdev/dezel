import { watch } from '../decorator/watch'
import { View } from '../view/View'
import { Component } from './Component'

import './Dots.ds'
import './Dots.ds.ios'
import './Dots.ds.android'

/**
 * Displays dots indicator.
 * @class Dots
 * @super Component
 * @since 0.5.0
 */
export class Dots extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The amount of dots.
	 * @property amount
	 * @since 0.5.0
	 */
	@watch public amount: number = 0

	/**
	 * The selected dot index.
	 * @property selectedIndex
	 * @since 0.5.0
	 */
	public get selectedIndex(): number | undefined {
		return this.getSelectedDotIndex()
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Selects a dot using the specified index.
	 * @method select
	 * @since 0.5.0
	 */
	public select(index: number | undefined | null) {

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

	/**
	 * @inherited
	 * @method onPropertyChange
	 * @since 0.4.0
	 */
	public onPropertyChange(property: string, newValue: any, oldValue: any) {

		if (property == 'amount') {

			this.removeAll()

			let amount = newValue as number
			if (amount) {
				for (let i = 0; i < amount; i++) {
					this.append(<View style="dot" />)
				}
			}

			return
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property selectedDot
	 * @since 0.5.0
	 * @hidden
	 */
	private selectedDot?: View | null

	/**
	 * @method getSelectedDotIndex
	 * @since 0.5.0
	 * @hidden
	 */
	private getSelectedDotIndex() {
		return this.selectedDot ? this.children.indexOf(this.selectedDot) : undefined
	}

	/**
	 * @method applySelection
	 * @since 0.4.0
	 * @hidden
	 */
	private applySelection(index: number) {

		let dot = this.children[index]
		if (dot == null) {
			return this
		}

		this.selectedDot = dot
		this.selectedDot.setState('selected')

		return this
	}

	/**
	 * @method clearSelection
	 * @since 0.4.0
	 * @hidden
	 */
	private clearSelection() {

		if (this.selectedDot) {
			this.selectedDot.setState('selected', false)
			this.selectedDot = null
		}

		return this
	}
}
