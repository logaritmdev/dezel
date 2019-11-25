import { View } from '../view/View'
import { $children } from './symbol/Root'

/**
 * @class Host
 * @sine 0.7.0
 */
export class Root {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property children
	 * @hidden
	 */
	public get children(): ReadonlyArray<View> {
		return this[$children]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public reset(children: Array<View>) {
		this[$children] = children
		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $children
	 * @since 0.7.0
	 * @hidden
	 */
	private [$children]: Array<View> = []
}