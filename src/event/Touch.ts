import { $canceled } from './private/Touch'
import { $captured } from './private/Touch'
import { $id } from './private/Touch'
import { $target } from './private/Touch'
import { $x } from './private/Touch'
import { $y } from './private/Touch'
import { View } from '../view/View'

/**
 * @class Touch
 * @since 0.1.0
 */
export class Touch {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

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

	/**
	 * @property id
	 * @since 0.7.0
	 */
	public get id(): number {
		return this[$id]
	}

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

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

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

	/**
	 * @property $id
	 * @since 0.7.0
	 * @hidden
	 */
	private [$id]: number = 0

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
}
