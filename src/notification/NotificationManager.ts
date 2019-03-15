import { bound } from '../decorator/bound'
import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'

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

		this.native.notify(
			notification.id || '',
			notification.title || '',
			notification.message || ''
		)

		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEmit
	 * @since 0.6.0
	 */
	public onEmit(event: Event) {

		switch (event.type) {

			case 'receivetoken':
				this.onReceiveToken(event)
				break
		}

		return super.onEmit(event)
	}

	/**
	 * Called when the remote token is received.
	 * @method onReceiveToken
	 * @since 0.6.0
	 */
	public onReceiveToken(event: Event) {

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
	 * @method nativeReceiveToken
	 * @since 0.6.0
	 * @hidden
	 */
	private nativeReceiveToken(token: string, provider: string) {
		this.emit('receivetoken', { data: { token, provider } })
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
 * @type NotificationManagerReceiveTokenEvent
 * @since 0.6.0
 */
export type NotificationManagerReceiveTokenEvent = {
	token: string
	provider: string
}

/**
 * The main notification manager.
 * @var main
 * @since 0.5.0
 */
let main: NotificationManager | null = null