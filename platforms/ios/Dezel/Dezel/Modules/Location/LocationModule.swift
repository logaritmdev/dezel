/**
 * @class LocationModule
 * @since 0.1.0
 */
open class LocationModule : Module {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override open func initialize() {
		self.context.registerClass("dezel.location.LocationManager", type: LocationManager.self)
	}
}
