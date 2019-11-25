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
	public slot: string = 'back'
}