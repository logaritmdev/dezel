import { state } from '../decorator/state'
import { Event } from '../event/Event'
import { TouchEvent } from '../touch/TouchEvent'
import { Reference } from '../view/Reference'
import { View } from '../view/View'
import { Component } from './Component'
import { Image } from './Image'
import { Label } from './Label'
import './style/NavigationBarButton.style'
import './style/NavigationBarButton.style.android'
import './style/NavigationBarButton.style.ios'

/**
 * @class NavigationBarButton
 * @super Component
 * @since 0.1.0
 */
export class NavigationBarButton extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property label
	 * @since 0.1.0
	 */
	public get label(): Label {
		return this.refs.label.get()
	}

	/**
	 * @property image
	 * @since 0.5.0
	 */
	public get image(): Image {
		return this.refs.image.get()
	}

	/**
	 * @property pressed
	 * @since 0.1.0
	 */
	@state public pressed: boolean = false

	/**
	 * @property selected
	 * @since 0.1.0
	 */
	@state public selected: boolean = false

	/**
	 * @property disabled
	 * @since 0.1.0
	 */
	@state public disabled: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method render
	 * @since 0.3.0
	 */
	public render() {
		return (
			<View>
				<Image ref={this.refs.image} id="image" />
				<Label ref={this.refs.label} id="label" />
			</View>
		)
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @method onEvent
	 * @since 0.7.0
	 */
	public onEvent(event: Event) {

		if (this.disabled) switch (event.type) {
			case 'touchcancel':
			case 'touchstart':
			case 'touchmove':
			case 'touchend':
				event.cancel()
				break
		}

		super.onEvent(event)
	}

	/**
	 * @method onTouchStart
	 * @since 0.1.0
	 * @hidden
	 */
	protected onTouchStart(event: TouchEvent) {
		if (this.pressed == false) {
			this.pressed = true
		}
	}

	/**
	 * @method onTouchEnd
	 * @since 0.1.0
	 * @hidden
	 */
	protected onTouchEnd(event: TouchEvent) {
		if (this.pressed && event.targetTouches.length == 0) {
			this.pressed = false
			this.press(event)
		}
	}

	/**
	 * @method onTouchCancel
	 * @since 0.1.0
	 * @hidden
	 */
	protected onTouchCancel(event: TouchEvent) {
		if (this.pressed && event.targetTouches.length == 0) {
			this.pressed = false
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property refs
	 * @since 0.2.0
	 * @hidden
	 */
	private refs = {
		label: new Reference<Label>(),
		image: new Reference<Image>()
	}

	/**
	 * @method press
	 * @since 0.7.0
	 * @hidden
	 */
	private press(event?: TouchEvent) {

		if (event &&
			event.hits(this) == false) {
			return
		}

		this.emit('press')

		return this
	}
}