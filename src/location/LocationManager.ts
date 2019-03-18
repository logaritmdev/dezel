import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Emitter } from '../event/Emitter'

/**
 * The location manager options.
 * @interface LocationManagerOptions
 * @since 0.1.0
 */
export interface LocationManagerOptions {
	authorization?: 'always' | 'wheninuse' | 'fine' | 'coarse'
}

@bridge('dezel.location.LocationManager')

/**
 * Manages location events and actions
 * @class LocationManager
 * @super Emitter
 * @since 0.1.0
 */
export class LocationManager extends Emitter {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * The default location manager.
	 * @property main
	 * @since 0.5.0
	 */
	public static get main(): LocationManager {

		if (main == null) {

			switch (platform.name) {

				case 'ios':
					main = new LocationManager({ authorization: 'always' })
					break

				case 'android':
					main = new LocationManager({ authorization: 'fine' })
					break

				default:
					throw new Error('LocationManager Error: Invalid platform')
			}
		}

		return main
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether location services area enabled.
	 * @property enabled
	 * @since 0.1.0
	 */
	public get enabled(): boolean {
		return this.native.enabled
	}

	/**
	 * Whether location services were requested.
	 * @property requested
	 * @since 0.1.0
	 */
	public get requested(): boolean {
		return this.native.requested
	}

	/**
	 * Whether location services were authorized.
	 * @property authorized
	 * @since 0.1.0
	 */
	public get authorized(): boolean {
		return this.native.authorized
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(options: LocationManagerOptions = {}) {
		super()
		this.native.init(options.authorization)
	}

	/**
	 * @method requestAuthorization
	 * @since 0.1.0
	 */
	public requestAuthorization() {
		this.native.requestAuthorization()
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

	/**
	 * @method nativeEnable
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeEnable() {
		this.emit('enable')
	}

	/**
	 * @method nativeDisable
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeDisable() {
		this.emit('disable')
	}

	/**
	 * @method nativeAuthorize
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeAuthorize() {
		this.emit('authorize')
	}

	/**
	 * @method nativeUnauthorize
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeUnauthorize() {
		this.emit('unauthorize')
	}
}

/**
 * The main location manager.
 * @var main
 * @since 0.5.0
 */
let main: LocationManager | null = null