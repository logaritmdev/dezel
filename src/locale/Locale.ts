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
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Stores a value synchronously.
	 * @method set
	 * @since 0.4.0
	 */
	public set(key: string, value: any) {
		this.native.set(key, JSON.stringify(value))
		return this
	}

	/**
	 * Retrieves a value synchronously.
	 * @method get
	 * @since 0.4.0
	 */
	public get(key: string) {

		let res = this.native.get(key)
		if (res == null ||
			res == 'null' ||
			res == 'undefined') {
			return null
		}

		return JSON.parse(res) || undefined
	}

	/**
	 * Removes a value synchronously.
	 * @method remove
	 * @since 0.4.0
	 */
	public remove(key: string) {
		this.native.remove(key)
		return this
	}

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
