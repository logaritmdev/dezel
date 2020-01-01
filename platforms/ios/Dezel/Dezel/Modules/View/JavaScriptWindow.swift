/**
 * @class JavaScriptWindow
 * @super JavaScriptView
 * @since 0.7.0
 */
open class JavaScriptWindow: JavaScriptView {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method remove
	 * @since 0.7.0
	 */
	open func remove() {
		self.wrapper.removeFromSuperview()
	}

	/**
	 * @method findViewAt
	 * @since 0.7.0
	 */
	open func findViewAt(x: Double, y: Double, visible: Bool = true, touchable: Bool = true) -> JavaScriptView? {
		return self.findViewAt(point: Point3D(x: x, y: y, z: 0.0), matrix: Transform3D(), visible: visible, touchable: touchable)
	}

	//--------------------------------------------------------------------------
	// JavaScript Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_findViewAt
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_findViewAt(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 4) {
			fatalError("Method JavaScriptWindow.findViewAt() requires 4 arguments.")
		}

		let x = callback.argument(0).number
		let y = callback.argument(1).number
		let v = callback.argument(2).boolean
		let t = callback.argument(3).boolean

		if let view = self.findViewAt(point: Point3D(x: x, y: y, z: 0.0), matrix: Transform3D(), visible: v, touchable: t) {
			callback.returns(view)
		}
	}
}
