import { View } from '../view/View'
import { $pointer } from './symbol/Touch'
import { $target } from './symbol/Touch'
import { $x } from './symbol/Touch'
import { $y } from './symbol/Touch'

/**
 * @class Touch
 * @since 0.1.0
 */
export class Touch {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property pointer
	 * @since 0.1.0
	 */
	public get pointer(): number {
		return this[$pointer]
	}

	/**
	 * @property target
	 * @since 0.1.0
	 */
	public get target(): View {
		return this[$target]
	}

	/**
	 * @property x
	 * @since 0.1.0
	 */
	public get x(): number {
		return this[$x]
	}

	/**
	 * @property y
	 * @since 0.1.0
	 */
	public get y(): number {
		return this[$y]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(pointer: number, target: View, x: number, y: number) {
		this[$pointer] = pointer
		this[$target] = target
		this[$x] = x
		this[$y] = y
	}

	/**
	 * @method hits
	 * @since 0.1.0
	 */
	public hits(target: View) {

		let window = target.window
		if (window == null) {
			return false
		}

		let view = window.findViewAt(this.x, this.y)
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
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $pointer
	 * @since 0.7.0
	 * @hidden
	 */
	private [$pointer]: number

	/**
	 * @property $target
	 * @since 0.7.0
	 * @hidden
	 */
	private [$target]: View

	/**
	 * @property $x
	 * @since 0.7.0
	 * @hidden
	 */
	private [$x]: number

	/**
	 * @property $y
	 * @since 0.7.0
	 * @hidden
	 */
	private [$y]: number
}
