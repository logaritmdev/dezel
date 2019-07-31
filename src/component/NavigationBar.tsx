import { clamp } from 'lodash'
import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { Locale } from '../locale/Locale'
import { View } from '../view/View'
import { Component } from './Component'
import { Host } from './Host'
import { Label } from './Label'
import { NavigationBarBackButton } from './NavigationBarBackButton'
import { NavigationBarButton } from './NavigationBarButton'
import { Slot } from './Slot'
import './NavigationBar.ds'
import './NavigationBar.ds.android'
import './NavigationBar.ds.ios'

/**
 * The internal references.
 * @interface Refs
 * @since 0.7.0
 */
export interface Refs {
	title: Label
	titleContainer: View
}

/**
 * The internal slots.
 * @interface Slots
 * @since 0.7.0
 */
export interface Slots {
	backButton: NavigationBar.BackButton
	mainButtons: NavigationBar.MainButtons
	sideButtons: NavigationBar.SideButtons
}

/**
 * Displays a bar with a title and navigations components.
 * @class NavigationBar
 * @super Component
 * @since 0.1.0
 */
export class NavigationBar extends Component<Refs, Slots> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The navigation bar's title.
	 * @property title
	 * @since 0.1.0
	 */
	public get title(): Label {
		return this.refs.title
	}

	/**
	 * The navigation bar's primary buttons.
	 * @property primaryButtons
	 * @since 0.4.0
	 */
	public get mainButtons(): NavigationBar.MainButtons {
		return this.slots.mainButtons
	}

	/**
	 * The navigation bar's buttons on the opposite side of the main buttons.
	 * @property sideButtons
	 * @since 0.4.0
	 */
	public get sideButtons(): NavigationBar.SideButtons {
		return this.slots.sideButtons
	}

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
				<View style="buttons-container">
					<NavigationBar.BackButton for={this} />
					<NavigationBar.SideButtons for={this} />
				</View>
				<View for={this} id="titleContainer" style="title-container" onBeforeLayout={this.onTitleContainerBeforeLayout}>
					<Label for={this} id="title" style="title" />
				</View>
				<View style="buttons-container">
					<NavigationBar.MainButtons for={this} main={true} />
				</View>
			</Host>
		)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method onTitleContainerBeforeLayout
	 * @since 0.1.0
	 * @hidden
	 */
	@bound private onTitleContainerBeforeLayout(event: Event) {

		if (this.title == null) {
			return
		}

		let titleContainer = this.refs.titleContainer
		if (titleContainer == null) {
			return
		}

		let disposition = titleContainer.contentLocation
		let orientation = titleContainer.contentOrientation

		if (disposition !== 'center' ||
			orientation !== 'horizontal') {
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

		this.title.measure()

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
	}
}

/**
 * @module NavigationBar
 * @since 0.7.0
 */
export module NavigationBar {

	/**
	 * @class BackButton
	 * @super Slot
	 * @since 0.7.0
	 */
	export class BackButton extends Slot {

		/**
		 * @inherited
		 * @property name
		 * @since 0.7.0
		 */
		public get name(): string {
			return 'back-button'
		}
	}

	/**
	 * @class MainButtons
	 * @super Slot
	 * @since 0.7.0
	 */
	export class MainButtons extends Slot {

		/**
		 * @inherited
		 * @property name
		 * @since 0.7.0
		 */
		public get name(): string {
			return 'main-buttons'
		}
	}

	/**
	 * @class SideButtons
	 * @super Slot
	 * @since 0.7.0
	 */
	export class SideButtons extends Slot {

		/**
		 * @inherited
		 * @property name
		 * @since 0.7.0
		 */
		public get name(): string {
			return 'side-buttons'
		}
	}
}
