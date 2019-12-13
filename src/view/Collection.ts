import { $items } from './private/Collection'
import { $length } from './private/Collection'
import { $offset } from './private/Collection'
import { $target } from './private/Collection'
import { bound } from '../decorator/bound'
import { insertItem } from './private/Collection'
import { insertView } from './private/Collection'
import { removeItem } from './private/Collection'
import { removeView } from './private/Collection'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { View } from './View'
import { ViewInsertEvent } from './View'
import { ViewMoveToParentEvent } from './View'
import { ViewRemoveEvent } from './View'

/**
 * @class Collection
 * @super Emitter
 * @since 0.7.0
 */
export class Collection extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The collection's length.
	 * @propety length
	 * @since 0.7.0
	 */
	public get length(): number {
		return this[$length]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method attach
	 * @since 0.7.0
	 * @hidden
	 */
	public attach(target: View, offset: number) {

		this[$target] = target
		this[$offset] = offset

		this[$items].forEach((c, i) => {
			target.insert(c, i + offset)
		})

		target.on('insert', this.onViewInsert)
		target.on('remove', this.onViewRemove)
		target.on('destroy', this.onViewDestroy)

		this.emit<ViewMoveToParentEvent>('movetoparent', { data: { parent: target } })

		return this
	}

	/**
	 * @method destroy
	 * @since 0.7.0
	 */
	public destroy() {

		if (this[$target]) {
			this[$target].off('insert', this.onViewInsert)
			this[$target].off('remove', this.onViewRemove)
			this[$target].off('destroy', this.onViewDestroy)
		}

		this.removeAll()

		this.emit<ViewMoveToParentEvent>('movetoparent', { data: { parent: null } })

		return super.destroy()
	}

	/**
	 * @method get
	 * @since 0.7.0
	 */
	public get(index: number) {
		return this[$items][index]
	}

	/**
	 * @method index
	 * @since 0.7.0
	 */
	public index(child: View) {
		return this[$items].indexOf(child)
	}

	/**
	 * @method append
	 * @since 0.7.0
	 */
	public append(child: View) {
		return this.insert(child, this.length)
	}

	/**
	 * @method insert
	 * @since 0.7.0
	 */
	public insert(child: View, index: number) {

		if (index > this.length) {
			index = this.length
		} else if (index < 0) {
			index = 0
		}

		this[$length]++

		insertItem(this, child, index)
		insertView(this, child, index)

		this.emit<ViewInsertEvent>('insert', { data: { child, index } })

		return this
	}

	/**
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(child: View) {

		let index = this.index(child)
		if (index == -1) {
			return this
		}

		this[$length]--

		removeItem(this, child, index)
		removeView(this, child, index)

		this.emit<ViewRemoveEvent>('remove', { data: { child, index } })

		return this
	}

	/**
	 * @method removeAll
	 * @since 0.7.0
	 */
	public removeAll() {

		while (this[$items].length) {
			this.remove(this[$items][0])
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @method onEvent
	 * @since 0.7.0
	 */
	public onEvent(event: Event) {

		switch (event.type) {

			case 'insert':
				this.onInsert(event.data.child, event.data.index)
				break

			case 'remove':
				this.onRemove(event.data.child, event.data.index)
				break

			case 'movetoparent':
				this.onMoveToParent(event.data.parent)
				break
		}

		super.onEvent(event)
	}

	/**
	 * @method onInsert
	 * @since 0.7.0
	 */
	public onInsert(child: View, index: number) {

	}

	/**
	 * @method onRemove
	 * @since 0.7.0
	 */
	public onRemove(child: View, index: number) {

	}

	/**
	 * @method onAttach
	 * @since 0.7.0
	 */
	public onMoveToParent(view: View | null) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $view
	 * @since 0.7.0
	 * @hidden
	 */
	private [$target]: View

	/**
	 * @property $offset
	 * @since 0.7.0
	 * @hidden
	 */
	private [$offset]: number = 0

	/**
	 * @property $length
	 * @since 0.7.0
	 * @hidden
	 */
	private [$length]: number = 0

	/**
	 * @property $items
	 * @since 0.7.0
	 * @hidden
	 */
	private [$items]: Array<View> = []

	/**
	 * @method onViewInsert
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onViewInsert(event: Event<ViewInsertEvent>) {

		let {
			index,
			child
		} = event.data

		/*
		 * This method will be called when we insert our own
		 * view so we need to disrecard these.
		 */

		if (this.index(child) > -1) {
			return
		}

		/*
		 * Only increment when the view has been added before the position
		 * of the placeholder.
		 */

		if (this[$offset] >= index) {
			this[$offset] += 1
		}
	}

	/**
	 * @method onViewRemove
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onViewRemove(event: Event<ViewRemoveEvent>) {

		let {
			index,
			child
		} = event.data

		/*
		 * This method will be called when we insert our own
		 * view so we need to disrecard these.
		 */

		if (this.index(child) > -1) {
			return
		}

		/*
		 * Only increment when the view has been removed before the position
		 * of the placeholder.
		 */

		if (this[$offset] >= index) {
			this[$offset] -= 1
		}
	}

	/**
	 * @method onViewDestroy
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onViewDestroy(event: Event) {
		this.destroy()
	}

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
