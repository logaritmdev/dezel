import { watch } from '../decorator/watch'
import { View } from '../view/View'
import { Component } from './Component'
import { Root } from './Root'
import './style/Dots.style'
import './style/Dots.style.android'
import './style/Dots.style.ios'
// TODO
// Selected index, selected value
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
	public get selectedIndex(): number | undefined {
		return this.getSelectedIndex()
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
			<Root />
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
	 * @property selectedDot
	 * @since 0.5.0
	 * @hidden
	 */
	private selectedDot: View | null = null

	/**
	 * @method getSelectedDotIndex
	 * @since 0.5.0
	 * @hidden
	 */
	private getSelectedIndex() {
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
		this.selectedDot.states.append('selected')

		return this
	}

	/**
	 * @method clearSelection
	 * @since 0.4.0
	 * @hidden
	 */
	private clearSelection() {

		if (this.selectedDot) {
			this.selectedDot.states.remove('selected')
			this.selectedDot = null
		}

		return this
	}
}