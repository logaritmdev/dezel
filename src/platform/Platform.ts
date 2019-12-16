import { bridge } from '../native/bridge'
import { native } from '../native/native'

@bridge('dezel.platform.Platform')

/**
 * @class Platform
 * @since 0.1.0
 */
export class Platform {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * The current platform.
	 * @property current
	 * @since 0.7.0
	 */
	public static get current(): Platform {

		if (current == null) {
			current = new Platform()
		}

		return current
	}

	//--------------------------------------------------------------------------
	// Property
	//--------------------------------------------------------------------------

	/**
	 * The platform's name.
	 * @property name
	 * @since 0.1.0
	 */
	@native public readonly name!: string

	/**
	 * The platform's version.
	 * @property version
	 * @since 0.1.0
	 */
	@native public readonly version!: string

}

/**
 * @const current
 * @since 0.7.0
 * @hidden
 */
let current: Platform | null = null