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
	 * @method findViewAt
	 * @since 0.7.0
	 */
	public findViewAt(x: number, y: number, visible: boolean = true, touchable: boolean = true): View | null {
		return native(this).findViewAt(x, y, visible, touchable)
	}
}