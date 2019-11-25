import { bridge } from '../native/bridge'
import { native } from '../native/native'

@bridge('dezel.locale.Locale')

/**
 * @class Locale
 * @since 0.4.0
 */
export class Locale {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * @property current
	 * @since 0.7.0
	 */
	public static get current(): Locale {

		if (current == null) {
			current = new Locale()
		}

		return current
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property language
	 * @since 0.4.0
	 */
	@native public language!: string

	/**
	 * @property region
	 * @since 0.4.0
	 */
	@native public region!: string

	/**
	 * @property ltr
	 * @since 0.7.0
	 */
	@native public ltr!: boolean

	/**
	 * @property rtl
	 * @since 0.7.0
	 */
	@native public rtl!: boolean

}

/**
 * @const current
 * @since 0.7.0
 * @hidden
 */
let current: Locale | null = null