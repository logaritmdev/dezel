import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Event } from '../event/Event'
import { Emitter } from '../event/Emitter'
import { Image } from '../graphic/Image'

/**
 * @interface SheetButtonOptions
 * @since 0.5.0
 */
export interface SheetButtonOptions {
	id?: string
	label?: string
	style?: 'normal' | 'cancel' | 'destructive'
	image?: string | Image
}

@bridge('dezel.dialog.SheetButton')

/**
 * Displays an alert button.
 * @class SheetButton
 * @super Emitter
 * @since 0.5.0
 */
export class SheetButton extends Emitter {

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
	 * The sheet button's label.
	 * @property label
	 * @since 0.5.0
	 */
	@native public readonly label!: string

	/**
	 * The sheet button's style.
	 * @property style
	 * @since 0.5.0
	 */
	@native public readonly style!: 'normal' | 'cancel' | 'destructive'

	/**
	 * The sheet button's image.
	 * @property image
	 * @since 0.5.0
	 */
	@native public readonly image!: string | Image | null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the alert button.
	 * @constructor
	 * @since 0.5.0
	 */
	constructor(options: SheetButtonOptions) {
		super()
		this.id = options.id || 'ok'
		this.label = options.label || 'OK'
		this.style = options.style || 'normal'
		this.image = options.image || null
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEmit
	 * @since 0.5.0
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
	 * @since 0.5.0
	 * @hidden
	 */
	onPress(event: Event) {

	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.5.0
	 * @hidden
	 */
	public native: any

	/**
	 * @method nativePress
	 * @since 0.5.0
	 * @hidden
	 */
	private nativePress() {
		this.emit('press')
	}
}