import { $children } from './private/Root'
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
	 * The root's children.
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
	 * Append a view to this root.
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