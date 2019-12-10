import { $children } from './symbol/Root'
import { View } from '../view/View'

/**
 * @class Host
 * @since 0.7.0
 */
export class Root {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property children
	 * @since 0.7.0
	 */
	public get children(): ReadonlyArray<View> {
		return this[$children]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method append
	 * @hidden
	 */
	public append(view: View) {
		this[$children].push(view)
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