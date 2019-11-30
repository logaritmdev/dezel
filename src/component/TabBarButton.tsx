import { Image } from '../component/Image'
import { Label } from '../component/Label'
import { state } from '../decorator/state'
import { TouchEvent } from '../touch/TouchEvent'
import { Reference } from '../view/Reference'
import { View } from '../view/View'
import { Component } from './Component'
import { Root } from './Root'
import './style/TabBarButton.style'
import './style/TabBarButton.style.android'
import './style/TabBarButton.style.ios'

/**
 * @class TabBarButton
 * @super Component
 * @since 0.1.0
 */
export class TabBarButton extends Component {

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
	 * @since 0.1.0
	 */
	public get image(): Image {
		return this.refs.image.get()
	}

	/**
	 * @property badge
	 * @since 0.1.0
	 */
	public get badge(): Label {
		return this.refs.badge.get()
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
			<Root>
				<Image ref={this.refs.image} id="image" />
				<Label ref={this.refs.label} id="label" />
				<Label ref={this.refs.badge} id="badge" visible={false} />
			</Root>
		)
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	protected onTouchStart(event: TouchEvent) {
		if (this.pressed == false && this.disabled == false) {
			this.pressed = true
		}
	}

	/**
	 * @method onTouchEnd
	 * @since 0.1.0
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
	 * @since 0.7.0
	 * @hidden
	 */
	private refs = {
		image: new Reference<Image>(),
		badge: new Reference<Label>(),
		label: new Reference<Label>()
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
	}
}