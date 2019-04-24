import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'

@bridge('dezel.locale.Locale')

/**
 * Contains information about the current locale.
 * @class Storage
 * @since 0.4.0
 */
export class Locale {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * The current locale language.
	 * @property language
	 * @since 0.4.0
	 */
	@native public language!: string

	/**
	 * The current locale region.
	 * @property region
	 * @since 0.4.0
	 */
	@native public region!: string

	/**
	 * The current locale direction.
	 * @property direction
	 * @since 0.4.0
	 */
	@native public direction!: 'ltr' | 'rtl'

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.4.0
	 * @hidden
	 */
	public native: any
}
