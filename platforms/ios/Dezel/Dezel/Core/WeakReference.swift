/**
 * @class WeakReference
 * @since 0.6.0
 * @hidden
 */
public class WeakReference<T: NSObject> {

	/**
	 * @property value
	 * @since 0.6.0
	 * @hidden
	 */
	private(set) public weak var value: T?

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(value: T?) {
		self.value = value
	}
}
