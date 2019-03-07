import { clamp } from 'lodash'
import { bound } from '../decorator/bound'
import { ref } from '../decorator/ref'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { Fragment } from '../view/Fragment'
import { TextView } from '../view/TextView'
import { View } from '../view/View'
import { Component } from './Component'
import './NavigationBar.ds.android'
import './NavigationBar.ds.ios'
import { NavigationBarBackButton } from './NavigationBarBackButton'
import { NavigationBarButton } from './NavigationBarButton'
import './NavigationBar.ds'


/**
 * Displays a bar with a title and navigations components.
 * @class NavigationBar
 * @super Component
 * @since 0.1.0
 */
export class NavigationBar extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The navigation bar's title.
	 * @property title
	 * @since 0.1.0
	 */
	@ref public title!: TextView

	/**
	 * The navigation bar's primary button.
	 * @property mainButton
	 * @since 0.4.0
	 */
	public get mainButton(): NavigationBarButton | null {
		return this.mainButtons[0]
	}

	/**
	 * The navigation bar's primary button.
	 * @property mainButton
	 * @since 0.4.0
	 */
	public set mainButton(value: NavigationBarButton | null) {
		this.replaceMainButton(value)
	}

	/**
	 * The navigation bar's button on the opposite side of the main button.
	 * @property sideButton
	 * @since 0.4.0
	 */
	public get sideButton(): NavigationBarButton | null {
		return this.sideButtons[0]
	}

	/**
	 * The navigation bar's button on the opposite side of the main button.
	 * @property sideButton
	 * @since 0.4.0
	 */
	public set sideButton(value: NavigationBarButton | null) {
		this.replaceSideButton(value)
	}

	/**
	 * The navigation bar's back button.
	 * @property backButton
	 * @since 0.4.0
	 */
	public get backButton(): NavigationBarBackButton | null {

		let backButton = this.sideButtons[0]
		if (backButton instanceof NavigationBarBackButton) {
			return backButton
		}

		return null
	}

	/**
	 * The navigation bar's back button.
	 * @property backButton
	 * @since 0.4.0
	 */
	public set backButton(value: NavigationBarBackButton | null) {
		this.replaceBackButton(value)
	}

	/**
	 * The navigation bar's primary buttons.
	 * @property primaryButtons
	 * @since 0.4.0
	 */
	@watch public mainButtons: Array<NavigationBarButton> = []

	/**
	 * The navigation bar's buttons on the opposite side of the main buttons.
	 * @property sideButtons
	 * @since 0.4.0
	 */
	@watch public sideButtons: Array<NavigationBarButton> = []

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
				<View id="titleContainer" style="title-container" onBeforeLayout={this.onTitleContainerBeforeLayout}>
					<TextView id="title" style="title" />
				</View>
			</Fragment>
		)
	}

	/**
	 * @inherited
	 * @method onCreate
	 * @since 0.4.0
	 */
	public onCreate() {

		super.onCreate()

		let sideButtonContainer = <View id="sideButtonsContainer" style="buttons-container" />
		let mainButtonContainer = <View id="mainButtonsContainer" style="buttons-container" />

		if (locale.ltr) {
			this.insert(sideButtonContainer, 0)
			this.append(mainButtonContainer)
			return
		}

		if (locale.rtl) {
			this.insert(mainButtonContainer, 0)
			this.append(sideButtonContainer)
			return
		}
	}

	/**
	 * @inherited
	 * @method onPropertyChange
	 * @since 0.4.0
	 */
	public onPropertyChange(property: string, newValue: any, oldValue: any) {

		if (property == 'mainButtons') {

			let newButtons = newValue as Array<NavigationBarButton>
			let oldButtons = oldValue as Array<NavigationBarButton>
			if (oldButtons) for (let i = 0; i < oldButtons.length; i++) this.removeMainButton(oldButtons[i])
			if (newButtons) for (let i = 0; i < newButtons.length; i++) this.appendMainButton(newButtons[i])

			return
		}

		if (property == 'sideButtons') {

			let newButtons = newValue as Array<NavigationBarButton>
			let oldButtons = oldValue as Array<NavigationBarButton>
			if (oldButtons) for (let i = 0; i < oldButtons.length; i++) this.removeSideButton(oldButtons[i])
			if (newButtons) for (let i = 0; i < newButtons.length; i++) this.appendSideButton(newButtons[i])

			return
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property titleContainer
	 * @since 0.4.0
	 * @hidden
	 */
	@ref private titleContainer!: View

	/**
	 * @property mainButtonsContainer
	 * @since 0.4.0
	 * @hidden
	 */
	@ref private mainButtonsContainer!: View

	/**
	 * @property sideButtonsContainer
	 * @since 0.4.0
	 * @hidden
	 */
	@ref private sideButtonsContainer!: View

	/**
	 * @method onTitleContainerBeforeLayout
	 * @since 0.1.0
	 * @hidden
	 */
	@bound private onTitleContainerBeforeLayout(event: Event) {

		if (this.title == null) {
			return
		}

		let disposition = this.titleContainer.contentDisposition
		let orientation = this.titleContainer.contentOrientation

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

		let frameL = this.titleContainer.measuredLeft
		let frameW = this.titleContainer.measuredInnerWidth
		let frameH = this.titleContainer.measuredInnerHeight
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

	/**
	 * @method onTitleContainerBeforeLayout
	 * @since 0.4.0
	 * @hidden
	 */
	private replaceMainButton(button: NavigationBarButton | null) {

		let buttons = this.mainButtons.slice(0)

		if (button == null) {
			buttons.shift()
		} else {
			buttons.unshift(button)
		}

		this.mainButtons = buttons

		return this
	}

	/**
	 * @method onTitleContainerBeforeLayout
	 * @since 0.4.0
	 * @hidden
	 */
	private replaceSideButton(button: NavigationBarButton | null) {

		let buttons = this.sideButtons.slice(0)

		if (button == null) {
			buttons.shift()
		} else {
			buttons.unshift(button)
		}

		this.sideButtons = buttons

		return this
	}

	/**
	 * @method replaceBackButton
	 * @since 0.4.0
	 * @hidden
	 */
	private replaceBackButton(button: NavigationBarBackButton | null) {

		let buttons = this.sideButtons.slice(0)

		if (button == null) {

			let currentBackButton = this.backButton
			if (currentBackButton) {
				buttons.shift()
			}

		} else {

			let currentBackButton = this.backButton
			if (currentBackButton) {
				buttons.pop()
			}

			buttons.unshift(button)
		}

		this.sideButtons = buttons

		return this
	}

	/**
	 * @method appendMainButton
	 * @since 0.4.0
	 * @hidden
	 */
	private appendMainButton(button: NavigationBarButton) {
		this.mainButtonsContainer.append(button)
		return this
	}

	/**
	 * @method removeMainButton
	 * @since 0.4.0
	 * @hidden
	 */
	private removeMainButton(button: NavigationBarButton) {
		this.mainButtonsContainer.remove(button)
		return this
	}

	/**
	 * @method appendSideButton
	 * @since 0.4.0
	 * @hidden
	 */
	private appendSideButton(button: NavigationBarButton) {
		this.sideButtonsContainer.append(button)
		return this
	}

	/**
	 * @method removeSideButton
	 * @since 0.4.0
	 * @hidden
	 */
	private removeSideButton(button: NavigationBarButton) {
		this.sideButtonsContainer.remove(button)
		return this
	}
}