import { Screen } from '../Screen'
import { ScreenTransition } from './ScreenTransition'
import { ScreenTransitionRegistry } from './ScreenTransition'

/**
 * Performs an instantaneous transition.
 * @class ScreenNoneTransition
 * @super ScreenTransition
 * @since 0.4.0
 */
export class ScreenNoneTransition extends ScreenTransition {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onBeforePresent
	 * @since 0.4.0
	 */
	public onBeforePresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @inherited
	 * @method onPresent
	 * @since 0.4.0
	 */
	public onPresent(enter?: Screen, leave?: Screen) {
		return Promise.resolve()
	}

	/**
	 * @inherited
	 * @method onBeforeDismiss
	 * @since 0.4.0
	 */
	public onBeforeDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @inherited
	 * @method onDismiss
	 * @since 0.4.0
	 */
	public onDismiss(enter?: Screen, leave?: Screen) {
		return Promise.resolve()
	}

	/**
	 * @inherited
	 * @method onAfterPresent
	 * @since 0.4.0
	 */
	public onAfterPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @inherited
	 * @method onAfterDismiss
	 * @since 0.4.0
	 */
	public onAfterDismiss(enter?: Screen, leave?: Screen) {

	}
}

ScreenTransitionRegistry.set('none', ScreenNoneTransition)