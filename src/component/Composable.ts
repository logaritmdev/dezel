import { View } from '../view/View'

/**
 * @interface Composable
 * @since 0.7.0
 */
export interface Composable {

	/**
	 * @method onCompose
	 * @since 0.7.0
	 */
	onCompose(view: View): void
}