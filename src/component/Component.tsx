import { $body } from './private/Component'
import { $locked } from './private/Component'
import { $sealed } from './private/Component'
import { $slots } from './private/Component'
import { native } from '../native/native'
import { validateRefs } from '../view/private/Reference'
import { getSlot } from './private/Component'
import { makeComponent } from './private/Component'
import { pullRenderingComponent } from './private/Component'
import { pushRenderingComponent } from './private/Component'
import { Event } from '../event/Event'
import { View } from '../view/View'
import { Window } from '../view/Window'
import { Root } from './Root'
import { Slot } from './Slot'

/**
 * @class Component
 * @super Emitter
 * @since 0.7.0
 */
export abstract class Component extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the component is sealed.
	 * @property sealed
	 * @since 0.7.0
	 */
	public get sealed(): boolean {
		return this[$sealed]
	}

	/**
	 * Whether the component is locked.
	 * @property locked
	 * @since 0.7.0
	 */
	public get locked(): boolean {
		return this[$locked]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initialize the component.
	 * @constructor
	 * @since 0.7.0
	 */
	constructor() {

		super()

		native(this).setOpaque()

		pushRenderingComponent(this)
		makeComponent(this)
		pullRenderingComponent(this)

		validateRefs(this)

		this[$sealed] = true
		this[$locked] = false
	}

	/**
	 * Renders the component.
	 * @method render
	 * @since 0.6.0
	 */
	public abstract render(): Root | null

	/**
	 * Appends a child into one of the component's slot.
	 * @method append
	 * @since 0.7.0
	 */
	public append(child: View, slot: string | null = null) {
		return this.insert(child, this.children.length, slot)
	}

	/**
	 * Inserts a child into one of the component's slot.
	 * @method insert
	 * @since 0.7.0
	 */
	public insert(child: View, index: number, slot: string | null = null) {

		if (this.locked) {
			throw new Error(`Component error: This component is locked.`)
		}

		if (slot) {

			let container = getSlot(this, slot)
			if (container) {
				container.insert(child, index)
				return this
			}

			throw new Error(`Component error: The component does not have a slot named ${slot}.`)
		}

		if (this.sealed) {

			let container = this[$body]
			if (container) {
				container.insert(child, index)
				return this
			}

			throw new Error(`Component error: The component is sealed.`)
		}

		return super.insert(child, index)
	}

	/**
	 * Removes a child from one of the component's slot.
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(child: View, slot: string | null = null) {

		if (this.locked) {
			throw new Error(`Component error: This component is locked.`)
		}

		if (slot) {

			let container = getSlot(this, slot)
			if (container) {
				container.remove(child)
				return this
			}

			throw new Error(`Component error: The component does not have a slot named ${slot}.`)
		}

		if (this.sealed) {

			let container = this[$body]
			if (container) {
				container.remove(child)
				return this
			}

			throw new Error(`Component error: The component is sealed.`)
		}

		return super.remove(child)
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * Called when the component is rendered.
	 * @method onRender
	 * @since 0.7.0
	 */
	public onRender() {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $sealed
	 * @since 0.7.0
	 * @hidden
	 */
	private [$sealed]: boolean

	/**
	 * @property $locked
	 * @since 0.7.0
	 * @hidden
	 */
	private [$locked]: boolean

	/**
	 * @property $slots
	 * @since 0.7.0
	 * @hidden
	 */
	private [$slots]: Dictionary<Slot> = {}

	/**
	 * @property $body
	 * @since 0.7.0
	 * @hidden
	 */
	private [$body]: Slot | null = null
}
