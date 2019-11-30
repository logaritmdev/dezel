import { View } from '../view/View'
import { $canceled } from './symbol/Touch'
import { $captured } from './symbol/Touch'
import { $id } from './symbol/Touch'
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
	 * @property target
	 * @since 0.1.0
	 */
	public get target(): View {
		return this[$target]
	}

	/**
	 * @property captured
	 * @since 0.7.0
	 */
	public get captured(): boolean {
		return this[$captured]
	}

	/**
	 * @property canceled
	 * @since 0.7.0
	 */
	public get canceled(): boolean {
		return this[$canceled]
	}

	/**
	 * @property id
	 * @since 0.7.0
	 */
	public get id(): number {
		return this[$id]
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
	constructor(target: View) {
		this[$target] = target
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
	 * @property $target
	 * @since 0.7.0
	 * @hidden
	 */
	private [$target]: View

	/**
	 * @property $canceled
	 * @since 0.7.0
	 * @hidden
	 */
	private [$canceled]: boolean = false

	/**
	 * @property $captured
	 * @since 0.7.0
	 * @hidden
	 */
	private [$captured]: boolean = false

	/**
	 * @property $id
	 * @since 0.7.0
	 * @hidden
	 */
	private [$id]: number = 0

	/**
	 * @property $x
	 * @since 0.7.0
	 * @hidden
	 */
	private [$x]: number = 0

	/**
	 * @property $y
	 * @since 0.7.0
	 * @hidden
	 */
	private [$y]: number = 0
}
