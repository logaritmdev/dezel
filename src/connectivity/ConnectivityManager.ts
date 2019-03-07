import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Emitter } from '../event/Emitter'

/**
 * The connectivity manager options.
 * @interface ConectivityManagerOptions
 * @since 0.1.0
 */
export interface ConnectivityManagerOptions {

}

/**
 * @symbol STATUS
 * @since 0.1.0
 */
export const STATUS = Symbol('status')

@bridge('dezel.connectivity.ConnectivityManager')

/**
 * Manages connectivity events and actions.
 * @class ConnectivityManager
 * @super Emitter
 * @since 0.1.0
 */
export class ConnectivityManager extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The connectivity status.
	 * @property status
	 * @since 0.1.0
	 */
	public get status(): 'none' | 'wifi' | 'wwan' {
		return this.native.status
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(options: ConnectivityManagerOptions = {}) {
		super()
		this.native.init()
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
	 * @method nativeStatusChange
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeStatusChange(status: 'none' | 'wifi' | 'wwan') {

		this.emit<ConnectivityManagerStatusEvent>('change', { data: { status } })

		switch (status) {

			case 'none':
				this.emit('disconnect')
				break

			case 'wifi':
				this.emit('connect')
				this.emit('connectwifi')
				break

			case 'wwan':
				this.emit('connect')
				this.emit('connectwwan')
				break
		}
	}
}

/**
 * @type ConnectivityManagerStatusEvent
 * @since 0.1.0
 */
export type ConnectivityManagerStatusEvent = {
	status: 'none' | 'wifi' | 'wwan'
}