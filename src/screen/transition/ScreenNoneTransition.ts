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
	protected onBeforePresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @inherited
	 * @method onPresent
	 * @since 0.4.0
	 */
	protected onPresent(enter?: Screen, leave?: Screen) {
		return Promise.resolve()
	}

	/**
	 * @inherited
	 * @method onBeforeDismiss
	 * @since 0.4.0
	 */
	protected onBeforeDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @inherited
	 * @method onDismiss
	 * @since 0.4.0
	 */
	protected onDismiss(enter?: Screen, leave?: Screen) {
		return Promise.resolve()
	}

	/**
	 * @inherited
	 * @method onAfterPresent
	 * @since 0.4.0
	 */
	protected onAfterPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @inherited
	 * @method onAfterDismiss
	 * @since 0.4.0
	 */
	protected onAfterDismiss(enter?: Screen, leave?: Screen) {

	}
}

ScreenTransitionRegistry.set('none', ScreenNoneTransition)