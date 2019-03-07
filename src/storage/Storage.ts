import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'

@bridge('dezel.storage.Storage')

/**
 * Store and retrieve data.
 * @class Storage
 * @since 0.1.0
 */
export class Storage {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Stores a value synchronously.
	 * @method set
	 * @since 0.1.0
	 */
	public set(key: string, value: any) {
		this.native.set(key, JSON.stringify(value))
		return this
	}

	/**
	 * Retrieves a value synchronously.
	 * @method get
	 * @since 0.1.0
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
	 * @since 0.1.0
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
	 * @since 0.1.0
	 * @hidden
	 */
	public native: any
}
