import { Image } from '../component/Image'
import { Label } from '../component/Label'
import { state } from '../decorator/state'
import { TouchEvent } from '../touch/TouchEvent'
import { View } from '../view/View'
import { Component } from './Component'
import { Host } from './Host'
import './TabBarButton.ds'
import './TabBarButton.ds.android'
import './TabBarButton.ds.ios'

/**
 * The internal references.
 * @interface Refs
 * @since 0.7.0
 */
interface Refs {
	label: Label
	image: Image
	badge: Label
}

/**
 * Displays a pressable element that performs an action in a tab bar.
 * @class TabBarButton
 * @super Component
 * @since 0.1.0
 */
export class TabBarButton extends Component<Refs> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The tab bar button label.
	 * @property label
	 * @since 0.1.0
	 */
	public get label(): Label {
		return this.refs.label
	}

	/**
	 * The tab bar button image.
	 * @property image
	 * @since 0.1.0
	 */
	public get image(): Image {
		return this.refs.image
	}

	/**
	 * The tab bar badge.
	 * @property badge
	 * @since 0.1.0
	 */
	public get badge(): Label {
		return this.refs.badge
	}

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
			<Host>
				<Image for={this} id="image" style="image" />
				<Label for={this} id="label" style="label" />
				<Label for={this} id="badge" style="badge" />
			</Host>
		)
	}

	/**
	 * @inherited
	 * @method onRender
	 * @since 0.3.0
	 */
	public onRender() {
		this.badge.visible = false
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

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