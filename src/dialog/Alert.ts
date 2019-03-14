import { bound } from '../decorator/bound'
import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { AlertButton } from './AlertButton'

/**
 * @symbol SELECTION
 * @since 0.4.0
 */
export const SELECTION = Symbol('button')

/**
 * @symbol PRESENTED
 * @since 0.4.0
 */
export const PRESENTED = Symbol('presented')

/**
 * @interface AlertOptions
 * @super Emitter
 * @since 0.1.0
 */
export interface AlertOptions {
	style?: 'alert' | 'sheet'
	title?: string
	message?: string
	buttons?: Array<AlertButton>
}

@bridge('dezel.dialog.Alert')

/**
 * Displays an alert.
 * @class Alert
 * @super Emitter
 * @since 0.1.0
 */
export class Alert extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The alert's style.
	 * @property style
	 * @since 0.1.0
	 */
	public readonly style: 'alert' | 'sheet'

	/**
	 * The alert's title.
	 * @property title
	 * @since 0.1.0
	 */
	public readonly title: string

	/**
	 * The alert's message.
	 * @property message
	 * @since 0.1.0
	 */
	public readonly message: string

	/**
	 * The alert's buttons.
	 * @property buttons
	 * @since 0.1.0
	 */
	public readonly buttons: Array<AlertButton>

	/**
	 * Whether the alert is presented.
	 * @property presented
	 * @since 0.4.0
	 */
	public get presented(): boolean {
		return this[PRESENTED]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the alert.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(options: AlertOptions = {}) {

		super()

		this.style = options.style || 'alert'
		this.title = options.title || ''
		this.message = options.message || ''
		this.buttons = options.buttons || []

		this.buttons.forEach(button => button.on('press', this.onButtonPress))
	}

	/**
	 * Presents the alert.
	 * @method present
	 * @since 0.1.0
	 */
	public present() {

		if (this.presented) {

			console.error(`
				Alert error:
				This alert is already presented.
			`)

			return this
		}

		this[SELECTION] = 'ok'

		this.native.present(
			this.style,
			this.title,
			this.message,
			this.buttons.map(button => button.native)
		)

		return this
	}

	/**
	 * Dismisses the alert.
	 * @method dismiss
	 * @since 0.1.0
	 */
	public dismiss() {

		if (this.presented) {

			console.error(`
				Alert error:
				This alert is not presented.
			`)

			return this
		}

		this.native.dismiss()

		return this
	}

	/**
	 * Presents the alert.
	 * @method present
	 * @since 0.3.0
	 */
	public prompt(): Promise<string> {

		if (this.presented) {

			console.error(`
				Alert error:
				This alert is already presented.
			`)

			return Promise.resolve('')
		}

		return new Promise((success) => {
			this.present().once('dismiss', (event: Event<AlertDismissEvent>) => success(event.data.button))
		})
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEmit
	 * @since 0.1.0
	 */
	public onEmit(event: Event) {

		switch (event.type) {

			case 'present':
				this.onPresent(event)
				break

			case 'dismiss':
				this.onDismiss(event)
				break
		}

		return super.onEmit(event)
	}

	/**
	 * Called when the alert is presented.
	 * @method onPresent
	 * @since 0.1.0
	 */
	public onPresent(event: Event) {

	}

	/**
	 * Called when the alert is dismissed.
	 * @method onDismiss
	 * @since 0.1.0
	 */
	public onDismiss(event: Event<AlertDismissEvent>) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [PRESENTED]
	 * @since 0.3.0
	 * @hidden
	 */
	private [PRESENTED]: boolean = false

	/**
	 * @property [SELECTION]
	 * @since 0.4.0
	 * @hidden
	 */
	private [SELECTION]: string = 'ok'

	/**
	 * @method onButtonPress
	 * @since 0.3.0
	 * @hidden
	 */
	@bound private onButtonPress(event: Event) {
		this[SELECTION] = (event.sender as AlertButton).id
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
	 * @method nativePresent
	 * @since 0.1.0
	 * @hidden
	 */
	private nativePresent() {
		this[PRESENTED] = true
		this.emit('present')
	}

	/**
	 * @method nativeDismiss
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeDismiss() {
		this[PRESENTED] = false
		this.emit<AlertDismissEvent>('dismiss', { data: { button: this[SELECTION] } })
	}
}

/**
 * @type AlertDismissEvent
 * @since 0.3.0
 */
export type AlertDismissEvent = {
	button: string
}