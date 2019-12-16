import { NavigationBarButton } from './NavigationBarButton'
import './style/NavigationBarBackButton.style'
import './style/NavigationBarBackButton.style.android'
import './style/NavigationBarBackButton.style.ios'

/**
 * @class NavigationBarBackButton
 * @super NavigationBarButton
 * @since 0.1.0
 */
export class NavigationBarBackButton extends NavigationBarButton {

	/**
	 * The default slot whereh this button will be added.
	 * @property slot
	 * @since 0.7.0
	 */
	public slot: string = 'back'
}