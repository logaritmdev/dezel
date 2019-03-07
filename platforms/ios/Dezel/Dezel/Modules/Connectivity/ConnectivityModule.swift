/**
 * @class ConnectivityModule
 * @since 0.1.0
 * @hidden
 */
public class ConnectivityModule : Module {

    /**
     * @inherited
     * @method initialize
     * @since 0.1.0
     */
	public override func initialize() {
		self.context.registerClass("dezel.connectivity.ConnectivityManager", type: ConnectivityManager.self)
	}
}
