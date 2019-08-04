import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { Image } from '../graphic/Image'
import { bridge } from '../native/bridge'
import { native } from '../native/native'

/**
 * @interface AlertButtonOptions
 * @since 0.1.0
 */
export interface AlertButtonOptions {
	id?: string
	label?: string
	image?: string | Image
	style?: 'normal' | 'cancel' | 'destructive'
}

@bridge('dezel.dialog.AlertButton')

/**
 * Displays an alert button.
 * @class AlertButton
 * @super Emitter
 * @since 0.1.0
 */
export class AlertButton extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The alert's button id.
	 * @property name
	 * @since 0.4.0
	 */
	public id: string

	/**
	 * The alert button's label.
	 * @property label
	 * @since 0.1.0
	 */
	@native public readonly label!: string

	/**
	 * The alert button's image.
	 * @property image
	 * @since 0.6.0
	 */
	@native public readonly image!: string | Image | null

	/**
	 * The alert button's style.
	 * @property style
	 * @since 0.1.0
	 */
	@native public readonly style!: 'normal' | 'cancel' | 'destructive'

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the alert button.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(options: AlertButtonOptions) {
		super()
		this.id = options.id || 'ok'
		this.image = options.image || null
		this.label = options.label || 'OK'
		this.style = options.style || 'normal'
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEvent
	 * @since 0.7.0
	 */
	onEvent(event: Event) {

		switch (event.type) {

			case 'press':
				this.onPress(event)
				break
		}

		super.onEvent(event)
	}

	/**
	 * @method onPress
	 * @since 0.1.0
	 * @hidden
	 */
	onPress(event: Event) {

	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @method nativeOnPress
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnPress() {
		this.emit('press')
	}
}