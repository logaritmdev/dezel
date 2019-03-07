/**
 * Provides the methods to manage a view that needs to perform an action during the update pass.
 * @protocol Updatable
 * @since 0.2.0
 */
public protocol Updatable: AnyObject {
	func update()
}
