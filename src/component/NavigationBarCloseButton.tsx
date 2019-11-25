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
	public slot: string = 'main'
}
