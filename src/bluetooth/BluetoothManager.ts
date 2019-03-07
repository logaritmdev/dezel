import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Emitter } from '../event/Emitter'

/**
 * The bluetooth manager options.
 * @interface BluetoothManagerOptions
 * @since 0.1.0
 */
export interface BluetoothManagerOptions {
	authorization?: string
}

@bridge('dezel.bluetooth.BluetoothManager')

/**
 * Manages bluetooth events and actions.
 * @class BluetoothManager
 * @super Emitter
 * @since 0.1.0
 */
export class BluetoothManager extends Emitter {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * The default location manager.
	 * @property main
	 * @since 0.5.0
	 */
	public static get main(): BluetoothManager {

		if (main == null) {
			main = new BluetoothManager()
		}

		return main
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether bluetooth services area enabled.
	 * @property enabled
	 * @since 0.1.0
	 */
	public get enabled(): boolean {
		return this.native.enabled
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(options: BluetoothManagerOptions = {}) {
		super()
		this.native.init(options)
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
}

/**
 * The main bluetooth manager.
 * @var main
 * @since 0.5.0
 */
let main: BluetoothManager | null = null