import { bridge } from '../native/bridge'
import { native } from '../native/native'

@bridge('dezel.device.Device')

/**
 * @class Device
 * @since 0.4.0
 */
export class Device {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * @property current
	 * @since 0.7.0
	 */
	public static get current(): Device {

		if (current == null) {
			current = new Device()
		}

		return current
	}

	//--------------------------------------------------------------------------
	// Property
	//--------------------------------------------------------------------------

	/**
	 * @property name
	 * @since 0.4.0
	 */
	public get uuid(): string {
		return native(this).uuid
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method sound
	 * @since 0.4.0
	 */
	public sound(id: string) {
		native(this).sound(id)
		return this
	}

	/**
	 * @method vibrate
	 * @since 0.4.0
	 */
	public vibrate(id: string) {
		native(this).vibrate(id)
		return this
	}
}

/**
 * The current device.
 * @const current
 * @since 0.7.0
 */
let current: Device | null = null