/**
 * The protocol that defines the function to execute when an update occurs.
 * @protocol SynchronizerCallback
 * @since 0.7.0
 */
public protocol SynchronizerCallback : class {
	func performUpdate()
}
