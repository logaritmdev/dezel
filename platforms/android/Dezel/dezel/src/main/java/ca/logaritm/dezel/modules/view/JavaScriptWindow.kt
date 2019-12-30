package ca.logaritm.dezel.modules.view


import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.extension.fatalError
import ca.logaritm.dezel.extension.view.removeFromParent
import ca.logaritm.dezel.view.geom.Point3D
import ca.logaritm.dezel.view.geom.Transform3D

/**
 * @class JavaScriptWindow
 * @super JavaScriptView
 * @since 0.7.0
 */
open class JavaScriptWindow(context: JavaScriptContext): JavaScriptView(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method remove
	 * @since 0.7.0
	 */
	public fun remove() {
		this.wrapper.removeFromParent()
	}

	/**
	 * @method findViewAt
	 * @since 0.7.0
	 */
	open fun findViewAt(x: Double, y: Double, visible: Boolean = true, touchable: Boolean = true): JavaScriptView? {
		// TODO
		// est-ce que je peux enlever ça
		return this.findViewAt(Point3D(x, y, 0.0), Transform3D(), visible, touchable)
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_findViewAt
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_findViewAt(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 4) {
			fatalError("Method JavaScriptWindow.findViewAt() requires 4 arguments.")
		}

		val x = callback.argument(0).number
		val y = callback.argument(1).number
		val v = callback.argument(2).boolean
		val t = callback.argument(3).boolean

		val view = this.findViewAt(x, y, v, t)
		if (view == null) {
			return
		}

		callback.returns(view)
	}
}