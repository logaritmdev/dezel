import { $data } from './symbol/Recycler'
import { $onInsertView } from './symbol/Recycler'
import { $onRemoveView } from './symbol/Recycler'
import { $view } from './symbol/Recycler'
import { bound } from '../decorator/bound'
import { setEmitterResponder } from '../event/private/Emitter'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { Data } from '../data/Data'
import { DataChangeEvent } from '../data/Data'
import { DataInsertEvent } from '../data/Data'
import { DataReloadEvent } from '../data/Data'
import { DataRemoveEvent } from '../data/Data'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { View } from '../view/View'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'

@bridge('dezel.view.Recycler')

/**
 * @class Recycler
 * @super Emitter
 * @since 0.7.0
 */
export class Recycler<T> extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.7.0
	 */
	public get view(): View {
		return this[$view]
	}

	/**
	 * @property data
	 * @since 0.7.0
	 */
	public get data(): Data<T> {
		return this[$data]
	}

	public animated: boolean = true

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(view: View, data: Array<T> | Data<T>, options: RecyclerOptions<T>) {

		super()

		if (data == null) {
			data = new Data<T>()
		} else if (data instanceof Array) {
			data = new Data(data)
		}

		this[$view] = view
		this[$data] = data
		this[$onInsertView] = options.onInsertView
		this[$onRemoveView] = options.onRemoveView

		// native(this).view = native(view)
		// native(this).length = this.data.length
		// native(this).estimation = options.estimatedItemSize

		this.data.on('reload', this.onDataReload)
		this.data.on('insert', this.onDataInsert)
		this.data.on('remove', this.onDataRemove)
		this.data.on('commit', this.onDataCommit)
		this.data.on('change', this.onDataChange)
		this.data.on('update', this.onDataUpdate)
	}

	/**
	 * @method destroy
	 * @since 0.7.0
	 */
	public destroy() {

		native(this).destroy()

		this.data.off('reload', this.onDataReload)
		this.data.off('insert', this.onDataInsert)
		this.data.off('remove', this.onDataRemove)
		this.data.off('commit', this.onDataCommit)
		this.data.off('change', this.onDataChange)
		this.data.off('update', this.onDataUpdate)

		this.data.destroy()

		return super.destroy()
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public reset() {
		native(this).reset()
		return this
	}

	/**
	 * @method getItem
	 * @since 0.7.0
	 */
	public getItem(index: number): View | undefined {
		return native(this).getItem(index)
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
	 * @method cacheItem
	 * @since 0.7.0
	 */
	public cacheItem(item: View) {
		native(this).cacheItem(native(item))
		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @method onReloadData
	 * @since 0.7.0
	 */
	protected onReloadData(event: Event<DataReloadEvent<T>>) {

	}

	/**
	 * @method onInsertData
	 * @since 0.7.0
	 */
	protected onInsertData(event: Event<DataInsertEvent<T>>) {

		native(this).length = this.data.length
		native(this).insertData(
			event.data.index,
			event.data.rows.length,
			this.animated
		)

		if (this.animated) {
			//this.performTransition()
		}
	}

	/**
	 * @method onRemoveData
	 * @since 0.7.0
	 */
	protected onRemoveData(event: Event<DataRemoveEvent<T>>) {

	}

	/**
	 * @method onCommitData
	 * @since 0.7.0
	 */
	protected onCommitData(event: Event) {

	}

	/**
	 * @method onChangeData
	 * @since 0.7.0
	 */
	protected onChangeData(event: Event<DataChangeEvent<T>>) {

	}

	/**
	 * @method onUpdateData
	 * @since 0.7.0
	 */
	protected onUpdateData(event: Event) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $view
	 * @since 0.7.0
	 * @hidden
	 */
	private [$view]: View

	/**
	 * @property $data
	 * @since 0.7.0
	 * @hidden
	 */
	private [$data]: Data<T>

	/**
	 * @property $onInsertView
	 * @since 0.7.0
	 * @hidden
	 */
	private [$onInsertView]: RecyclerInsertViewCallback<T>

	/**
	 * @property $onRemoveView
	 * @since 0.7.0
	 * @hidden
	 */
	private [$onRemoveView]: RecyclerRemoveViewCallback<T>

	/**
	 * @method onDataReload
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onDataReload(event: Event<DataReloadEvent<T>>) {
		this.onReloadData(event)
	}

	/**
	 * @method onDataInsert
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onDataInsert(event: Event<DataInsertEvent<T>>) {
		this.onInsertData(event)
	}

	/**
	 * @method onDataRemove
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onDataRemove(event: Event<DataRemoveEvent<T>>) {
		this.onRemoveData(event)
	}

	/**
	 * @method onDataChange
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onDataChange(event: Event<DataChangeEvent<T>>) {
		this.onChangeData(event)
	}

	/**
	 * @method onDataUpdate
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onDataUpdate(event: Event) {
		this.onUpdateData(event)
	}

	/**
	 * @method onDataCommit
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onDataCommit(event: Event) {

	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @method nativeDefineItem
	 * @since 0.5.0
	 * @hidden
	 */
	private nativeGetItemType(index: number) {
		//return this.defineItem(index, this.data.get(index))
	}

	/**
	 * @method nativeOnRemoveItem
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnInsertItem(index: number, child: View) {
		setEmitterResponder(child, this.view)
		this.view.emit<ViewInsertEvent>('insert', { data: { child, index } })
	}

	/**
	 * @method nativeOnRemoveItem
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnRemoveItem(index: number, child: View) {
		setEmitterResponder(child, null)
		this.view.emit<ViewRemoveEvent>('remove', { data: { child, index } })
	}
}

/**
 * @interface RecyclerOptions
 * @since 0.7.0
 */
export interface RecyclerOptions<T> {
	estimation: number
	onInsertView: RecyclerInsertViewCallback<T>
	onRemoveView: RecyclerRemoveViewCallback<T>
}

/**
 * @type RecyclerInsertViewCallback
 * @since 0.7.0
 */
export type RecyclerInsertViewCallback<T> = (index: number, data: T, item: View) => void

/**
 * @type RecyclerRemoveViewCallback
 * @since 0.7.0
 */
export type RecyclerRemoveViewCallback<T> = (index: number, data: T, item: View) => void