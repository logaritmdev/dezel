import { $gesture } from './symbol/Tappable'
import { watch } from '../decorator/watch'
import { TapGestureDetector } from '../gesture/TapGestureDetector'
import { View } from '../view/View'
import { Composable } from './Composable'

/**
 * @class Tappable
 * @since 0.7.0
 */
export class Tappable implements Composable {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property enabled
	 * @since 0.7.0
	 */
	@watch public enabled: boolean = true

	/**
	 * @property capture
	 * @since 0.7.0
	 */
	@watch public capture: boolean = false

	/**
	 * @property $gesture
	 * @since 0.7.0
	 */
	public get gesture(): TapGestureDetector {
		return this[$gesture]
	}

	//--------------------------------------------------------------------------
	// Callbacks
	//--------------------------------------------------------------------------

	/**
	 * @property onTap
	 * @since 0.7.0
	 */
	public onTap?: OnTap

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method onCompose
	 * @since 0.7.0
	 */
	public onCompose(view: View) {
		this.gesture.capture = this.capture
		this.gesture.enabled = this.enabled
		view.gestures.append(this.gesture)
	}

	/**
	 * @method onPropertyChange
	 * @since 0.7.0
	 * @hidden
	 */
	protected onPropertyChange(property: string, newValue: any, oldValue: any) {

		switch (property) {

			case 'enabled':
				this.gesture.enabled = newValue
				break

			case 'capture':
				this.gesture.capture = newValue
				break
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $gesture
	 * @since 0.7.0
	 * @hidden
	 */
	private [$gesture]: TapGestureDetector = new TapGestureDetector(gesture => {
		if (this.onTap) {
			this.onTap(gesture as TapGestureDetector)
		}
	})
}

/**
 * @type OnTap
 * @since 0.7.0
 */
export type OnTap = (gesture: TapGestureDetector) => void