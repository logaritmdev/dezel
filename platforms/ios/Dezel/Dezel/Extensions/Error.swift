/**
 * @extension JavaScriptContext
 * @since 0.7.0
 * @hidden
 */
internal extension JavaScriptContext {

	/**
	 * @method createObject
	 * @since 0.7.0
	 * @hidden
	 */
	func createObject(_ error: Error) -> JavaScriptValue {
		let result = self.createEmptyObject()
		result.property("message", string: error.localizedDescription)
		return result
	}
}
