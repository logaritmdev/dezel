import { NavigationBarButton } from './NavigationBarButton'
import './style/NavigationBarCloseButton.style'
import './style/NavigationBarCloseButton.style.android'
import './style/NavigationBarCloseButton.style.ios'

/**
 * @class NavigationBarCloseButton
 * @super NavigationBarButton
 * @since 0.1.0
 */
export class NavigationBarCloseButton extends NavigationBarButton {

	/**
	 * The default slot whereh this button will be added.
	 * @property slot
	 * @since 0.7.0
	 */
	public slot: string = 'main'
}
