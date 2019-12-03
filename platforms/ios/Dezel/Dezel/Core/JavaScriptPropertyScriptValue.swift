/**
 * @class JavaScriptPropertyScriptValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyScriptValue : JavaScriptPropertyValue {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(value: JavaScriptValue) {

		/*
		 * The value was parsed before being assigned here,
		 * there is no need to parse it again.
		 */

		let type: JavaScriptPropertyType

		switch (true) {

			case value.isNull:
				type = .null
			case value.isUndefined:
				type = .null
			case value.isString:
				type = .string
			case value.isNumber:
				type = .number
			case value.isBoolean:
				type = .boolean
			case value.isObject:
				type = .object
			case value.isArray:
				type = .array
			case value.isFunction:
				type = .callback

			default:
				type = .null
		}

		super.init(type: type, unit: .none, value: value)
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override open func toString() -> String {
		return self.value!.string
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override open func toNumber() -> Double {
		return self.value!.number
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override open func toBoolean() -> Bool {
		return self.value!.boolean
	}
}
