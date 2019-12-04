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

		let count = ValueListGetCount(values)

		if (count == 1) {

			guard let value = ValueListGetValue(values, 0) else {
				return
			}

			switch (ValueGetType(value)) {

				case kValueTypeNull:
					self.resetWithNull(lock: lock)
				case kValueTypeString:
					self.resetWithString(value, lock: lock)
				case kValueTypeNumber:
					self.resetWithNumber(value, lock: lock)
				case kValueTypeBoolean:
					self.resetWithBoolean(value, lock: lock)
				case kValueTypeVariable:
					self.resetWithVariable(value, lock: lock)
				case kValueTypeFunction:
					self.resetWithFunction(value, lock: lock)

				default:
					break;
			}

			return
		}

		/*
		 * The parser returned multiple values. In this case we create a
		 * composite value and reset the property with it.
		 */

		var components = [JavaScriptPropertyValue]()

		for i in 0 ..< count {

			guard let value = ValueListGetValue(values, i) else {
				continue
			}

			switch (ValueGetType(value)) {

				case kValueTypeNull:
					components.append(JavaScriptProperty.Null)
				case kValueTypeString:
					components.append(self.createString(value))
				case kValueTypeNumber:
					components.append(self.createNumber(value))
				case kValueTypeBoolean:
					components.append(self.createBoolean(value))
				case kValueTypeVariable:
					components.append(self.createVariable(value))
				case kValueTypeFunction:
					components.append(self.createFunction(value))

				default:
					break
			}
		}

		self.reset(JavaScriptPropertyCompositeValue(values: components), lock: lock)
	}

	/**
	 * @method resetWithNull
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithNull(lock: AnyObject? = nil) {
		self.reset(lock: lock)
	}

	/**
	 * @method resetWithString
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithString(_ ptr: ValueRef, lock: AnyObject? = nil) {
		self.reset(ValueGetString(ptr).string, lock: lock)
	}

	/**
	 * @method resetWithNumber
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithNumber(_ ptr: ValueRef, lock: AnyObject? = nil) {

		switch (ValueGetUnit(ptr)) {

			case kValueUnitNone:
				self.reset(ValueGetNumber(ptr), unit: .none, lock: lock)
			case kValueUnitPX:
				self.reset(ValueGetNumber(ptr), unit: .px, lock: lock)
			case kValueUnitPC:
				self.reset(ValueGetNumber(ptr), unit: .pc, lock: lock)
			case kValueUnitVW:
				self.reset(ValueGetNumber(ptr), unit: .vw, lock: lock)
			case kValueUnitVH:
				self.reset(ValueGetNumber(ptr), unit: .vh, lock: lock)
			case kValueUnitPW:
				self.reset(ValueGetNumber(ptr), unit: .pw, lock: lock)
			case kValueUnitPH:
				self.reset(ValueGetNumber(ptr), unit: .ph, lock: lock)
			case kValueUnitCW:
				self.reset(ValueGetNumber(ptr), unit: .cw, lock: lock)
			case kValueUnitCH:
				self.reset(ValueGetNumber(ptr), unit: .ch, lock: lock)
			case kValueUnitDeg:
				self.reset(ValueGetNumber(ptr), unit: .deg, lock: lock)
			case kValueUnitRad:
				self.reset(ValueGetNumber(ptr), unit: .rad, lock: lock)

			default:
				self.reset(ValueGetNumber(ptr), unit: .none, lock: lock)
		}
	}

	/**
	 * @method resetWithBoolean
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithBoolean(_ ptr: ValueRef, lock: AnyObject? = nil) {
		self.reset(ValueGetBoolean(ptr), lock: lock)
	}

	/**
	 * @method resetWithVariable
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithVariable(_ ptr: ValueRef, lock: AnyObject? = nil) {
		self.reset(self.createVariable(ptr), lock: lock)
	}

	/**
	 * @method resetWithFunction
	 * @since 0.7.0
	 * @hidden
	 */
	func resetWithFunction(_ ptr: ValueRef, lock: AnyObject? = nil) {
		self.reset(self.createFunction(ptr), lock: lock)
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
