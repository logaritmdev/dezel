/**
 * @class Dezel
 * @since 0.1.0
 */
open class Dezel : JavaScriptObject {

	// TODO
	// Refactor into smaller bits

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_log
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_log(callback: JavaScriptFunctionCallback) {

		let count = callback.arguments
		if (count == 0) {
			return
		}

		var string = ""

		for i in 0 ... count - 1 {
			string.append(callback.argument(i).string)
			string.append(" ")
		}

		NSLog("Log: \(string)")
	}

	/**
	 * @method jsFunction_imports
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_imports(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Function dezel.imports needs 1 argument.")
		}

		let ident = callback.argument(0).string

		if let value = self.context.objects[ident] {
			callback.returns(value)
			return
		}

		if let value = self.context.classes[ident] {
			callback.returns(value)
			return
		}

		NSLog("Unable to import %@", ident)
	}

	/**
	 * @method jsFunction_throwError
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_throwError(callback: JavaScriptFunctionCallback) {

		let count = callback.arguments
		if (count < 1) {
			return
		}

		DLContextHandleError(self.context.handle, callback.argument(0).handle)
	}

	/**
	 * @method jsFunction_transition
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_transition(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 8) {
			return
		}

		let duration = callback.argument(0).number / 1000
		let equation = CAMediaTimingFunction(controlPoints:
			Float(callback.argument(1).number),
			Float(callback.argument(2).number),
			Float(callback.argument(3).number),
			Float(callback.argument(4).number)
		)

		let delay = callback.argument(5).number / 1000.0

		let complete = callback.argument(6)
		let function = callback.argument(7)

		let animate = {

			Transition.create(
				duration: duration,
				equation: equation,
				delay: delay
			) {
				complete.call()
				complete.unprotect()
			}

			function.call()
			complete.protect()

			Transition.commit()
		}

		if let application = self.context.application {
			if (application.layout.resolving) {
				application.layout.requestLayoutEndedCallback(animate)
				return
			}
		}

		animate()
	}

	/**
	 * @method jsFunction_reload
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_reload(callback: JavaScriptFunctionCallback) {
		self.context.application.reload()
	}
}
