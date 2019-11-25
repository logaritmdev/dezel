/**
 * @class JavaScriptCoreUtil
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptCoreUtil: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @property importClass
	 * @since 0.7.0
	 * @hidden
	 */
	private func importClass(callback: JavaScriptFunctionCallback) {
		if let result = self.context.classes[callback.argument(0).string] {
			callback.returns(result)
		}
	}

	/**
	 * @property importObject
	 * @since 0.7.0
	 * @hidden
	 */
	private func importObject(callback: JavaScriptFunctionCallback) {
		if let result = self.context.objects[callback.argument(0).string] {
			callback.returns(result)
		}
	}

	/**
	 * @property registerApplication
	 * @since 0.7.0
	 * @hidden
	 */
	private func registerApplication(callback: JavaScriptFunctionCallback) {
		if let application = callback.argument(0).cast(JavaScriptApplication.self) {
			self.context.controller.register(application)
		}
	}
}
