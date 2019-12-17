import { $buttons } from './private/Alert'
import { $message } from './private/Alert'
import { $presented } from './private/Alert'
import { $selection } from './private/Alert'
import { $style } from './private/Alert'
import { $title } from './private/Alert'
import { bound } from '../decorator/bound'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { AlertButton } from './AlertButton'

@bridge('dezel.dialog.Alert')

/**
 * @class Alert
 * @super Emitter
 * @since 0.1.0
 */
export class Alert extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property style
	 * @since 0.1.0
	 */
	public get style(): 'alert' | 'sheet' {
		return this[$style]
	}

	/**
	 * @property title
	 * @since 0.1.0
	 */
	public get title(): string {
		return this[$title]
	}

	/**
	 * @property message
	 * @since 0.1.0
	 */
	public get message(): string {
		return this[$message]
	}

	/**
	 * @property buttons
	 * @since 0.1.0
	 */
	public get buttons(): Array<AlertButton> {
		return this[$buttons]
	}

	/**
	 * @property presented
	 * @since 0.4.0
	 */
	public get presented(): boolean {
		return this[$presented]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(options: AlertOptions = {}) {

		super()

		let opts = Object.assign(
			{},
			OPTIONS,
			options
		)

		this[$style] = opts.style
		this[$title] = opts.title
		this[$message] = opts.message
		this[$buttons] = opts.buttons

		this.buttons.forEach(button => button.on('press', this.onButtonPress))
	}

	/**
	 * @method present
	 * @since 0.1.0
	 */
	public present() {

		if (this.presented) {
			return this
		}

		this[$selection] = 'ok'

		native(this).present(
			this.style,
			this.title,
			this.message,
			this.buttons.map(button => native(button))
		)

		return this
	}

	/**
	 * @method dismiss
	 * @since 0.1.0
	 */
	public dismiss() {

		if (this.presented) {
			return this
		}

		native(this).dismiss()

		return this
	}

	/**
	 * @method present
	 * @since 0.3.0
	 */
	public prompt(): Promise<string> {

		if (this.presented) {
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
	 * @method onEvent
	 * @since 0.7.0
	 */
	public onEvent(event: Event) {

		switch (event.type) {

			case 'present':
				this.onPresent(event)
				break

			case 'dismiss':
				this.onDismiss(event)
				break
		}

		return super.onEvent(event)
	}

	/**
	 * @method onPresent
	 * @since 0.1.0
	 */
	public onPresent(event: Event) {

	}

	/**
	 * @method onDismiss
	 * @since 0.1.0
	 */
	public onDismiss(event: Event<AlertDismissEvent>) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $style
	 * @since 0.7.0
	 * @hidden
	 */
	private [$style]: 'alert' | 'sheet'

	/**
	 * @property $title
	 * @since 0.7.0
	 * @hidden
	 */
	private [$title]: string

	/**
	 * @property $message
	 * @since 0.7.0
	 * @hidden
	 */
	private [$message]: string

	/**
	 * @property $buttons
	 * @since 0.7.0
	 * @hidden
	 */
	private [$buttons]: Array<AlertButton>

	/**
	 * @property $presented
	 * @since 0.7.0
	 * @hidden
	 */
	private [$presented]: boolean = false

	/**
	 * @property $selection
	 * @since 0.7.0
	 * @hidden
	 */
	private [$selection]: string = ''

	/**
	 * @method onButtonPress
	 * @since 0.3.0
	 * @hidden
	 */
	@bound private onButtonPress(event: Event) {
		this[$selection] = (event.sender as AlertButton).id
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @method nativeOnPresent
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnPresent() {
		this[$presented] = true
		this.emit<AlertPresentEvent>('present')
	}

	/**
	 * @method nativeOnDismiss
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnDismiss() {
		this[$presented] = false
		this.emit<AlertDismissEvent>('dismiss', { data: { button: this[$selection] } })
	}
}

/**
 * @const OPTIONS
 * @since 0.7.0
 * @hidden
 */
const OPTIONS: Required<AlertOptions> = {
	style: 'alert',
	title: '',
	message: '',
	buttons: []
}

/**
 * @interface AlertOptions
 * @since 0.1.0
 */
export interface AlertOptions {
	style?: 'alert' | 'sheet'
	title?: string
	message?: string
	buttons?: Array<AlertButton>
}

/**
 * @type AlertPresentEvent
 * @since 0.3.0
 */
export type AlertPresentEvent = {

}

/**
 * @type AlertDismissEvent
 * @since 0.3.0
 */
export type AlertDismissEvent = {
	button: string
}