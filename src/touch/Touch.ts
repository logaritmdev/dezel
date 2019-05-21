import { View } from '../view/View'

/**
 * @symbol IDENTIFIER
 * @since 0.5.0
 */
export const IDENTIFIER = Symbol('identifier')

/**
 * @symbol TARGET
 * @since 0.5.0
 */
export const TARGET = Symbol('target')

/**
 * @symbol X
 * @since 0.1.0
 */
export const X = Symbol('x')

/**
 * @symbol Y
 * @since 0.1.0
 */
export const Y = Symbol('y')

/**
 * The contact point of a finger on the screen.
 * @class Touch
 * @since 0.1.0
 */
export class Touch {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The touch's identifier.
	 * @property identifier
	 * @since 0.1.0
	 */
	public get identifier(): string {
		return this[IDENTIFIER]
	}

	/**
	 * The touch's target.
	 * @property target
	 * @since 0.1.0
	 */
	public get target(): View {
		return this[TARGET]
	}

	/**
	 * The touch's position on the x axis.
	 * @property x
	 * @since 0.1.0
	 */
	public get x(): number {
		return this[X]
	}

	/**
	 * The touch's position on the y axis.
	 * @property y
	 * @since 0.1.0
	 */
	public get y(): number {
		return this[Y]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(identifier: string, target: View, x: number, y: number) {
		this.setIdentifier(identifier)
		this.setTarget(target)
		this.setX(x)
		this.setY(y)
	}

	/**
	 * Indicates whether the touch did hit the specified view.
	 * @method hits
	 * @since 0.1.0
	 */
	public hits(target: View) {

		let window = target.window
		if (window == null) {
			return false
		}

		let view = window.viewFromPoint(
			this.x,
			this.y
		)

		if (view == target) {
			return true
		}

		while (view) {

			if (view == target) {
				return true
			}

			view = view.parent
		}

		return false
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method setIdentifier
	 * @since 0.5.0
	 * @hidden
	 */
	public setIdentifier(identifier: string) {
		this[IDENTIFIER] = identifier
	}

	/**
	 * @method setTarget
	 * @since 0.5.0
	 * @hidden
	 */
	public setTarget(target: View) {
		this[TARGET] = target
	}

	/**
	 * @method setX
	 * @since 0.1.0
	 * @hidden
	 */
	public setX(x: number) {
		this[X] = x
	}

	/**
	 * @method setY
	 * @since 0.1.0
	 * @hidden
	 */
	public setY(y: number) {
		this[Y] = y
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [IDENTIFIER]
	 * @since 0.5.0
	 * @hidden
	 */
	private [IDENTIFIER]: string

	/**
	 * @property [TARGET]
	 * @since 0.5.0
	 * @hidden
	 */
	private [TARGET]: View

	/**
	 * @property [X]
	 * @since 0.1.0
	 * @hidden
	 */
	private [X]: number

	/**
	 * @property [Y]
	 * @since 0.1.0
	 * @hidden
	 */
	private [Y]: number

}