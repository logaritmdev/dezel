import { isObject } from 'lodash'
import { ref } from '../decorator/ref'
import { state } from '../decorator/state'
import { Event } from '../event/Event'
import { TouchEvent } from '../touch/TouchEvent'
import { Fragment } from '../view/Fragment'
import { ImageView } from '../view/ImageView'
import { TextView } from '../view/TextView'
import './Button.ds.android'
import './Button.ds.ios'
import { Component } from './Component'
import './Button.ds'


/**
 * Displays a pressable element that performs an action.
 * @class Button
 * @super Component
 * @since 0.1.0
 */
export class Button extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The button's label.
	 * @property label
	 * @since 0.1.0
	 */
	@ref public label!: TextView

	/**
	 * The button's image.
	 * @property image
	 * @since 0.1.0
	 */
	@ref public image!: ImageView

	/**
	 * Whether the state of this button is pressed.
	 * @property pressed
	 * @since 0.1.0
	 */
	@state public pressed: boolean = false

	/**
	 * Whether the state of this button is selected.
	 * @property selected
	 * @since 0.1.0
	 */
	@state public selected: boolean = false

	/**
	 * Whether the state of this button is disabled.
	 * @property disabled
	 * @since 0.1.0
	 */
	@state public disabled: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method render
	 * @since 0.3.0
	 */
	public render() {
		return (
			<Fragment>
				<ImageView id="image" style="image" />
				<TextView id="label" style="label" />
			</Fragment>
		)
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

		if (this.disabled) switch (event.type) {
			case 'touchcancel':
			case 'touchstart':
			case 'touchmove':
			case 'touchend':
				event.cancel()
				break
		}

		super.onEmit(event)
	}

	/**
	 * @inherited
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	public onTouchCancel(event: TouchEvent) {

		super.onTouchCancel(event)

		if (this.pressed && event.targetTouches.length == 0) {
			this.pressed = false
		}
	}

	/**
	 * @inherited
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	public onTouchStart(event: TouchEvent) {

		super.onTouchStart(event)

		if (this.pressed == false && this.disabled == false) {
			this.pressed = true
		}
	}

	/**
	 * @inherited
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	public onTouchEnd(event: TouchEvent) {

		super.onTouchEnd(event)

		if (this.pressed && event.targetTouches.length == 0) {
			this.pressed = false
			this.emitPress(event)
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method emitPress
	 * @since 0.2.0
	 * @hidden
	 */
	private emitPress(event: TouchEvent) {
		event.touches.hits(this) && this.emit('press')
	}
}