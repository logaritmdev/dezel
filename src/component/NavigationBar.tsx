import { bound } from '../decorator/bound'
import { Event } from '../event/Event'
import { Reference } from '../view/Reference'
import { View } from '../view/View'
import { Component } from './Component'
import { Label } from './Label'
import { Root } from './Root'
import { Slot } from './Slot'
import './style/NavigationBar.style'
import './style/NavigationBar.style.android'
import './style/NavigationBar.style.ios'

/**
 * @class NavigationBar
 * @super Component
 * @since 0.1.0
 */
export class NavigationBar extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property title
	 * @since 0.1.0
	 */
	public get title(): Label {
		return this.refs.title.get()
	}

	/**
	 * @property mainButtons
	 * @since 0.4.0
	 */
	public get mainButtons(): Slot {
		return this.refs.mainButtons.get()
	}

	/**
	 * @property sideButtons
	 * @since 0.4.0
	 */
	public get sideButtons(): Slot {
		return this.refs.sideButtons.get()
	}

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
				<View style="buttons-container">
					<Slot name="back" />
					<Slot name="side" />
				</View>
				<View ref={this.refs.titleContainer} id="title-container" onLayout={this.onTitleContainerBeforeLayout}>
					<Label ref={this.refs.title} id="title" />
				</View>
				<View style="buttons-container">
					<Slot name="main" main={true} />
				</View>
			</Root>
		)
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
		title: new Reference<Label>(),
		titleContainer: new Reference<View>(),
		mainButtons: new Reference<Slot>(),
		sideButtons: new Reference<Slot>()
	}

	/**
	 * @method onTitleContainerBeforeLayout
	 * @since 0.1.0
	 * @hidden
	 */
	@bound private onTitleContainerBeforeLayout(event: Event) {
		/*
		if (this.title == null) {
			return
		}

		let titleContainer = this.refs.titleContainer.value
		if (titleContainer == null) {
			return
		}

		let direction = titleContainer.contentDirection
		let disposition = titleContainer.contentDisposition

		if (disposition !== 'center' ||
			direction !== 'horizontal') {
			this.title.top = 'auto'
			this.title.left = 'auto'
			this.title.anchorTop = 0
			return
		}

		this.title.top = 0
		this.title.left = 0
		this.title.anchorTop = 0
		this.title.width = 'auto'

		let outerW = this.measuredInnerWidth

		//this.title.measure()

		let frameL = titleContainer.measuredLeft
		let frameW = titleContainer.measuredInnerWidth
		let frameH = titleContainer.measuredInnerHeight
		let titleW = this.title.measuredWidth

		let titleCenter = this.title.measuredLeft + frameW / 2 - titleW / 2

		let outerCenter = outerW / 2
		let frameCenter = frameW / 2 + frameL

		let offset = outerCenter - frameCenter
		this.title.top = frameH / 2
		this.title.left = clamp(titleCenter + offset, 0, frameW - titleW)
		this.title.anchorTop = 0.5

		if (titleW > frameW) {
			this.title.width = frameW
		}
		*/
	}
}
