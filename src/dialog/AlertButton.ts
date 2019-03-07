import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Event } from '../event/Event'
import { Emitter } from '../event/Emitter'

/**
 * @interface AlertButtonOptions
 * @since 0.1.0
 */
export interface AlertButtonOptions {
	id?: string
	label?: string
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
		this.label = options.label || 'OK'
		this.style = options.style || 'normal'
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEmit
	 * @since 0.1.0
	 */
	onEmit(event: Event) {

		switch (event.type) {

			case 'press':
				this.onPress(event)
				break
		}

		super.onEmit(event)
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
	 * @property native
	 * @since 0.1.0
	 * @hidden
	 */
	public native: any

	/**
	 * @method nativePress
	 * @since 0.1.0
	 * @hidden
	 */
	private nativePress() {
		this.emit('press')
	}
}