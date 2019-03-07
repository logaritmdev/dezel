import { View } from '../view/View'
import { ContentOptimizerTransition } from './ContentOptimizerTransition'
import { ContentOptimizerTransitionRegistry } from './ContentOptimizerTransition'

/**
 * The base class for content optimizer transitions.
 * @class ContentOptimizerFadeTransition
 * @super Emitter
 * @since 0.2.0
 */
export class ContentOptimizerFadeTransition extends ContentOptimizerTransition {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onBeforeInsert
	 * @since 0.2.0
	 */
	public onBeforeInsert(items: Array<View>) {
		items.forEach(item => item.opacity = 0)
	}

	/**
	 * @inherited
	 * @method onBeforeRemove
	 * @since 0.2.0
	 */
	public onBeforeRemove(items: Array<View>) {
		items.forEach(item => item.opacity = 1)
	}

	/**
	 * @inherited
	 * @method onInsert
	 * @since 0.2.0
	 */
	public onInsert(items: Array<View>) {
		items.forEach(item => item.opacity = 1)
	}

	/**
	 * @inherited
	 * @method onRemove
	 * @since 0.2.0
	 */
	public onRemove(items: Array<View>) {
		items.forEach(item => item.opacity = 0)
	}

	/**
	 * @inherited
	 * @method onAfterInsert
	 * @since 0.2.0
	 */
	public onAfterInsert(items: Array<View>) {
		items.forEach(item => item.opacity = 1)
	}

	/**
	 * @inherited
	 * @method onAfterRemove
	 * @since 0.2.0
	 */
	public onAfterRemove(items: Array<View>) {
		items.forEach(item => item.opacity = 1)
	}
}

ContentOptimizerTransitionRegistry.set('fade', ContentOptimizerFadeTransition)