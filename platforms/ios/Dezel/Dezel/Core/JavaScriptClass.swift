/**
 * The base class for bridged classes.
 * @class JavaScriptClass
 * @since 0.1.0
 */
open class JavaScriptClass: JavaScriptObject {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property instance
	 * @since 0.7.0
	 * @hidden
	 */
	private var instance: JavaScriptValue?

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method call
	 * @since 0.7.0
	 */
	override open func call() {

		if let instance = self.instance {
			instance.call()
			return
		}

		super.call()
	}

	/**
	 * @inherited
	 * @method call
	 * @since 0.7.0
	 */
	override open func call(_ arguments: JavaScriptArguments?, target: JavaScriptValue?, result: JavaScriptValue? = nil) {

		if let instance = self.instance {
			instance.call(arguments, target: target, result: result)
			return
		}

		super.call(arguments, target: target, result: result)
	}

	/**
	 * @inherited
	 * @method callMethod
	 * @since 0.7.0
	 */
	override open func callMethod(_ method: String) {

		if let instance = self.instance {
			instance.callMethod(method)
			return
		}

		super.callMethod(method)
	}

	/**
	 * @inherited
	 * @method callMethod
	 * @since 0.7.0
	 */
	override open func callMethod(_ method: String, arguments: JavaScriptArguments?, result: JavaScriptValue? = nil) {

		if let instance = self.instance {
			instance.callMethod(method, arguments: arguments, result: result)
			return
		}

		super.callMethod(method, arguments: arguments, result: result)
	}

	/**
	 * @inherited
	 * @method construct
	 * @since 0.7.0
	 */
	override open func construct() {

		if let instance = self.instance {
			instance.construct()
			return
		}

		super.construct()
	}

	/**
	 * @inherited
	 * @method construct
	 * @since 0.7.0
	 */
	override open func construct(_ arguments: JavaScriptArguments?, result: JavaScriptValue? = nil) {

		if let instance = self.instance {
			instance.construct(arguments, result: result)
			return
		}

		super.construct(arguments, result: result)
	}

	/**
	 * @inherited
	 * @method defineProperty
	 * @since 0.7.0
	 */
	override open func defineProperty(_ property: String, value: JavaScriptValue?, getter: JavaScriptGetterHandler? = nil, setter: JavaScriptSetterHandler? = nil, writable: Bool = true, enumerable: Bool = true, configurable: Bool = true) {

		if let instance = self.instance {

			instance.defineProperty(
				property,
				value: value,
				getter: getter,
				setter: setter,
				writable: writable,
				enumerable: enumerable,
				configurable: configurable
			)

			return
		}

		super.defineProperty(
			property,
			value: value,
			getter: getter,
			setter: setter,
			writable: writable,
			enumerable: enumerable,
			configurable: configurable
		)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ name: String, value: JavaScriptValue?) {

		if let instance = self.instance {
			instance.property(name, value: value)
			return
		}

		super.property(name, value: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ name: String, property: JavaScriptProperty) {

		if let instance = self.instance {
			instance.property(name, property: property)
			return
		}

		super.property(name, property: property)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ name: String, string value: String) {

		if let instance = self.instance {
			instance.property(name, string: value)
			return
		}

		super.property(name, string: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ name: String, number value: Double) {

		if let instance = self.instance {
			instance.property(name, number: value)
			return
		}

		super.property(name, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	override open func property(_ name: String, number value: Float) {

		if let instance = self.instance {
			instance.property(name, number: value)
			return
		}

		super.property(name, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	override open func property(_ name: String, number value: Int) {

		if let instance = self.instance {
			instance.property(name, number: value)
			return
		}

		super.property(name, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	override open func property(_ name: String, number value: CGFloat) {

		if let instance = self.instance {
			instance.property(name, number: value)
			return
		}

		super.property(name, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ name: String, boolean value: Bool) {

		if let instance = self.instance {
			instance.property(name, boolean: value)
			return
		}

		super.property(name, boolean: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ name: String) -> JavaScriptValue {
		return self.instance?.property(name) ?? super.property(name)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ index: Int, value: JavaScriptValue?) {

		if let instance = self.instance {
			instance.property(index, value: value)
			return
		}

		super.property(index, value: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ index: Int, string value: String) {

		if let instance = self.instance {
			instance.property(index, string: value)
			return
		}

		super.property(index, string: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ index: Int, number value: Double) {

		if let instance = self.instance {
			instance.property(index, number: value)
			return
		}

		super.property(index, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	override open func property(_ index: Int, number value: Float) {

		if let instance = self.instance {
			instance.property(index, number: value)
			return
		}

		super.property(index, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	override open func property(_ index: Int, number value: Int) {

		if let instance = self.instance {
			instance.property(index, number: value)
			return
		}

		super.property(index, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	override open func property(_ index: Int, number value: CGFloat) {

		if let instance = self.instance {
			instance.property(index, number: value)
			return
		}

		super.property(index, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ index: Int, boolean value: Bool) {

		if let instance = self.instance {
			instance.property(index, boolean: value)
			return
		}

		super.property(index, boolean: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override open func property(_ index: Int) -> JavaScriptValue {
		return self.instance?.property(index) ?? super.property(index)
	}

	/**
	 * @inherited
	 * @method forEach
	 * @since 0.7.0
	 */
	override open func forEach(_ handler: @escaping JavaScriptForEachHandler) {

		if let instance = self.instance {
			instance.forEach(handler)
			return
		}

		super.forEach(handler)
	}

	/**
	 * @inherited
	 * @method forOwn
	 * @since 0.7.0
	 */
	override open func forOwn(_ handler: @escaping JavaScriptForOwnHandler) {

		if let instance = self.instance {
			instance.forOwn(handler)
			return
		}

		super.forOwn(handler)
	}

	/**
	 * @inherited
	 * @method prototype
	 * @since 0.7.0
	 */
	override open func prototype(_ prototype: JavaScriptValue) {

		if let instance = self.instance {
			instance.prototype(prototype)
			return
		}

		super.prototype(prototype)
	}

	/**
	 * @inherited
	 * @method prototype
	 * @since 0.7.0
	 */
	override open func prototype() -> JavaScriptValue {
		return self.instance?.prototype() ?? super.prototype()
	}

	/**
	 * Called when the value gets protected.
	 * @method didProtectValue
	 * @since 0.4.0
	 */
	override open func didProtectValue() {

		/*
		 * When protecting an object from being collected, we also want to
		 * make sure its holder does not get collected.
		 */

		self.instance?.protect()
	}

	/**
	 * Called when the value gets unprotected.
	 * @method didUnprotectValue
	 * @since 0.4.0
	 */
	override open func didUnprotectValue() {

		/*
		 * When protecting an object from being collected, we also want to
		 * make sure its holder does not get collected.
		 */

		self.instance?.unprotect()
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
     * Default constructor implementation.
     * @method jsFunction_constructor
     * @since 0.1.0
     */
	@objc open func jsFunction_constructor(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {

			/*
			 * It's possible this class does not have a native JavaScript
			 * wrapper class. In this case all class related method will
			 * be called on this very instance instead.
			 */

			return
		 }

		self.instance = callback.argument(0)
		self.instance?.unprotect()
	}

	//--------------------------------------------------------------------------
	// MARK: Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method toHandle
	 * @since 0.7.0
	 * @hidden
	 */
	override open func toHandle(_ context: JavaScriptContext) -> JSValueRef {
		return self.instance?.toHandle(context) ?? super.toHandle(context)
	}
}
