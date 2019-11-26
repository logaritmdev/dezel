import Foundation

/**
 * @protocol DisplayNodeDelegate
 * @since 0.7.0
 */
public protocol DisplayNodeDelegate: AnyObject {

	/**
	 * @method didInvalidate
	 * @since 0.7.0
	 */
	func didInvalidate(node: DisplayNode)

	/**
	 * @method didResolveSize
	 * @since 0.7.0
	 */
	func didResolveSize(node: DisplayNode)

	/**
	 * @method didResolveOrigin
	 * @since 0.7.0
	 */
	func didResolveOrigin(node: DisplayNode)

	/**
	 * @method didResolveInnerSize
	 * @since 0.7.0
	 */
	func didResolveInnerSize(node: DisplayNode)

	/**
	 * @method didResolveContentSize
	 * @since 0.7.0
	 */
	func didResolveContentSize(node: DisplayNode)

	/**
	 * @method didResolveMargin
	 * @since 0.7.0
	 */
	func didResolveMargin(node: DisplayNode)

	/**
	 * @method didResolveBorder
	 * @since 0.7.0
	 */
	func didResolveBorder(node: DisplayNode)

	/**
	 * @method didResolvePadding
	 * @since 0.7.0
	 */
	func didResolvePadding(node: DisplayNode)

	/**
	 * @method didPrepareLayout
	 * @since 0.7.0
	 */
	func didPrepareLayout(node: DisplayNode)

	/**
	 * @method didResolveLayout
	 * @since 0.7.0
	 */
	func didResolveLayout(node: DisplayNode)

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	func measure(node: DisplayNode, in: CGSize, min: CGSize, max: CGSize) -> CGSize?

	/**
	 * @method getProperty
	 * @since 0.7.0
	 */
	func getProperty(_ name: String) -> JavaScriptProperty?

	/**
	 * @method setProperty
	 * @since 0.7.0
	 */
	func setProperty(_ name: String, value: JavaScriptProperty)

}
