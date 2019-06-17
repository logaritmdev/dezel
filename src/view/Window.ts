import { bridge } from '../decorator/bridge'
import { View } from './View'

@bridge('dezel.view.Window')

/**
 * Displays the top most view at the root of the hierarchy.
 * @class Window
 * @super View
 * @since 0.1.0
 */
export class Window extends View {

	/**
	 * Initializes the window.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor() {
		super()
		this.id = 'window'
	}

	/**
	 * Finds a view from this window's hierarchy at the specified point.
	 * @method viewFromPoint
	 * @since 0.2.0
	 */
	public viewFromPoint(x: number, y: number, visible: boolean = true, touchable: boolean = true): View | null | undefined {
		return this.native.viewFromPoint(x, y, visible, touchable)
	}
}