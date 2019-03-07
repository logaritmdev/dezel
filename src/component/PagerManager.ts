import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { Emitter } from '../event/Emitter'
import { View } from '../view/View'
import { Pager } from './Pager'
import { DataSource } from '../data/DataSource'
import { DataSourceReloadEvent } from '../data/DataSource'
import { DataSourceInsertEvent } from '../data/DataSource'
import { DataSourceRemoveEvent } from '../data/DataSource'
import { DataSourceChangeEvent } from '../data/DataSource'

/**
 * Manages the pager's content using a data source.
 * @class PagerManager
 * @super Emitter
 * @since 0.4.0
 */
export class PagerManager<T = any> extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The pager manager data.
	 * @property data
	 * @since 0.4.0
	 */
	public readonly data!: DataSource<T>

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
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
	 * @since 0.4.0
	 */
	public attach(pager: Pager) {

		if (this.attached) {
			return this
		}

		this.pager = pager

		this.data.on('reload', this.onDataSourceReloadData)
		this.data.on('insert', this.onDataSourceInsertData)
		this.data.on('remove', this.onDataSourceRemoveData)
		this.data.on('update', this.onDataSourceUpdateData)
		this.data.on('commit', this.onDataSourceCommitData)

		this.attached = true

		return this
	}

	/**
	 * Disconnect the content optimizer from the item.
	 * @method detach
	 * @since 0.4.0
	 */
	public detach() {

		if (this.attached == false) {
			return this
		}

		this.data.off('reload', this.onDataSourceReloadData)
		this.data.off('insert', this.onDataSourceInsertData)
		this.data.off('remove', this.onDataSourceRemoveData)
		this.data.off('update', this.onDataSourceUpdateData)
		this.data.off('commit', this.onDataSourceCommitData)

		this.data.clear()

		this.attached = false

		return this
	}

	/**
	 * @inherited
	 * @method destroy
	 * @since 0.4.0
	 */
	public destroy() {

		this.data.off('reload', this.onDataSourceReloadData)
		this.data.off('insert', this.onDataSourceInsertData)
		this.data.off('remove', this.onDataSourceRemoveData)
		this.data.off('update', this.onDataSourceUpdateData)
		this.data.off('commit', this.onDataSourceCommitData)
		this.data.destroy()

		super.destroy()
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * Called when the data source reloads its data.
	 * @method onReloadData
	 * @since 0.4.0
	 */
	public onReloadData(event: Event<DataSourceReloadEvent<T>>) {

	}

	/**
	 * Called when the data source inserts data.
	 * @method onInsertData
	 * @since 0.4.0
	 */
	public onInsertData(event: Event<DataSourceInsertEvent<T>>) {

	}

	/**
	 * Called when the data source removes data.
	 * @method onRemoveData
	 * @since 0.4.0
	 */
	public onRemoveData(event: Event<DataSourceRemoveEvent<T>>) {

	}

	/**
	 * Called when the data source updates data.
	 * @method onUpdateData
	 * @since 0.4.0
	 */
	public onUpdateData(event: Event<DataSourceChangeEvent<T>>) {

	}

	/**
	 * Called when the data source finishes an update.
	 * @method onCommitData
	 * @since 0.4.0
	 */
	public onCommitData(event: Event) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property pager
	 * @since 0.4.0
	 * @hidden
	 */
	private pager?: Pager | null

	/**
	 * @property attached
	 * @since 0.4.0
	 * @hidden
	 */
	private attached: boolean = false

	/**
	 * @method onDataSourceReloadData
	 * @since 0.4.0
	 * @hidden
	 */
	@bound private onPagerBeforeLayout(event: Event) {

	}

	/**
	 * @method onDataSourceReloadData
	 * @since 0.4.0
	 * @hidden
	 */
	@bound private onDataSourceReloadData(event: Event<DataSourceReloadEvent<T>>) {
		this.onReloadData(event)
	}

	/**
	 * @method onDataSourceInsertData
	 * @since 0.4.0
	 * @hidden
	 */
	@bound private onDataSourceInsertData(event: Event<DataSourceInsertEvent<T>>) {
		this.onInsertData(event)
	}

	/**
	 * @method onDataSourceRemoveData
	 * @since 0.4.0
	 * @hidden
	 */
	@bound private onDataSourceRemoveData(event: Event<DataSourceRemoveEvent<T>>) {
		this.onRemoveData(event)
	}

	/**
	 * @method onDataSourceUpdateData
	 * @since 0.4.0
	 * @hidden
	 */
	@bound private onDataSourceUpdateData(event: Event<DataSourceChangeEvent<T>>) {
		this.onUpdateData(event)
	}

	/**
	 * @method onDataSourceCommitData
	 * @since 0.4.0
	 * @hidden
	 */
	@bound private onDataSourceCommitData(event: Event) {
		this.onCommitData(event)
	}
}
