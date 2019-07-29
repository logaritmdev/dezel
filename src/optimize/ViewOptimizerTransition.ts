import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { View } from '../view/View'
import { Orientation } from './ViewOptimizer'
import { ViewOptimizer } from './ViewOptimizer'

/**
 * The base class for content optimizer transitions.
 * @class ViewOptimizerTransition
 * @super Emitter
 * @since 0.7.0
 */
export class ViewOptimizerTransition extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The transition's animation duration.
	 * @property duration
	 * @since 0.7.0
	 */
	public duration: number = 350

	/**
	 * The transition's animation equation.
	 * @property equation
	 * @since 0.7.0
	 */
	public equation: string = 'default'

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Prepares the insertion animation.
	 * @method onBeforeInsert
	 * @since 0.7.0
	 */
	protected onBeforeInsert(items: Array<View>) {

	}

	/**
	 * Prepares the removal animation.
	 * @method onBeforeRemove
	 * @since 0.7.0
	 */
	protected onBeforeRemove(items: Array<View>) {

	}

	/**
	 * Executes the insertion animation.
	 * @method onInsert
	 * @since 0.7.0
	 */
	protected onInsert(items: Array<View>) {

	}

	/**
	 * Executes the removal animation.
	 * @method onRemove
	 * @since 0.7.0
	 */
	protected onRemove(items: Array<View>) {

	}

	/**
	 * Finishes the insertion animation.
	 * @method onAfterInsert
	 * @since 0.7.0
	 */
	protected onAfterInsert(items: Array<View>) {

	}

	/**
	 * Finishes the removal animation.
	 * @method onAfterRemove
	 * @since 0.7.0
	 */
	protected onAfterRemove(items: Array<View>) {

	}

	/**
	 * Executes the update transition.
	 * @method run
	 * @since 0.7.0
	 */
	public run(animator: () => void) {
		return this.transition(animator)
	}

	/**
	 * Executes the transition with the current values.
	 * @method transition
	 * @since 0.7.0
	 */
	public transition(animator: any): Promise<void> {
		return View.transition({
			duration: this.duration,
			equation: this.equation
		}, () => {
			animator()
		})
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method emitBeforeInsert
	 * @since 0.7.0
	 * @hidden
	 */
	public emitBeforeInsert(items: Array<View>) {
		this.onBeforeInsert(items)
	}

	/**
	 * @method emitBeforeRemove
	 * @since 0.7.0
	 * @hidden
	 */
	public emitBeforeRemove(items: Array<View>) {
		this.onBeforeRemove(items)
	}

	/**
	 * @method emitInsert
	 * @since 0.7.0
	 * @hidden
	 */
	public emitInsert(items: Array<View>) {
		this.onInsert(items)
	}

	/**
	 * @method emitRemove
	 * @since 0.7.0
	 * @hidden
	 */
	public emitRemove(items: Array<View>) {
		this.onRemove(items)
	}

	/**
	 * @method emitAfterInsert
	 * @since 0.7.0
	 * @hidden
	 */
	public emitAfterInsert(items: Array<View>) {
		this.onAfterInsert(items)
	}

	/**
	 * @method emitAfterRemove
	 * @since 0.7.0
	 * @hidden
	 */
	public emitAfterRemove(items: Array<View>) {
		this.onAfterRemove(items)
	}
}

/**
 * @const TransitionRegistry
 * @since 0.7.0
 * @hidden
 */
export const ViewOptimizerTransitionRegistry: Map<string, typeof ViewOptimizerTransition> = new Map()