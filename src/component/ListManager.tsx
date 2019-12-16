import { $recycler } from './private/ListManager'
import { Data } from '../data/Data'
import { Recycler } from '../view/Recycler'
import { View } from '../view/View'
import { Composable } from './Composable'
import { List } from './List'
import { ListItem } from './ListItem'

/**
 * @class Tappable
 * @since 0.7.0
 */
export class ListManager<T> implements Composable {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	// Callbacks
	//--------------------------------------------------------------------------

	/**
	 * @property getItemType
	 * @since 0.7.0
	 */
	public getItemType?: GetItemType<T>

	/**
	 * @property onInsertItem
	 * @since 0.7.0
	 */
	public onInsertItem?: OnInsertItem<T>

	/**
	 * @property onRemoveItem
	 * @since 0.7.0
	 */
	public onRemoveItem?: OnRemoveItem<T>

	public data?: Data<T>

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method onCompose
	 * @since 0.7.0
	 */
	public onCompose(view: View) {

		if (view instanceof List) {

			let getItemType = this.getItemType
			if (getItemType == null) {
				throw new Error('ListManager error: Missing getItemType callback')
			}
			let onInsertItem = this.onInsertItem
			if (onInsertItem == null) {
				throw new Error('ListManager error: Missing onInsertItem callback')
			}
			let onRemoveItem = this.onRemoveItem
			if (onRemoveItem == null) {
				throw new Error('ListManager error: Missing onRemoveItem callback')
			}
			let data = this.data
			if (data == null) {
				throw new Error('ListManager error: Missing data')
			}

			this[$recycler] = new Recycler(view.items, data, {
				estimatedItemSize: 12,
				getViewType: getItemType,
				onInsertView: (index: number, data: T, item: View) => onInsertItem!(index, data, item as ListItem),
				onRemoveView: (index: number, data: T, item: View) => onRemoveItem!(index, data, item as ListItem)
			})

			return
		}

		throw new Error(`ListManager error: The `)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $gesture
	 * @since 0.7.0
	 * @hidden
	 */
	private [$recycler]: Recycler<T>

	//--------------------------------------------------------------------------
	// JSX
	//--------------------------------------------------------------------------

	/**
	 * @property __jsxProps
	 * @since 0.4.0
	 * @hidden
	 */
	public __jsxProps: any

}

/**
 * @type GetItemType
 * @since 0.7.0
 */
export type GetItemType<T> = (index: number, data: T) => void

/**
 * @type RecyclerInsertViewCallback
 * @since 0.7.0
 */
export type OnInsertItem<T> = (index: number, data: T, item: ListItem) => void

/**
 * @type OnRemoveItem
 * @since 0.7.0
 */
export type OnRemoveItem<T> = (index: number, data: T, item: ListItem) => void