package ca.logaritm.dezel.modules.view


import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.extension.removeFromParent
import ca.logaritm.dezel.view.geom.Point3D
import ca.logaritm.dezel.view.geom.Transform3D


/**
 * The root view.
 * @class JavaScriptWindow
 * @since 0.7.0
 */
open class JavaScriptWindow(context: JavaScriptContext): JavaScriptView(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {

	}

	/**
	 * Removes the root.
	 * @method remove
	 * @since 0.7.0
	 */
	public fun remove() {
		this.wrapper.removeFromParent()
	}

	/**
	 * Finds a view from this window's hierarchy at the specified point.
	 * @method viewFromPoint
	 * @since 0.7.0
	 */
	open fun viewFromPoint(x: Double, y: Double, visible: Boolean = true, touchable: Boolean = true): JavaScriptView? {
		return this.findViewAt(Point3D(x, y, 0.0), Transform3D(), visible, touchable)
	}

	//--------------------------------------------------------------------------
	// JavaScript Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_viewFromPoint
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_viewFromPoint(callback: JavaScriptFunctionCallback) {

		val x = callback.argument(0).number
		val y = callback.argument(1).number
		val v = callback.argument(2).boolean
		val t = callback.argument(3).boolean

		val view = this.viewFromPoint(x, y, v, t)
		if (view == null) {
			return
		}

		callback.returns(view.holder)
	}
}