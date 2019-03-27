import { ref } from '../decorator/ref'
import { state } from '../decorator/state'
import { Event } from '../event/Event'
import { TouchEvent } from '../touch/TouchEvent'
import { Fragment } from '../view/Fragment'
import { ImageView } from '../view/ImageView'
import { TextView } from '../view/TextView'
import { Component } from './Component'
import './NavigationBarButton.ds.android'
import './NavigationBarButton.ds.ios'
import './NavigationBarButton.ds'


/**
 * Displays a pressable element that performs an action in a navigation bar.
 * @class NavigationBarButton
 * @super Component
 * @since 0.1.0
 */
export class NavigationBarButton extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The navigation bar button's label.
	 * @property label
	 * @since 0.1.0
	 */
	@ref public label!: TextView

	/**
	 * The navigation bar button's image.
	 * @property image
	 * @since 0.5.0
	 */
	@ref public image!: ImageView

	/**
	 * Whether the state of this navigation bar button is pressed.
	 * @property pressed
	 * @since 0.1.0
	 */
	@state public pressed: boolean = false

	/**
	 * Whether the state of this navigation bar button is selected.
	 * @property selected
	 * @since 0.1.0
	 */
	@state public selected: boolean = false

	/**
	 * Whether the state of this navigation bar button is disabled.
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
	 * @method onTouchCancel
	 * @since 0.1.0
	 * @hidden
	 */
	public onTouchCancel(event: TouchEvent) {

		super.onTouchCancel(event)

		if (this.pressed && event.targetTouches.length === 0) {
			this.pressed = false
		}
	}

	/**
	 * @method onTouchStart
	 * @since 0.1.0
	 * @hidden
	 */
	public onTouchStart(event: TouchEvent) {

		super.onTouchStart(event)

		if (this.pressed === false) {
			this.pressed = true
		}
	}

	/**
	 * @method onTouchEnd
	 * @since 0.1.0
	 * @hidden
	 */
	public onTouchEnd(event: TouchEvent) {

		super.onTouchEnd(event)

		if (this.pressed && event.targetTouches.length === 0) {
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