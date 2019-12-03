/**
 * @extension JavaScriptProperty
 * @since 0.7.0
 * @hidden
 */
internal extension JavaScriptProperty {

	/**
	 * @method reset
	 * @since 0.7.0
	 * @hidden
	 */
	func reset(_ value: Double, unit: ValueUnit, lock: AnyObject? = nil) {

		switch (unit) {

			case kValueUnitNone:
				self.reset(value, unit: .none, lock: lock)
			case kValueUnitPX:
				self.reset(value, unit: .px, lock: lock)
			case kValueUnitPC:
				self.reset(value, unit: .pc, lock: lock)
			case kValueUnitVW:
				self.reset(value, unit: .vw, lock: lock)
			case kValueUnitVH:
				self.reset(value, unit: .vh, lock: lock)
			case kValueUnitPW:
				self.reset(value, unit: .pw, lock: lock)
			case kValueUnitPH:
				self.reset(value, unit: .ph, lock: lock)
			case kValueUnitCW:
				self.reset(value, unit: .cw, lock: lock)
			case kValueUnitCH:
				self.reset(value, unit: .ch, lock: lock)
			case kValueUnitDeg:
				self.reset(value, unit: .deg, lock: lock)
			case kValueUnitRad:
				self.reset(value, unit: .rad, lock: lock)

			default:
				self.reset(value, unit: .none, lock: lock)
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	func reset(_ values: ValueListRef, lock: AnyObject? = nil) {

	}

	/**
	 * @method resetWithNull
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithNull() {
		self.reset()
	}

	/**
	 * @method resetWithString
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithString(_ ptr: ValueRef) {
		self.reset(ValueGetString(ptr).string)
	}

	/**
	 * @method resetWithNumber
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithNumber(_ ptr: ValueRef) {

		switch (ValueGetUnit(ptr)) {

			case kValueUnitNone:
				self.reset(ValueGetNumber(ptr), unit: .none)
			case kValueUnitPX:
				self.reset(ValueGetNumber(ptr), unit: .px)
			case kValueUnitPC:
				self.reset(ValueGetNumber(ptr), unit: .pc)
			case kValueUnitVW:
				self.reset(ValueGetNumber(ptr), unit: .vw)
			case kValueUnitVH:
				self.reset(ValueGetNumber(ptr), unit: .vh)
			case kValueUnitPW:
				self.reset(ValueGetNumber(ptr), unit: .pw)
			case kValueUnitPH:
				self.reset(ValueGetNumber(ptr), unit: .ph)
			case kValueUnitCW:
				self.reset(ValueGetNumber(ptr), unit: .cw)
			case kValueUnitCH:
				self.reset(ValueGetNumber(ptr), unit: .ch)
			case kValueUnitDeg:
				self.reset(ValueGetNumber(ptr), unit: .deg)
			case kValueUnitRad:
				self.reset(ValueGetNumber(ptr), unit: .rad)

			default:
				self.reset(ValueGetNumber(ptr), unit: .none)
		}
	}

	/**
	 * @method resetWithBoolean
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithBoolean(_ ptr: ValueRef) {
		self.reset(ValueGetBoolean(ptr))
	}

	/**
	 * @method resetWithVariable
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithVariable(_ ptr: ValueRef) {
		self.reset(self.createVariable(ptr))
	}

	/**
	 * @method resetWithFunction
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithFunction(_ ptr: ValueRef) {
		self.reset(self.createFunction(ptr))
	}

	/**
	 * @method createString
	 * @since 0.7.0
	 * @hidden
	 */
	func createString(_ ptr: ValueRef) -> JavaScriptPropertyStringValue {
		return JavaScriptPropertyStringValue(value: ValueGetString(ptr).string)
	}

	/**
	 * @method createNumber
	 * @since 0.7.0
	 * @hidden
	 */
	func createNumber(_ ptr: ValueRef) -> JavaScriptPropertyNumberValue {
		return JavaScriptPropertyNumberValue(value: ValueGetNumber(ptr), unit: ValueGetUnit(ptr))
	}

	/**
	 * @method createBoolean
	 * @since 0.7.0
	 * @hidden
	 */
	func createBoolean(_ ptr: ValueRef) -> JavaScriptPropertyBooleanValue {
		return JavaScriptPropertyBooleanValue(value: ValueGetBoolean(ptr))
	}

	/**
	 * @method createVariable
	 * @since 0.7.0
	 * @hidden
	 */
	func createVariable(_ ptr: VariableValueRef) -> JavaScriptPropertyVariableValue {
		fatalError("Not supported yet")
	}

	/**
	 * @method createFunction
	 * @since 0.7.0
	 * @hidden
	 */
	func createFunction(_ ptr: FunctionValueRef) -> JavaScriptPropertyFunctionValue {

		guard let name = FunctionValueGetName(ptr) else {
			fatalError()
		}

		var arguments = [JavaScriptPropertyValue]()

		for i in 0 ..< FunctionValueGetArgumentCount(ptr) {

			guard let value = FunctionValueGetArgumentValue(ptr, i) else {
				continue
			}

			switch (ValueGetType(value)) {

				case kValueTypeNull:
					arguments.append(JavaScriptProperty.Null)
				case kValueTypeString:
					arguments.append(self.createString(value))
				case kValueTypeNumber:
					arguments.append(self.createNumber(value))
				case kValueTypeBoolean:
					arguments.append(self.createBoolean(value))
				case kValueTypeVariable:
					arguments.append(self.createVariable(value))
				case kValueTypeFunction:
					arguments.append(self.createFunction(value))

				default:
					break
			}
		}

		return JavaScriptPropertyFunctionValue(name: name.string, arguments: arguments)
	}
}
