import { View } from '../view/View'
import { ViewOptimizerTransition } from './ViewOptimizerTransition'
import { ViewOptimizerTransitionRegistry } from './ViewOptimizerTransition'

/**
 * The base class for content optimizer transitions.
 * @class ViewOptimizerFadeTransition
 * @super ViewOptimizerTransition
 * @since 0.7.0
 */
export class ViewOptimizerFadeTransition extends ViewOptimizerTransition {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onBeforeInsert
	 * @since 0.7.0
	 */
	protected onBeforeInsert(items: Array<View>) {
		items.forEach(item => item.opacity = 0)
	}

	/**
	 * @inherited
	 * @method onBeforeRemove
	 * @since 0.7.0
	 */
	protected onBeforeRemove(items: Array<View>) {
		items.forEach(item => item.opacity = 1)
	}

	/**
	 * @inherited
	 * @method onInsert
	 * @since 0.7.0
	 */
	protected onInsert(items: Array<View>) {
		items.forEach(item => item.opacity = 1)
	}

	/**
	 * @inherited
	 * @method onRemove
	 * @since 0.7.0
	 */
	protected onRemove(items: Array<View>) {
		items.forEach(item => item.opacity = 0)
	}

	/**
	 * @inherited
	 * @method onAfterInsert
	 * @since 0.7.0
	 */
	protected onAfterInsert(items: Array<View>) {
		items.forEach(item => item.opacity = 1)
	}

	/**
	 * @inherited
	 * @method onAfterRemove
	 * @since 0.7.0
	 */
	protected onAfterRemove(items: Array<View>) {
		items.forEach(item => item.opacity = 1)
	}
}

ViewOptimizerTransitionRegistry.set('fade', ViewOptimizerFadeTransition)