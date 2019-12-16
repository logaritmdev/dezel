import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { View } from './View'

@bridge('dezel.view.Window')

/**
 * @class Window
 * @super View
 * @since 0.1.0
 */
export class Window extends View {

	/**
	 * Finds the deepest view at a specified location.
	 * @method findViewAt
	 * @since 0.7.0
	 */
	public findViewAt(x: number, y: number, options: FindOptions = {}): View {

		let opts = Object.assign(
			{},
			OPTIONS,
			options
		)

		return native(this).findViewAt(x, y, opts.visible, opts.touchable)
	}
}

/**
 * @const OPTIONS
 * @since 0.7.0
 * @hidden
 */
const OPTIONS: Required<FindOptions> = {
	visible: true,
	touchable: true
}

/**
 * @interface FindOptions
 * @since 0.7.0
 */
export interface FindOptions {
	visible?: boolean
	touchable?: boolean
}