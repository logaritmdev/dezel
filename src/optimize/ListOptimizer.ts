import { DataSource } from '../data/DataSource'
import { DataSourceChangeEvent } from '../data/DataSource'
import { DataSourceInsertEvent } from '../data/DataSource'
import { DataSourceReloadEvent } from '../data/DataSource'
import { DataSourceRemoveEvent } from '../data/DataSource'
import { bridge } from '../decorator/bridge'
import { Event } from '../event/Event'
import { View } from '../view/View'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'
import { ContentOptimizer } from './ContentOptimizer'
import { ContentOptimizerTransition } from './ContentOptimizerTransition'
import { ContentOptimizerTransitionRegistry } from './ContentOptimizerTransition'

/**
 * @interface ListManagerOptions
 * @since 0.2.0
 */
export interface ListOptimizerOption {
	orientation?: Orientation
	estimatedItemSize?: number
}

@bridge('dezel.view.ListOptimizer')

/**
 * Optimize item content displayed as a list.
 * @class ListOptimizer
 * @super ContentOptimizer
 * @since 0.4.0
 */
export class ListOptimizer<T = any> extends ContentOptimizer<T> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether a transition will be used to insert and remove items.
	 * @property animated
	 * @since 0.5.0
	 */
	public animated: boolean = true

	/**
	 * The item insertion and removal transition animation.
	 * @property transition
	 * @since 0.4.0
	 */
	public transition?: ContentOptimizerTransition | string = 'fade'

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 */
	constructor(data: Array<T> | DataSource<T>, options: ListOptimizerOption) {

		super(data)

		this.native.length = this.data.size

		if (options.orientation == null) {
			options.orientation = Orientation.VERTICAL
		}

		this.native.orientation = options.orientation
		this.native.estimatedItemSize = options.estimatedItemSize
	}

	/**
	 * Returns the item type for the specified index.
	 * @method defineItem
	 * @since 0.5.0
	 */
	public defineItem(index: number, data: T): any {
		return undefined
	}

	/**
	 * Called when an item is cached.
	 * @method onCacheItem
	 * @since 0.5.0
	 */
	public onCacheItem(index: number, data: T, item: View) {

	}

	/**
	 * Called when an item is reused.
	 * @method onReuseItem
	 * @since 0.5.0
	 */
	public onReuseItem(index: number, data: T, item: View) {

	}

	/**
	 * Called when an item is inserted.
	 * @method onInsertItem
	 * @since 0.5.0
	 */
	public onInsertItem(index: number, data: T, item: View) {

	}

	/**
	 * Called when an item is removed.
	 * @method onRemoveItem
	 * @since 0.5.0
	 */
	public onRemoveItem(index: number, data: T, item: View) {

	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onReloadData
	 * @since 0.4.0
	 */
	public onReloadData(event: Event<DataSourceReloadEvent<T>>) {
		this.native.length = this.data.size
		this.native.reloadData()
	}

	/**
	 * @inherited
	 * @method onInsertData
	 * @since 0.4.0
	 */
	public onInsertData(event: Event<DataSourceInsertEvent<T>>) {

		this.native.length = this.data.size
		this.native.insertData(event.data.index, event.data.rows.length, this.animate)

		if (this.animate) {
			this.performTransition()
		}
	}

	/**
	 * @inherited
	 * @method onRemoveData
	 * @since 0.4.0
	 */
	public onRemoveData(event: Event<DataSourceRemoveEvent<T>>) {

		this.native.length = this.data.size
		this.native.removeData(event.data.index, event.data.rows.length, this.animate)

		if (this.animate) {
			this.performTransition()
		}
	}

	/**
	 * @inherited
	 * @method onChangeData
	 * @since 0.5.0
	 */
	public onChangeData(event: Event<DataSourceChangeEvent<T>>) {

		let index = event.data.index
		let value = event.data.value

		let item = this.getItem(index)
		if (item) {
			this.onReuseItem(index, value, item)
		}
	}

	/**
	 * @inherited
	 * @method onCommitData
	 * @since 0.5.0
	 */
	public onCommitData(event: Event) {
		this.batching = true
	}

	/**
	 * @inherited
	 * @method onUpdateData
	 * @since 0.5.0
	 */
	public onUpdateData(event: Event) {

		this.batching = false

		if (this.animate) {
			this.performTransition()
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property batching
	 * @since 0.5.0
	 * @hidden
	 */
	private batching: boolean = false

	/**
	 * @property animate
	 * @since 0.5.0
	 * @hidden
	 */
	private get animate(): boolean {
		return this.animated && this.batching == false
	}

	/**
	 * @method getTransition
	 * @since 0.4.0
	 * @hidden
	 */
	private getTransition() {

		let transition = this.transition

		if (typeof transition == 'string') {

			let Constructor = ContentOptimizerTransitionRegistry.get(transition)
			if (Constructor == null) {
				throw new Error(`
					Content Optimizer error:
					The transition ${transition} does not exists. Has it been registered ?
				`)
			}

			return new Constructor()
		}

		return transition
	}

	/**
	 * @method performTransition
	 * @since 0.5.0
	 * @hidden
	 */
	private performTransition() {

		let transition = this.getTransition()

		let callback = (inserts: Array<View>, removes: Array<View>, complete: any) => {

			if (transition == null) {
				complete()
				return
			}

			for (let item of inserts) {
				item.top = item.measuredTop
				item.left = item.measuredLeft
			}

			transition.onBeforeInsert(inserts)
			transition.onBeforeRemove(removes)

			transition.run(() => {

				if (transition) {
					transition.onInsert(inserts)
					transition.onRemove(removes)
				}

				for (let item of inserts) {
					item.top = 'auto'
					item.left = 'auto'
				}

				for (let item of removes) {
					item.top = item.measuredTop
					item.left = item.measuredLeft
				}

			}).then(() => {

				for (let item of removes) {
					item.top = 'auto'
					item.left = 'auto'
				}

				if (transition) {
					transition.onAfterInsert(inserts)
					transition.onAfterRemove(removes)
				}

				complete()
			})
		}

		this.native.performTransition(callback)
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @method nativeDefineItem
	 * @since 0.5.0
	 * @hidden
	 */
	private nativeDefineItem(index: number) {

		let data = this.data.get(index)
		if (data == null) {
			return null
		}

		return this.defineItem(index, data)
	}

	/**
	 * @method nativeOnCacheItem
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnCacheItem(index: number, item: View) {

		let data = this.data.get(index)
		if (data == null) {
			return
		}

		this.onCacheItem(index, data, item)
	}

	/**
	 * @method nativeOnReuseItem
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnReuseItem(index: number, item: View) {

		let data = this.data.get(index)
		if (data == null) {
			return null
		}

		this.onReuseItem(index, data, item)
	}

	/**
	 * @method nativeOnRemoveItem
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnInsertItem(index: number, child: View) {

		let view = this.view
		if (view == null) {
			return
		}

		child.setResponder(view)

		view.emit<ViewInsertEvent>('insert', { data: { child, index } })

		let data = this.data.get(index)
		if (data == null) {
			return
		}

		this.onInsertItem(index, data, child)
	}

	/**
	 * @method nativeOnRemoveItem
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnRemoveItem(index: number, child: View) {

		let view = this.view
		if (view == null) {
			return
		}

		child.setResponder(null)

		view.emit<ViewRemoveEvent>('remove', { data: { child, index } })

		let data = this.data.get(index)
		if (data == null) {
			return
		}

		this.onRemoveItem(index, data, child)
	}
}

/**
 * The content orientation.
 * @enum Orientation
 * @since 0.4.0
 */
export enum Orientation {
	VERTICAL = 1,
	HORIZONTAL = 2
}