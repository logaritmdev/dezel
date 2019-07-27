import { bound } from '../decorator/bound'
import { render } from '../decorator/render'
import { Event } from '../event/Event'
import { View } from '../view/View'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'
import { Window } from '../view/Window'
import { Host } from './Host'
import { setContainer } from './Slot'
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
 * @symbol LOCKED
 * @since 0.7.0
 */
export const LOCKED = Symbol('locked')

/**
 * @symbol SEALED
 * @since 0.7.0
 */
export const SEALED = Symbol('sealed')

/**
 * @symbol CONTENT
 * @since 0.7.0
 */
export const MAIN = Symbol('main')

/**
 * @class Component
 * @super Emitter
 * @since 0.7.0
 */
export abstract class Component<TRefs = any, TSlots = any> extends View {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * TODO
	 * @property lock
	 * @since 0.7.0
	 */
	public static lock(component: Component) {
		component[LOCKED] = true
	}

	/**
	 * TODO
	 * @property seal
	 * @since 0.7.0
	 */
	public static seal(component: Component) {
		component[SEALED] = true
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the component is built.
	 * @property built
	 * @since 0.7.0
	 */
	public get built(): boolean {
		return this[BUILT]
	}

	/**
	 * Whether the component is sealed.
	 * @property sealed
	 * @since 0.7.0
	 */
	public get sealed(): boolean {
		return this[SEALED]
	}

	/**
	 * Whether the component is locked.
	 * @property locked
	 * @since 0.7.0
	 */
	public get locked(): boolean {
		return this[LOCKED]
	}

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
	@render public get parent(): View | null | undefined {
		return super.parent
	}

	/**
	 * The component's children.
	 * @property children
	 * @since 0.7.0
	 */
	@render public get children(): ReadonlyArray<View> {
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
	public append(child: View, slot: string | null = null) {
		return this.insert(child, this.children.length, slot)
	}

	/**
	 * @inherited
	 * @method insert
	 * @since 0.7.0
	 */
	public insert(child: View, index: number, slot: string | null = null) {

		if (this.locked) {
			throw new Error(
				`Component error: ` +
				`This component is locked and cannot be mutated.`
			)
		}

		if (slot) {

			let container = this[SLOTS][slot] as Slot
			if (container == null) {
				throw new Error(
					`Component error: ` +
					`The component ${this.constructor.name} does not have a slot named ${slot}. ` +
					`Did you forget to call defineSlot() ?`
				)
			}

			container.insert(child, index)

			return this
		}

		if (this.sealed) {

			let content = this[MAIN]
			if (content == null) {
				throw new Error(
					`Component error: ` +
					`The component ${this.constructor.name} is sealed therefore ` +
					`you must use one if its slot to manage its content.`
				)
			}

			this.insert(child, index, content.name)

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

		if (this.locked) {
			throw new Error(
				`Component error: ` +
				`This component is locked and cannot be mutated.`
			)
		}

		if (slot) {

			let container = this[SLOTS][slot] as Slot
			if (container == null) {
				throw new Error(
					`Component error: ` +
					`The component ${this.constructor.name} does not have a slot named ${slot}. ` +
					`Did you forget to call defineSlot() ?`
				)
			}

			container.remove(child)

			return this
		}

		if (this.sealed) {

			let content = this[MAIN]
			if (content == null) {
				throw new Error(
					`Component error: ` +
					`The component ${this.constructor.name} is sealed therefore ` +
					`you must use one if its slot to manage its content.`
				)
			}

			this.remove(child, content.name)

			return this
		}

		return super.remove(child)
	}

	/**
	 * Defines a slot.
	 * @method defineSlot
	 * @since 0.7.0
	 */
	public defineSlot(slot: Slot, parent: View, offset: number | null = null, main: boolean = false) {

		if (slot.container) {
			throw new Error(
				`Component error: ` +
				`This slot is already defined by ${slot.container.constructor.name}.`
			)
		}

		let name = slot.name

		if (this[SLOTS][name]) {
			throw new Error(
				`Component error: ` +
				`Component ${this.constructor.name} already defines a slot named ${name}.`
			)
		}

		setContainer(slot, this)

		slot.on('insert', this.onSlotInsert)
		slot.on('remove', this.onSlotRemove)

		this[SLOTS][name] = slot

		if (offset == null) {
			offset = parent.children.length
		}

		slot.enter(
			parent,
			offset
		)

		if (main) {

			let current = this[MAIN]
			if (current) {
				throw new Error(
					`Component error: ` +
					`This component already have a default slots of type ${current.constructor.name}.`
				)
			}

			this[MAIN] = slot
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

		if (event.type == 'movetoparent') {
			this.build()
		}

		super.onEvent(event)
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

		Component.seal(this)

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
	 * @property SEALED
	 * @since 0.7.0
	 * @hidden
	 */
	private [SEALED]: boolean = false

	/**
	 * @property LOCKED
	 * @since 0.7.0
	 * @hidden
	 */
	private [LOCKED]: boolean = false

	/**
	 * @property CONTENT
	 * @since 0.7.0
	 * @hidden
	 */
	private [MAIN]: Slot | null | undefined

	/**
	 * @method onSlotInsert
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onSlotInsert(event: Event<ViewInsertEvent>) {
		this.emit<ViewInsertEvent>('insert', { data: event.data })
	}

	/**
	 * @method onSlotRemove
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onSlotRemove(event: Event<ViewRemoveEvent>) {
		this.emit<ViewRemoveEvent>('remove', { data: event.data })
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
