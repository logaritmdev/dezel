/**
 * @extension JavaScriptContext
 * @since 0.7.0
 * @hidden
 */
public extension JavaScriptContext {

	/**
	 * @property container
	 * @since 0.7.0
	 * @hidden
	 */
	var application: ApplicationController {
		return self.attribute(kApplicationControllerKey) as! ApplicationController
	}

	/**
	 * @method createObject
	 * @since 0.7.0
	 * @hidden
	 */
	func createObject(_ dictionary: [String: String]) -> JavaScriptValue {

		let result = self.createEmptyObject()

		for (key, val) in dictionary {
			result.property(key, value: self.createString(val))
		}

		return result
	}

	/**
	 * @method createObject
	 * @since 0.7.0
	 * @hidden
	 */
	func createObject(_ dictionary: [String: Double]) -> JavaScriptValue {

		let result = self.createEmptyObject()

		for (key, val) in dictionary {
			result.property(key, value: self.createNumber(val))
		}

		return result
	}

	/**
	 * @method createString
	 * @since 0.7.0
	 * @hidden
	 */
	func createString(_ url: URL) -> JavaScriptValue {
		return self.createString(url.absoluteString)
	}
}

