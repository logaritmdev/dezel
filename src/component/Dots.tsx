import { $selectedIndex } from './private/Dots'
import { $selectedValue } from './private/Dots'
import { watch } from '../decorator/watch'
import { View } from '../view/View'
import { Component } from './Component'
import { Root } from './Root'
import { Slot } from './Slot'
import './style/Dots.style'
import './style/Dots.style.android'
import './style/Dots.style.ios'

/**
 * @class Dots
 * @super Component
 * @since 0.5.0
 */
export class Dots extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property amount
	 * @since 0.5.0
	 */
	@watch public amount: number = 0

	/**
	 * @property selectedIndex
	 * @since 0.5.0
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
				<Slot main={true} />
			</Root>
		)
	}

	/**
	 * @method select
	 * @since 0.5.0
	 */
	public select(index: number | null) {

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
	private [$selectedValue]: View | null = null

	/**
	 * @method applySelection
	 * @since 0.4.0
	 * @hidden
	 */
	private applySelection(index: number) {

		let value = this.children[index]
		if (value == null) {
			return this
		}

		value.states.append('selected')

		this[$selectedIndex] = index
		this[$selectedValue] = value

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

		value.states.remove('selected')

		this[$selectedIndex] = null
		this[$selectedValue] = null

		return this
	}
}