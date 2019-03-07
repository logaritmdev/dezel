import { DataSource } from '../data/DataSource'
import { ListOptimizer } from '../optimize/ListOptimizer'
import { Orientation } from '../optimize/ListOptimizer'
import { List } from './List'
import { ListDeselectEvent } from './List'
import { ListSelectEvent } from './List'
import { ListItem } from './ListItem'

/**
 * @interface ListManagerOptions
 * @since 0.2.0
 */
export interface ListManagerOptions<T> {
	orientation?: Orientation
	estimatedItemSize: number
	defineItem?: DefineItemCallback<T>
	onReuseItem?: OnReuseItemCallback<T>
	onCacheItem?: OnCacheItemCallback<T>
	onInsertItem?: OnInsertItemCallback<T>
	onRemoveItem?: OnRemoveItemCallback<T>
}

/**
 * @symbol SELECTED_INDEX
 * @since 0.2.0
 */
export const SELECTED_INDEX = Symbol('selectedIndex')

/**
 * Provides data and items to a list.
 * @class ListManager
 * @super ContentOptimizer
 * @since 0.1.0
 */
export class ListManager<T = any> extends ListOptimizer<T> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The managed list's selected index.
	 * @property selectedIndex
	 * @since 0.2.0
	 */
	public get selectedIndex(): number | undefined | null {
		return this[SELECTED_INDEX]
	}

	/**
	 * The managed list.
	 * @property list
	 * @since 0.2.0
	 */
	public get list(): List {
		return this.view as List
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.2.0
	 */
	constructor(data: Array<T> | DataSource<T>, options: ListManagerOptions<T>) {
		super(data, options)
		this.defineItemCallback = options.defineItem
		this.onReuseItemCallback = options.onReuseItem
		this.onCacheItemCallback = options.onCacheItem
		this.onInsertItemCallback = options.onInsertItem
		this.onRemoveItemCallback = options.onRemoveItem
	}

	/**
	 * Selects an item at a specified index.
	 * @method select
	 * @since 0.2.0
	 */
	public select(index: ListItem | number | undefined | null) {

		if (index instanceof ListItem) {
			index = this.getItemIndex(index)
		}

		if (index == this.selectedIndex) {
			return this
		}

		let selectedIndex = this.selectedIndex
		if (selectedIndex != null) {

			let selectedItem = this.getItem(selectedIndex)
			if (selectedItem &&
				selectedItem instanceof ListItem) {
				selectedItem.selected = false
			}

			if (this.view) {
				this.view.emit<ListDeselectEvent>('deselect', { data: { index: selectedIndex } })
			}
		}

		this[SELECTED_INDEX] = null

		if (index == null) {
			return this
		}

		let selectedItem = this.getItem(index) as ListItem
		if (selectedItem) {
			selectedItem.selected = true
		}

		this[SELECTED_INDEX] = index

		if (this.view) {
			this.view.emit<ListSelectEvent>('select', { data: { index } })
		}

		return this
	}

	/**
	 * @inherited
	 * @method defineItem
	 * @since 0.5.0
	 */
	public defineItem(index: number, data: T): any {
		return this.defineItemCallback && this.defineItemCallback(index, data) || ListItem
	}

	/**
	 * @inherited
	 * @method onCacheItem
	 * @since 0.5.0
	 */
	public onCacheItem(index: number, data: T, item: ListItem) {
		if (this.onCacheItemCallback) {
			this.onCacheItemCallback(index, data, item)
		}
	}

	/**
	 * @inherited
	 * @method onReuseItem
	 * @since 0.5.0
	 */
	public onReuseItem(index: number, data: T, item: ListItem) {

		item.pressed = false
		item.disabled = false
		item.selected = false

		if (this.list.selectable) {
			item.selected = this.selectedIndex == index
		}

		if (this.onReuseItemCallback) {
			this.onReuseItemCallback(index, data, item)
		}
	}

	/**
	 * @inherited
	 * @method onInsertItem
	 * @since 0.5.0
	 */
	public onInsertItem(index: number, data: T, item: ListItem) {
		if (this.onInsertItemCallback) {
			this.onInsertItemCallback(index, data, item)
		}
	}

	/**
	 * @inherited
	 * @method onRemoveItem
	 * @since 0.5.0
	 */
	public onRemoveItem(index: number, data: T, item: ListItem) {
		if (this.onRemoveItemCallback) {
			this.onRemoveItemCallback(index, data, item)
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property defineItemCallback
	 * @since 0.5.0
	 * @hidden
	 */
	private defineItemCallback?: DefineItemCallback<T>

	/**
	 * @property updateItemCallback
	 * @since 0.5.0
	 * @hidden
	 */
	private onCacheItemCallback?: OnCacheItemCallback<T>

	/**
	 * @property OnReuseItemCallback
	 * @since 0.5.0
	 * @hidden
	 */
	private onReuseItemCallback?: OnReuseItemCallback<T>

	/**
	 * @property updateItemCallback
	 * @since 0.5.0
	 * @hidden
	 */
	private onInsertItemCallback?: OnInsertItemCallback<T>

	/**
	 * @property updateItemCallback
	 * @since 0.5.0
	 * @hidden
	 */
	private onRemoveItemCallback?: OnRemoveItemCallback<T>

	/**
	 * @property [SELECTED_INDEX]
	 * @since 0.2.0
	 * @hidden
	 */
	private [SELECTED_INDEX]?: number | null
}

/**
 * The callback used to describe the class of an item.
 * @type DefineItemCallback
 * @since 0.5.0
 */
export type DefineItemCallback<T = any> = (index: number, data: T) => any

/**
 * The callback executed when an item is cached.
 * @type OnCacheItemCallback
 * @since 0.5.0
 */
export type OnCacheItemCallback<T = any> = (index: number, data: T, item: any) => void

/**
 * The callback executed when an item is reused.
 * @type OnReuseItemCallback
 * @since 0.2.0
 */
export type OnReuseItemCallback<T = any> = (index: number, data: T, item: any) => void

/**
 * The callback executed when an item is inserted.
 * @type OnInsertItemCallback
 * @since 0.5.0
 */
export type OnInsertItemCallback<T = any> = (index: number, data: T, item: any) => void

/**
 * The callback executed when an item is removed.
 * @type OnRemoveItemCallback
 * @since 0.5.0
 */
export type OnRemoveItemCallback<T = any> = (index: number, data: T, item: any) => void
