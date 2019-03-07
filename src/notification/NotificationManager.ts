import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { bound } from '../decorator/bound'
import { Emitter } from '../event/Emitter'

export type NotificationEvent = {

}

/**
 * The notificaiton.
 * @interface Notification
 * @since 0.1.0
 */
export interface Notification {
	id?: string
	title?: string
	message?: string
}

/**
 * The notification manager options.
 * @interface NotificationManagerOptions
 * @since 0.1.0
 */
export interface NotificationManagerOptions {

}

@bridge('dezel.notification.NotificationManager')

/**
 * Manages notification events and actions.
 * @class NotificationManager
 * @super Emitter
 * @since 0.1.0
 */
export class NotificationManager extends Emitter {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * The default notification manager.
	 * @property main
	 * @since 0.5.0
	 */
	public static get main(): NotificationManager {

		if (main == null) {
			main = new NotificationManager({ authorization: 'always' })
		}

		return main
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether notification services were requested.
	 * @property requested
	 * @since 0.1.0
	 */
	public get requested(): boolean {
		return this.native.requested
	}

	/**
	 * Whether notification services were authorized.
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
	constructor(options: NotificationManagerOptions = {}) {
		super()
		this.native.init(options)
	}

	/**
	 * @method requestAuthorization
	 * @since 0.1.0
	 */
	public requestAuthorization() {
		this.native.requestAuthorization()
		return this
	}

	/**
	 * @method notify
	 * @since 0.1.0
	 */
	public notify(notification: Notification) {
		this.native.notify(notification)
		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.1.0
	 * @hidden
	 */
	public native: any

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

	/**
	 * @method nativeNotification
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeNotification(data: any) {
		this.emit('notification', { data: { data } })
	}
}

/**
 * The main notification manager.
 * @var main
 * @since 0.5.0
 */
let main: NotificationManager | null = null