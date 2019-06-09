import { state } from '../decorator/state'
import { TouchEvent } from '../touch/TouchEvent'
import { Reference } from '../util/Reference'
import { Fragment } from '../view/Fragment'
import { ImageView } from '../view/ImageView'
import { TextView } from '../view/TextView'
import { Component } from './Component'
import './TabBarButton.ds'
import './TabBarButton.ds.android'
import './TabBarButton.ds.ios'

/**
 * Displays a pressable element that performs an action in a tab bar.
 * @class TabBarButton
 * @super Component
 * @since 0.1.0
 */
export class TabBarButton extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The tab bar button image.
	 * @property image
	 * @since 0.1.0
	 */
	public get image(): ImageView {
		return this.imageRef.value!
	}

	/**
	 * The tab bar button label.
	 * @property label
	 * @since 0.1.0
	 */
	public get label(): TextView {
		return this.labelRef.value!
	}

	/**
	 * The tab bar badge.
	 * @property badge
	 * @since 0.1.0
	 */
	public get badge(): TextView {
		return this.badgeRef.value!
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
			<Fragment>
				<ImageView ref={this.imageRef} style="image" />
				<TextView ref={this.labelRef} style="label" />
				<TextView ref={this.badgeRef} style="badge" />
			</Fragment>
		)
	}

	/**
	 * @inherited
	 * @method onCreate
	 * @since 0.3.0
	 */
	public onCreate() {
		this.badge.visible = false
	}

	//--------------------------------------------------------------------------
	// Private API
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
	 * @property imageRef
	 * @since 0.7.0
	 * @hidden
	 */
	private imageRef = new Reference<ImageView>(this)

	/**
	 * @property labelRef
	 * @since 0.7.0
	 * @hidden
	 */
	private labelRef = new Reference<TextView>(this)

	/**
	 * @property badgeRef
	 * @since 0.7.0
	 * @hidden
	 */
	private badgeRef = new Reference<TextView>(this)

	/**
	 * @method emitPress
	 * @since 0.2.0
	 * @hidden
	 */
	private emitPress(event: TouchEvent) {
		event.touches.hits(this) && this.emit('press')
	}
}