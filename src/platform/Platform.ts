import { bridge } from '../native/bridge'
import { native } from '../native/native'

@bridge('dezel.platform.Platform')

/**
 * Contains informations regarding the current platform.
 * @class Platform
 * @since 0.1.0
 */
export class Platform {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * The current device.
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
	 * Returns the platform's name.
	 * @property name
	 * @since 0.1.0
	 */
	public get name(): string {
		return native(this).name
	}

	/**
	 * Returns the platform's version.
	 * @property version
	 * @since 0.1.0
	 */
	public get version(): string {
		return native(this).version
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

}

/**
 * The current platform.
 * @var current
 * @since 0.7.0
 */
let current: Platform | null = null