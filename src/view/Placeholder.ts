import { bound } from '../decorator/bound'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { Child } from '../view/View'
import { Children } from '../view/View'
import { View } from '../view/View'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'

/**
 * @enum Location
 * @since 0.7.0
 */
export enum Location {
	Start,
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
	 * @property location
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
	public get children(): Children {
		return this[CHILDREN]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(location: Location = Location.Float, position: number = 0) {
		super()
		this[LOCATION] = location
		this[POSITION] = position
	}

	/**
	 * Destroys the placeholder
	 * @method destroy
	 * @since 0.7.0
	 */
	public destroy() {

		if (this.view) {
			this.view.off('insert', this.onViewInsert)
			this.view.off('remove', this.onViewRemove)
		}

		this[VIEW] = null
		this[LOCATION] = 0
		this[POSITION] = 0
		this[CHILDREN] = []
	}

	/**
	 * Appends a child at the end of this view's child list.
	 * @method append
	 * @since 0.7.0
	 */
	public append(child: Child) {
		return this.insert(child, this.children.length)
	}

	/**
	 * Inserts a child at an index of this view's child list.
	 * @method insert
	 * @since 0.7.0
	 */
	public insert(child: Child, index: number) {

		if (child instanceof Array) {
			merge(this, child, index)
			return this
		}

		if (child instanceof Placeholder) {
			merge(this, child.children, index);
			return this
		}

		if (index > this.children.length) {
			index = this.children.length
		} else if (index < 0) {
			index = 0
		}

		insertNode(this, child, index)
		insertView(this, child, index)

		return this
	}

	/**
	 * Removes a view from this view's child list.
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(child: View) {

		let index = this.children.indexOf(child)
		if (index == -1) {
			return this
		}

		removeNode(this, child, index)
		removeView(this, child, index)

		return this
	}

	/**
	 * Remove all views this this view.
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
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method appendTo
	 * @since 0.7.0
	 * @hidden
	 */
	public appendTo(view: View) {

		if (this.view) {
			this.view.off('insert', this.onViewInsert)
			this.view.off('remove', this.onViewRemove)
		}

		this[VIEW] = view

		view.on('insert', this.onViewInsert)
		view.on('remove', this.onViewRemove)

		this[POSITION] = view.children.length

		for (let i = 0; i < this.children.length; i++) {
			view.insert(this.children[i], this.position + i)
		}
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
	 * @property LOCATION
	 * @since 0.7.0
	 * @hidden
	 */
	private [POSITION]: number = 0

	/**
	 * @property CHILDREN
	 * @since 0.7.0
	 * @hidden
	 */
	private [CHILDREN]: Children = []

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

		if (this[LOCATION] >= index) {
			this[LOCATION] += 1
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

		if (this[LOCATION] >= index) {
			this[LOCATION] -= 1
		}
	}
}

/**
 * @function insertNode
 * @since 0.7.0
 * @hidden
 */
function insertNode(placeholder: Placeholder, child: View, index: number) {
	placeholder[CHILDREN].splice(index, 0, child)
}

/**
 * @function removeNode
 * @since 0.7.0
 * @hidden
 */
function removeNode(placeholder: Placeholder, child: View, index: number) {
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
			view.insert(child, 0)
			break

		case Location.Float:
			view.insert(child, placeholder.position + index)
			break

		case Location.End:
			view.insert(child, view.children.length)
			break
	}
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
 * @function merge
 * @since 0.7.0
 * @hidden
 */
function merge(placeholder: Placeholder, children: Array<View | Placeholder>, index: number) {
	for (let i = 0; i < children.length; i++) {
		placeholder.insert(children[i], index + i)
	}
}

/**
 * @function last
 * @since 0.7.0
 * @hidden
 */
function last(list: Array<View>) {
	return list[list.length - 1]
}