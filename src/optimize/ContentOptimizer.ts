import { DataSource } from '../data/DataSource'
import { DataSourceChangeEvent } from '../data/DataSource'
import { DataSourceInsertEvent } from '../data/DataSource'
import { DataSourceReloadEvent } from '../data/DataSource'
import { DataSourceRemoveEvent } from '../data/DataSource'
import { bound } from '../decorator/bound'
import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { watch } from '../decorator/watch'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { View } from '../view/View'

/**
 * @symbol VIEW
 * @since 0.5.0
 */
export const VIEW = Symbol('view')

/**
 * The content orientation.
 * @enum Orientation
 * @since 0.2.0
 */
export enum Orientation {
	VERTICAL = 1,
	HORIZONTAL = 2
}

@bridge('dezel.item.ContentOptimizer')

/**
 * Optimize the content of a view to display only the least required amount.
 * @class ContentOptimizer
 * @super Emitter
 * @since 0.2.0
 */
export class ContentOptimizer<T> extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The view whose content is managed.
	 * @property view
	 * @since 0.2.0
	 */
	public get view(): View | null {
		return this[VIEW]
	}

	/**
	 * The managed data.
	 * @property data
	 * @since 0.2.0
	 */
	public readonly data: DataSource<T>

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.2.0
	 */
	constructor(data?: Array<T> | DataSource<T>) {

		super()

		if (data == null) {
			data = new DataSource<T>()
		} else if (data instanceof Array) {
			data = new DataSource(data)
		}

		this.data = data
	}

	/**
	 * Binds the content optimizer to the view.
	 * @method attach
	 * @since 0.2.0
	 */
	public attach(view: View) {

		if (this.attached) {
			return this
		}

		this.attached = true

		this.native.attach(view.native)

		this.data.on('reload', this.onDataSourceReloadData)
		this.data.on('insert', this.onDataSourceInsertData)
		this.data.on('remove', this.onDataSourceRemoveData)
		this.data.on('commit', this.onDataSourceCommitData)
		this.data.on('change', this.onDataSourceChangeData)
		this.data.on('update', this.onDataSourceUpdateData)

		this[VIEW] = view

		return this
	}

	/**
	 * Disconnect the content optimizer from the item.
	 * @method detach
	 * @since 0.2.0
	 */
	public detach() {

		if (this.attached == false) {
			return this
		}

		this.attached = false

		this.native.detach()

		this.data.off('reload', this.onDataSourceReloadData)
		this.data.off('insert', this.onDataSourceInsertData)
		this.data.off('remove', this.onDataSourceRemoveData)
		this.data.off('commit', this.onDataSourceCommitData)
		this.data.off('change', this.onDataSourceChangeData)
		this.data.off('update', this.onDataSourceUpdateData)

		this.data.clear()

		return this
	}

	/**
	 * @inherited
	 * @method destroy
	 * @since 0.2.0
	 */
	public destroy() {
		this.data.destroy()
		super.destroy()
	}

	/**
	 * Resets the content optimizer data.
	 * @method reset
	 * @since 0.2.0
	 */
	public reset() {
		this.native.reset()
		return this
	}

	/**
	 * Returns an active item index.
	 * @method getItemIndex
	 * @since 0.2.0
	 */
	public getItemIndex(item: View): number {
		return this.native.getItemIndex(item.native)
	}

	/**
	 * Returns an active item for a specified data index.
	 * @method getItem
	 * @since 0.2.0
	 */
	public getItem(index: number): View | undefined {
		return this.native.getItem(index)
	}

	/**
	 * Caches a reusable item based on its type.
	 * @method cacheItem
	 * @since 0.2.0
	 */
	public cacheItem(item: View) {
		this.native.cacheItem(item.native)
		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * Called when the data source reloads its data.
	 * @method onReloadData
	 * @since 0.2.0
	 */
	protected onReloadData(event: Event<DataSourceReloadEvent<T>>) {

	}

	/**
	 * Called when the data source inserts data.
	 * @method onInsertData
	 * @since 0.2.0
	 */
	protected onInsertData(event: Event<DataSourceInsertEvent<T>>) {

	}

	/**
	 * Called when the data source removes data.
	 * @method onRemoveData
	 * @since 0.2.0
	 */
	protected onRemoveData(event: Event<DataSourceRemoveEvent<T>>) {

	}

	/**
	 * Called before the data source receives an update.
	 * @method onCommitData
	 * @since 0.5.0
	 */
	protected onCommitData(event: Event) {

	}

	/**
	 * Called when the data source updates data.
	 * @method onChangeData
	 * @since 0.5.0
	 */
	protected onChangeData(event: Event<DataSourceChangeEvent<T>>) {

	}

	/**
	 * Called when the data source finishes an update.
	 * @method onUpdateData
	 * @since 0.5.0
	 */
	protected onUpdateData(event: Event) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [VIEW]
	 * @since 0.5.0
	 * @hidden
	 */
	private [VIEW]: View | null = null

	/**
	 * @property attached
	 * @since 0.2.0
	 * @hidden
	 */
	private attached: boolean = false

	/**
	 * @method onDataSourceReloadData
	 * @since 0.2.0
	 * @hidden
	 */
	@bound private onDataSourceReloadData(event: Event<DataSourceReloadEvent<T>>) {
		this.onReloadData(event)
	}

	/**
	 * @method onDataSourceInsertData
	 * @since 0.2.0
	 * @hidden
	 */
	@bound private onDataSourceInsertData(event: Event<DataSourceInsertEvent<T>>) {
		this.onInsertData(event)
	}

	/**
	 * @method onDataSourceRemoveData
	 * @since 0.2.0
	 * @hidden
	 */
	@bound private onDataSourceRemoveData(event: Event<DataSourceRemoveEvent<T>>) {
		this.onRemoveData(event)
	}

	/**
	 * @method onDataSourceChangeData
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onDataSourceChangeData(event: Event<DataSourceChangeEvent<T>>) {
		this.onChangeData(event)
	}

	/**
	 * @method onDataSourceUpdateData
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onDataSourceUpdateData(event: Event) {
		this.onUpdateData(event)
	}

	/**
	 * @method onDataSourceCommitData
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onDataSourceCommitData(event: Event) {

	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.2.0
	 * @hidden
	 */
	public native: any
}
