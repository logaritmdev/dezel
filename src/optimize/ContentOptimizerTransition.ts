import { Event } from '../event/Event'
import { Emitter } from '../event/Emitter'
import { View } from '../view/View'
import { ContentOptimizer, Orientation } from './ContentOptimizer'

/**
 * The base class for content optimizer transitions.
 * @class ContentOptimizerTransition
 * @super Emitter
 * @since 0.2.0
 */
export class ContentOptimizerTransition extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The transition's animation duration.
	 * @property duration
	 * @since 0.2.0
	 */
	public duration: number = 350

	/**
	 * The transition's animation equation.
	 * @property equation
	 * @since 0.2.0
	 */
	public equation: string = 'default'

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Prepares the insertion animation.
	 * @method onBeforeInsert
	 * @since 0.2.0
	 */
	public onBeforeInsert(items: Array<View>) {

	}

	/**
	 * Prepares the removal animation.
	 * @method onBeforeRemove
	 * @since 0.2.0
	 */
	public onBeforeRemove(items: Array<View>) {

	}

	/**
	 * Executes the insertion animation.
	 * @method onInsert
	 * @since 0.2.0
	 */
	public onInsert(items: Array<View>) {

	}

	/**
	 * Executes the removal animation.
	 * @method onRemove
	 * @since 0.2.0
	 */
	public onRemove(items: Array<View>) {

	}

	/**
	 * Finishes the insertion animation.
	 * @method onAfterInsert
	 * @since 0.2.0
	 */
	public onAfterInsert(items: Array<View>) {

	}

	/**
	 * Finishes the removal animation.
	 * @method onAfterRemove
	 * @since 0.2.0
	 */
	public onAfterRemove(items: Array<View>) {

	}

	/**
	 * Executes the update transition.
	 * @method run
	 * @since 0.2.0
	 */
	public run(animator: () => void) {
		return this.transition(animator)
	}

	/**
	 * Executes the transition with the current values.
	 * @method transition
	 * @since 0.2.0
	 */
	public transition(animator: any): Promise<void> {
		return View.transition({
			duration: this.duration,
			equation: this.equation
		}, () => {
			animator()
		})
	}
}

/**
 * @const TransitionRegistry
 * @since 0.2.0
 * @hidden
 */
export const ContentOptimizerTransitionRegistry: Map<string, typeof ContentOptimizerTransition> = new Map()