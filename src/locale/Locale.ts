import { bridge } from '../native/bridge'
import { native } from '../native/native'

@bridge('dezel.locale.Locale')

/**
 * Contains information about the current locale.
 * @class Storage
 * @since 0.4.0
 */
export class Locale {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * The current locale.
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
	 * Whether the local is left to right.
	 * @property ltr
	 * @since 0.7.0
	 */
	@native public ltr!: boolean

	/**
	 * Whether the local is right to left.
	 * @property rtl
	 * @since 0.7.0
	 */
	@native public rtl!: boolean

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

}

/**
 * The current locale.
 * @var current
 * @since 0.7.0
 */
let current: Locale | null = null