import { bound } from '../decorator/bound'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { View } from '../view/View'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'

/**
 * @enum Location
 * @since 0.7.0
 */
export enum Location {
	Start,
	Fixed,
	Float,
	End
}

/**
 * @symbol VIEW
 * @since 0.7.0
 */
export const VIEW = Symbol('view')

/**
 * @symbol LOCATION
 * @since 0.7.0
 */
export const LOCATION = Symbol('location')

/**
 * @symbol POSITION
 * @since 0.7.0
 */
export const POSITION = Symbol('position')

/**
 * @symbol CHILDREN
 * @since 0.7.0
 */
export const CHILDREN = Symbol('children')

/**
 * @class Placeholder
 * @since 0.7.0
 */
export class Placeholder extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The placeholder's view.
	 * @propety view
	 * @since 0.7.0
	 */
	public get view(): View | null | undefined {
		return this[VIEW]
	}

	/**
	 * The placeholder's location.
	 * @property position
	 * @since 0.7.0
	 */
	public get location(): Location {
		return this[LOCATION]
	}

	/**
	 * The placeholder's position.
	 * @property position
	 * @since 0.7.0
	 */
	public get position(): number {
		return this[POSITION]
	}

	/**
	 * The placeholder's children.
	 * @property children
	 * @since 0.7.0
	 */
	public get children(): ReadonlyArray<View> {
		return this[CHILDREN]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Destroys the placeholder
	 * @method destroy
	 * @since 0.7.0
	 */
	public destroy() {

		this.leave()

		this[VIEW] = null
		this[POSITION] = 0
		this[LOCATION] = 0
		this[CHILDREN] = []

		super.destroy()
	}

	/**
	 * TODO
	 * @method enter
	 * @since 0.7.0
	 */
	public enter(view: View, position: number, location: Location = Location.Float) {

		this.leave()

		this[VIEW] = view
		this[LOCATION] = location
		this[POSITION] = position

		this.children.forEach((c, i) => {
			this.insert(c, i + position)
		})

		view.on('insert', this.onViewInsert)
		view.on('remove', this.onViewRemove)
		view.on('destroy', this.onViewDestroy)

		return this
	}

	/**
	 * TODO
	 * @method leave
	 * @since 0.7.0
	 */
	public leave() {

		if (this.view) {
			this.view.off('insert', this.onViewInsert)
			this.view.off('remove', this.onViewRemove)
			this.view.off('destroy', this.onViewDestroy)
		}

		this[VIEW] = null
		this[LOCATION] = 0
		this[POSITION] = 0
		this[CHILDREN] = []

		return this
	}

	/**
	 * Appends a child at the end of this placeholder's child list.
	 * @method append
	 * @since 0.7.0
	 */
	public append(child: View) {
		return this.insert(child, this.children.length)
	}

	/**
	 * Inserts a child at an index of this placeholder's child list.
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

		this.emit<ViewInsertEvent>('insert', {
			data: {
				child,
				index
			}
		})

		return this
	}

	/**
	 * Inserts a child after another child from this placeholder's child list.
	 * @method insertAfter
	 * @since 0.1.0
	 */
	public insertAfter(child: View, after: View) {

		let index = this.children.indexOf(after)
		if (index == -1) {
			throw new Error('The specified view cannot be found.')
		}

		this.insert(child, index + 1)

		return this
	}

	/**
	 * Inserts a child before another child from this placeholder's child list.
	 * @method insertBefore
	 * @since 0.1.0
	 */
	public insertBefore(child: View, before: View) {

		let index = this.children.indexOf(before)
		if (index == -1) {
			throw new Error('The specified view cannot be found.')
		}

		this.insert(child, index)

		return this
	}

	/**
	 * Removes a child from this placeholder's child list.
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

		this.emit<ViewRemoveEvent>('remove', {
			data: {
				child,
				index
			}
		})

		return this
	}

	/**
	 * Removes all views from this placeholder.
	 * @method empty
	 * @since 0.7.0
	 */
	public empty() {

		while (this.children.length) {
			this.remove(last(this.children))
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
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

			case 'enter':
				this.onEnter(event.data.view)
				break

			case 'leave':
				this.onLeave(event.data.view)
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
	 * @method onEnter
	 * @since 0.7.0
	 */
	protected onEnter(view: View) {

	}

	/**
	 * @method onLeave
	 * @since 0.7.0
	 */
	protected onLeave(view: View) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property LOCATION
	 * @since 0.7.0
	 * @hidden
	 */
	private [VIEW]: View | null | undefined

	/**
	 * @property LOCATION
	 * @since 0.7.0
	 * @hidden
	 */
	private [LOCATION]: number = 0

	/**
	 * @property POSITION
	 * @since 0.7.0
	 * @hidden
	 */
	private [POSITION]: number = 0

	/**
	 * @property CHILDREN
	 * @since 0.7.0
	 * @hidden
	 */
	private [CHILDREN]: Array<View> = []

	/**
	 * @method onViewInsert
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onViewInsert(event: Event<ViewInsertEvent>) {

		let {
			index
		} = event.data

		/*
		 * Only increment when the view has been added before the position
		 * of the placeholder.
		 */

		if (this.location == Location.Float) {
			if (this[POSITION] >= index) {
				this[POSITION] += 1
			}
		}
	}

	/**
	 * @method onViewRemove
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onViewRemove(event: Event<ViewRemoveEvent>) {

		let {
			index
		} = event.data

		/*
		 * Only increment when the view has been removed before the position
		 * of the placeholder.
		 */

		if (this.location == Location.Float) {
			if (this[POSITION] >= index) {
				this[POSITION] -= 1
			}
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
}

/**
 * @function insertItem
 * @since 0.7.0
 * @hidden
 */
function insertItem(placeholder: Placeholder, child: View, index: number) {
	placeholder[CHILDREN].splice(index, 0, child)
}

/**
 * @function removeItem
 * @since 0.7.0
 * @hidden
 */
function removeItem(placeholder: Placeholder, child: View, index: number) {
	placeholder[CHILDREN].splice(index, 1)
}

/**
 * @function insertView
 * @since 0.7.0
 * @hidden
 */
function insertView(placeholder: Placeholder, child: View, index: number) {

	let view = placeholder.view
	if (view == null) {
		return
	}

	switch (placeholder.location) {

		case Location.Start:
			index = 0
			break

		case Location.Fixed:
			index = placeholder.position
			break

		case Location.Float:
			index = placeholder.position + index
			break

		case Location.End:
			index = view.children.length
			break
	}

	view.insert(child, index)
}

/**
 * @function removeView
 * @since 0.7.0
 * @hidden
 */
function removeView(placeholder: Placeholder, child: View, index: number) {
	if (placeholder.view) {
		placeholder.view.remove(child)
	}
}

/**
 * @function last
 * @since 0.7.0
 * @hidden
 */
function last(list: ReadonlyArray<View>) {
	return list[list.length - 1]
}

/**
 * @type PlaceholderInsertEvent
 * @since 0.7.0
 */
export type PlaceholderInsertEvent = {
	child: View
	index: number
}

/**
 * @type PlaceholderRemoveEvent
 * @since 0.7.0
 */
export type PlaceholderRemoveEvent = {
	child: View
	index: number
}