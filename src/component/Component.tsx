import { bound } from '../decorator/bound'
import { Event } from '../event/Event'
import { Children } from '../view/View'
import { Parent } from '../view/View'
import { View } from '../view/View'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'
import { Window } from '../view/Window'
import { render } from './decorator/render'
import { Host } from './Host'
import { setComponent } from './Slot'
import { Slot } from './Slot'

/**
 * @symbol REFS
 * @since 0.7.0
 */
export const REFS = Symbol('refs')

/**
 * @symbol SLOTS
 * @since 0.7.0
 */
export const SLOTS = Symbol('slots')

/**
 * @symbol BUILT
 * @since 0.7.0
 */
export const BUILT = Symbol('built')

/**
 * @type Child
 * @since 0.7.0
 */
export type Child = View | Slot | Array<View | Slot>

/**
 * @class Component
 * @super Emitter
 * @since 0.7.0
 */
export abstract class Component<TRefs = any, TSlots = any> extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The component's window.
	 * @property window
	 * @since 0.7.0
	 */
	@render public get window(): Window | null | undefined {
		return super.window
	}

	/**
	 * The component's parent.
	 * @property parent
	 * @since 0.7.0
	 */
	@render public get parent(): Parent | null | undefined {
		return super.parent
	}

	/**
	 * The component's children.
	 * @property children
	 * @since 0.7.0
	 */
	@render public get children(): Children {
		return super.children
	}

	/**
	 * The component's internal refs.
	 * @property refs
	 * @since 0.7.0
	 */
	@render protected get refs(): TRefs {
		return this[REFS]
	}

	/**
	 * The component's internal slots.
	 * @property slots
	 * @since 0.7.0
	 */
	@render protected get slots(): TSlots {
		return this[SLOTS]
	}

	/**
	 * The component built status.
	 * @property built
	 * @since 0.7.0
	 */
	public get built(): boolean {
		return this[BUILT]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the component.
	 * @constructor
	 * @since 0.7.0
	 */
	constructor() {
		super()
		this.createShadowRoot()
	}

	/**
	 * Renders the component.
	 * @method render
	 * @sinonRender
	 */
	public abstract render(): Host | null | undefined

	/**
	 * @inherited
	 * @method append
	 * @since 0.7.0
	 */
	public append(child: Child, slot: string | null = null) {

		if (child instanceof Slot && child.component == null) {

			/*
			 * Adding a slot that is not associated to a component mean that
			 * this is an implementation slot and not a definition slot. In
			 * this case we can append the contents to the defined slot.
			 */

			let container = this[SLOTS][child.name] as Slot
			if (container == null) {
				throw new Error(
					`Component error: ` +
					`The component ${this.constructor.name} does not define a slot named ${child.name}.`
				)
			}

			container.append(child)

			return this
		}

		if (slot) {

			let container = this[SLOTS][slot] as Slot
			if (container == null) {
				throw new Error(
					`Component error: ` +
					`The component ${this.constructor.name} does not have a slot named ${slot}.`
				)
			}

			container.append(child)

			return this
		}

		return this.insert(child, this.children.length, slot)
	}

	/**
	 * @inherited
	 * @method insert
	 * @since 0.7.0
	 */
	public insert(child: Child, index: number, slot: string | null = null) {

		if (child instanceof Slot && child.component == null) {

			/*
			 * Adding a slot that is not associated to a component mean that
			 * this is an implementation slot and not a definition slot. In
			 * this case we can append the contents to the defined slot.
			 */

			let container = this[SLOTS][child.name] as Slot
			if (container == null) {
				throw new Error(
					`Component error: ` +
					`The component ${this.constructor.name} does not define a slot named ${child.name}.`
				)
			}

			container.insert(child, index)

			return this
		}

		if (slot) {

			let container = this[SLOTS][slot] as Slot
			if (container == null) {
				throw new Error(
					`Component error: ` +
					`The component ${this.constructor.name} does not have a slot named ${slot}.`
				)
			}

			container.insert(child, index)

			return this
		}

		return super.insert(child, index)
	}

	/**
	 * @inherited
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(child: View, slot: string | null = null) {

		if (slot) {

			let container = this[SLOTS][slot] as Slot
			if (container == null) {
				throw new Error(
					`Component error: ` +
					`The component ${this.constructor.name} does not define a slot named ${slot}.`
				)
			}

			container.remove(child)

			return this
		}

		return super.remove(child)
	}

	/**
	 * @inherited
	 * @method useSlot
	 * @since 0.7.0
	 */
	public useSlot(slot: Slot) {

		if (slot.component) {
			throw new Error(
				`Component error: ` +
				`This slot is already used by ${slot.component.constructor.name}.`
			)
		}

		let name = slot.name

		if (this[SLOTS][name] == null) {
			this[SLOTS][name] = slot

			setComponent(slot, this)

		} else {

			throw new Error(
				`Component error: ` +
				`Component ${this.constructor.name} already have a slot named ${name}.`
			)

		}

		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEvent
	 * @since 0.1.0
	 */
	public onEmit(event: Event) {

		if (event.type == 'movetoparent') {
			if (this.built == false) {
				this.build()
			}
		}

		super.onEmit(event)
	}

	/**
	 * Called when the component is rendered.
	 * @method onRender
	 * @since 0.7.0
	 */
	public onRender() {

	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method build
	 * @since 0.7.0
	 * @hidden
	 */
	public build() {

		if (this.built) {
			return this
		}

		this[BUILT] = true

		let container = this.render()
		if (container) {
			container.appendTo(this)
		}

		this.onRender()

		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property REFS
	 * @since 0.7.0
	 * @hidden
	 */
	private [REFS]: any = {}

	/**
	 * @property REFS
	 * @since 0.7.0
	 * @hidden
	 */
	private [SLOTS]: any = {}

	/**
	 * @property BUILT
	 * @since 0.7.0
	 * @hidden
	 */
	private [BUILT]: boolean = false

	/**
	 * @method onInsertInto
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onInsertInto(event: Event<ViewInsertEvent>) {
		// TODO
	}

	/**
	 * @method onRemoveFrom
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onRemoveFrom(event: Event<ViewRemoveEvent>) {
		// TODO
	}
}

/**
 * @function setRef
 * @since 0.7.0
 * @hidden
 */
export function setRef(component: Component, key: string, val: View) {
	component[REFS][key] = val
}
