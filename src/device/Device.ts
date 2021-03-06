import { bridge } from '../decorator/bridge'

@bridge('dezel.device.Device')

/**
 * Contains informations regarding the current device.
 * @class Device
 * @since 0.4.0
 */
export class Device {

	//--------------------------------------------------------------------------
	// Property
	//--------------------------------------------------------------------------

	/**
	 * Returns the device's name.
	 * @property name
	 * @since 0.4.0
	 */
	public get uuid(): string {
		return this.native.uuid
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Plays a device sound.
	 * @method sound
	 * @since 0.4.0
	 */
	public sound(id: string) {
		this.native.sound(id)
		return this
	}

	/**
	 * Vibrates the device.
	 * @method vibrate
	 * @since 0.4.0
	 */
	public vibrate(id: string) {
		this.native.vibrate(id)
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
