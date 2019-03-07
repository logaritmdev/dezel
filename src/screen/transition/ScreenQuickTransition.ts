import { Screen } from '../Screen'
import { ScreenTransition } from './ScreenTransition'
import { ScreenTransitionRegistry } from './ScreenTransition'

/**
 * Performs a transition that does not animate.
 * @class ScreenQuickTransition
 * @super Transition
 * @since 0.3.0
 */
export class ScreenQuickTransition extends ScreenTransition {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.3.0
	 */
	constructor() {
		super()
		this.duration = 0
	}
}

ScreenTransitionRegistry.set('quick', ScreenQuickTransition)