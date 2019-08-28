/**
 * The window class.
 * @class JavaScriptWindow
 * @since 0.7.0
 */
open class JavaScriptWindow: JavaScriptView {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Removes the window.
	 * @method remove
	 * @since 0.7.0
	 */
	open func remove() {
		self.wrapper.removeFromSuperview()
	}

	/**
	 * Finds a view from this window's hierarchy at the specified point.
	 * @method viewFromPoint
	 * @since 0.7.0
	 */
	open func viewFromPoint(x: Double, y: Double, visible: Bool = true, touchable: Bool = true) -> JavaScriptView? {
		return self.findViewAt(point: Point3D(x: x, y: y, z: 0.0), matrix: Transform3D(), visible: visible, touchable: touchable)
	}

	//--------------------------------------------------------------------------
	// JavaScript Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_viewFromPoint
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_viewFromPoint(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 4) {
			fatalError("Method JavaScriptWindow.viewFromPoint() requires 4 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number
		let v = callback.argument(2).boolean
		let t = callback.argument(3).boolean

		if let view = self.viewFromPoint(x: x, y: y, visible: v, touchable: t) {
			callback.returns(view)
		}
	}
}
