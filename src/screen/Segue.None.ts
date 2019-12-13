import { Screen } from './Screen'
import { Segue } from './Segue'
import { SegueRegistry } from './SegueRegistry'

/**
 * @class NoneSegue
 * @super Segue
 * @since 0.7.0
 */
export class NoneSegue extends Segue {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method onBeforePresent
	 * @since 0.7.0
	 */
	public onBeforePresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onPresent
	 * @since 0.7.0
	 */
	public onPresent(enter?: Screen, leave?: Screen) {
		return Promise.resolve()
	}

	/**
	 * @method onBeforeDismiss
	 * @since 0.7.0
	 */
	public onBeforeDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismiss
	 * @since 0.7.0
	 */
	public onDismiss(enter?: Screen, leave?: Screen) {
		return Promise.resolve()
	}

	/**
	 * @method onAfterPresent
	 * @since 0.7.0
	 */
	public onAfterPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onAfterDismiss
	 * @since 0.7.0
	 */
	public onAfterDismiss(enter?: Screen, leave?: Screen) {

	}
}

SegueRegistry.set('none', NoneSegue)