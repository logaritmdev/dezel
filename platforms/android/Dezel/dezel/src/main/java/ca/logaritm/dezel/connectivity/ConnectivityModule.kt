package ca.logaritm.dezel.connectivity

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class ConnectivityModule
 * @since 0.1.0
 */
public class ConnectivityModule(context: JavaScriptContext) : Module(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	public override fun initialize() {
		this.context.registerClass("dezel.connectivity.ConnectivityManager", ConnectivityManager::class.java)
	}
}
