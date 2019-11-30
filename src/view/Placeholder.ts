import { bound } from '../decorator/bound'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { insertItem } from './private/Placeholder'
import { insertView } from './private/Placeholder'
import { removeItem } from './private/Placeholder'
import { removeView } from './private/Placeholder'
import { $children } from './symbol/Placeholder'
import { $offset } from './symbol/Placeholder'
import { $parent } from './symbol/Placeholder'
import { View } from './View'
import { ViewInsertEvent } from './View'
import { ViewMoveToParentEvent } from './View'
import { ViewRemoveEvent } from './View'

/**
 * @class Placeholder
 * @super Emitter
 * @since 0.7.0
 */
export class Placeholder extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @propety offset
	 * @since 0.7.0
	 */
	public get offset(): number {
		return this[$offset]
	}

	/**
	 * @propety parent
	 * @since 0.7.0
	 */
	public get parent(): View | null {
		return this[$parent]
	}

	/**
	 * @property children
	 * @since 0.7.0
	 */
	public get children(): ReadonlyArray<View> {
		return this[$children]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method embed
	 * @since 0.7.0
	 * @hidden
	 */
	public embed(parent: View, offset: number) {

		this[$offset] = offset
		this[$parent] = parent

		this.children.forEach((c, i) => {
			parent.insert(c, i + this[$offset])
		})

		parent.on('insert', this.onViewInsert)
		parent.on('remove', this.onViewRemove)
		parent.on('destroy', this.onViewDestroy)

		this.emit<ViewMoveToParentEvent>('movetoparent', { data: { parent } })

		return this
	}

	/**
	 * @method destroy
	 * @since 0.7.0
	 */
	public destroy() {

		if (this.parent) {
			this.parent.off('insert', this.onViewInsert)
			this.parent.off('remove', this.onViewRemove)
			this.parent.off('destroy', this.onViewDestroy)
		}

		for (let child of this.children) {
			this.remove(child)
		}

		this.emit<ViewMoveToParentEvent>('movetoparent', { data: { parent: null } })

		return super.destroy()
	}

	/**
	 * @method append
	 * @since 0.7.0
	 */
	public append(child: View) {
		return this.insert(child, this.children.length)
	}

	/**
	 * @method insert
	 * @since 0.7.0
	 */
	public insert(child: View, index: number) {

		if (index > this.children.length) {
			index = this.children.length
		} else if (index < 0) {
			index = 0
		}

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

		let index = this.children.indexOf(child)
		if (index == -1) {
			return this
		}

		removeItem(this, child, index)
		removeView(this, child, index)

		this.emit<ViewRemoveEvent>('remove', { data: { child, index } })

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

		super.onEvent(event)

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
	}

	/**
	 * @method onInsert
	 * @since 0.7.0
	 */
	protected onInsert(child: View, index: number) {

	}

	/**
	 * @method onRemove
	 * @since 0.7.0
	 */
	protected onRemove(child: View, index: number) {

	}

	/**
	 * @method onAttach
	 * @since 0.7.0
	 */
	protected onMoveToParent(view: View | null) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $offset
	 * @since 0.7.0
	 * @hidden
	 */
	private [$offset]: number = 0

	/**
	 * @property $parent
	 * @since 0.7.0
	 * @hidden
	 */
	private [$parent]: View | null = null

	/**
	 * @property $children
	 * @since 0.7.0
	 * @hidden
	 */
	private [$children]: Array<View> = []

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

		if (this.children.indexOf(child) > -1) {
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

		if (this.children.indexOf(child) > -1) {
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
