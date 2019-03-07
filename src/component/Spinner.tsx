import { ref } from '../decorator/ref'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { Fragment } from '../view/Fragment'
import { SpinnerView } from '../view/SpinnerView'
import { Component } from './Component'

import './Spinner.ds'
import './Spinner.ds.ios'
import './Spinner.ds.android'

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
				<SpinnerView id="spinner" />
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
			this.spinner.active = newValue
			return
		}

		if (property == 'color') {
			this.spinner.color = newValue
			return
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property spinner
	 * @since 0.4.0
	 * @hidden
	 */
	@ref private spinner!: SpinnerView
}