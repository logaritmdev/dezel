import { watch } from '../decorator/watch'
import { Reference } from '../util/Reference'
import { Fragment } from '../view/Fragment'
import { SpinnerView } from '../view/SpinnerView'
import { Component } from './Component'
import './Spinner.ds'
import './Spinner.ds.android'
import './Spinner.ds.ios'

/**
 * Displays a spinner.
 * @class Spinner
 * @super Component
 * @since 0.4.0
 */
export class Spinner extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The spinner's active status.
	 * @property active
	 * @since 0.4.0
	 */
	@watch public active: boolean = false

	/**
	 * The spinner's color.
	 * @property color
	 * @since 0.4.0
	 */
	@watch public color: string = 'black'

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method render
	 * @since 0.3.0
	 */
	public render() {
		return (
			<Fragment>
				<SpinnerView ref={this.spinnerRef} />
			</Fragment>
		)
	}

	/**
	 * @inherited
	 * @method onPropertyChange
	 * @since 0.3.0
	 */
	public onPropertyChange(property: string, newValue: any, oldValue: any) {

		if (property == 'active') {

			if (this.spinnerRef.value) {
				this.spinnerRef.value.active = newValue
			}

			return
		}

		if (property == 'color') {

			if (this.spinnerRef.value) {
				this.spinnerRef.value.color = newValue
			}

			return
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property spinnerRef
	 * @since 0.7.0
	 * @hidden
	 */
	private spinnerRef = new Reference<SpinnerView>(this)
}