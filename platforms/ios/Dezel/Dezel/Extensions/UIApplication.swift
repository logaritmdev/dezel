/**
 * @extension UIApplication
 * @since 0.7.0
 * @hidden
 */
internal extension UIApplication {

	/**
	 * @property window
	 * @since 0.7.0
	 * @hidden
	 */
	var window: ApplicationWindow? {
		return UIApplication.shared.keyWindow as? ApplicationWindow
	}
}
