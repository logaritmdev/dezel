import { Dictionary } from 'lodash'
import { render } from '../decorator/render'
import { Event } from '../event/Event'
import { native } from '../native/native'
import { View } from '../view/View'
import { Window } from '../view/Window'
import { getComponentBody } from './private/Component'
import { getComponentSlot } from './private/Component'
import { $body } from './symbol/Component'
import { $locked } from './symbol/Component'
import { $rendered } from './symbol/Component'
import { $sealed } from './symbol/Component'
import { $slots } from './symbol/Component'
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
	 * @property sealed
	 * @since 0.7.0
	 */
	public get sealed(): boolean {
		return this[$sealed]
	}

	/**
	 * @property locked
	 * @since 0.7.0
	 */
	public get locked(): boolean {
		return this[$locked]
	}

	/**
	 * @property rendered
	 * @since 0.7.0
	 */
	public get rendered(): boolean {
		return this[$rendered]
	}

	/**
	 * @property window
	 * @since 0.7.0
	 */
	@render public get window(): Window | null {
		return super.window
	}

	/**
	 * @property parent
	 * @since 0.7.0
	 */
	@render public get parent(): View | null {
		return super.parent
	}

	/**
	 * @property children
	 * @since 0.7.0
	 */
	@render public get children(): ReadonlyArray<View> {
		return super.children
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor() {
		super()
		native(this).setOpaque()
	}

	/**
	 * @method render
	 * @since 0.6.0
	 */
	public abstract render(): Root | null

	/**
	 * @method append
	 * @since 0.7.0
	 */
	public append(child: View, slot?: string) {
		return this.insert(child, this.children.length, slot)
	}

	/**
	 * @method insert
	 * @since 0.7.0
	 */
	public insert(child: View, index: number, slot?: string) {

		if (this.locked) {

			throw new Error(
				`Component error: ` +
				`This component is locked and cannot be mutated.`
			)

		}

		if (slot) {

			let container = getComponentSlot(this, slot)
			if (container) {
				container.insert(child, index)
				return this
			}

			throw new Error(
				`Component error: ` +
				`The component ${this.constructor.name} does not have a slot named ${slot}.`
			)
		}

		if (this.sealed) {

			let container = getComponentBody(this)
			if (container) {
				container.insert(child, index)
				return this
			}

			throw new Error(
				`Component error: ` +
				`The component ${this.constructor.name} does not have a main slot.`
			)
		}

		return super.insert(child, index)
	}

	/**
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(child: View, slot?: string) {

		if (this.locked) {

			throw new Error(
				`Component error: ` +
				`This component is locked and cannot be mutated.`
			)

		}

		if (slot) {

			let container = getComponentSlot(this, slot)
			if (container) {
				container.remove(child)
				return this
			}

			throw new Error(
				`Component error: ` +
				`The component ${this.constructor.name} does not have a slot named ${slot}.`
			)
		}

		if (this.sealed) {

			let container = getComponentBody(this)
			if (container) {
				container.remove(child)
				return this
			}

			throw new Error(
				`Component error: ` +
				`The component ${this.constructor.name} does not have a main slot.`
			)
		}

		return super.remove(child)
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

			case 'render':
				this.onRender()
				break

			case 'moveToParent':
				break

			case 'moveToWindow':
				break
		}

		super.onEvent(event)
	}

	/**
	 * @method onRender
	 * @since 0.7.0
	 */
	protected onRender() {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $sealed
	 * @since 0.7.0
	 * @hidden
	 */
	private [$sealed]: boolean = false

	/**
	 * @property $locked
	 * @since 0.7.0
	 * @hidden
	 */
	private [$locked]: boolean = false

	/**
	 * @property $rendered
	 * @since 0.7.0
	 * @hidden
	 */
	private [$rendered]: boolean = false

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
