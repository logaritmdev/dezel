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
	internal var instance: JavaScriptValue?

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method call
	 * @since 0.7.0
	 */
	open override func call() {
		self.instance?.call()
	}

	/**
	 * @inherited
	 * @method call
	 * @since 0.7.0
	 */
	open override func call(_ arguments: JavaScriptArguments?, target: JavaScriptValue?, result: JavaScriptValue? = nil) {
		self.instance?.call(arguments, target: target, result: result)
	}

	/**
	 * @inherited
	 * @method callMethod
	 * @since 0.7.0
	 */
	open override func callMethod(_ method: String) {
		self.instance?.callMethod(method)
	}

	/**
	 * @inherited
	 * @method callMethod
	 * @since 0.7.0
	 */
	open override func callMethod(_ method: String, arguments: JavaScriptArguments?, result: JavaScriptValue? = nil) {
		self.instance?.callMethod(method, arguments: arguments, result: result)
	}

	/**
	 * @inherited
	 * @method construct
	 * @since 0.7.0
	 */
	open override func construct() {
		self.instance?.construct()
	}

	/**
	 * @inherited
	 * @method construct
	 * @since 0.7.0
	 */
	open override func construct(_ arguments: JavaScriptArguments?, result: JavaScriptValue? = nil) {
		self.instance?.construct(arguments, result: result)
	}

	/**
	 * @inherited
	 * @method defineProperty
	 * @since 0.7.0
	 */
	open override func defineProperty(_ property: String, value: JavaScriptValue?, getter: JavaScriptGetterHandler? = nil, setter: JavaScriptSetterHandler? = nil, writable: Bool = true, enumerable: Bool = true, configurable: Bool = true) {
		self.instance?.defineProperty(property, value: value, getter: getter, setter: setter, writable: writable, enumerable: enumerable, configurable: configurable)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ name: String, value: JavaScriptValue?) {
		self.instance?.property(name, value: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ name: String, property: Property) {
		self.instance?.property(name, property: property)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ name: String, string value: String) {
		self.instance?.property(name, string: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ name: String, number value: Double) {
		self.instance?.property(name, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	open override func property(_ name: String, number value: Float) {
		self.instance?.property(name, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	open override func property(_ name: String, number value: Int) {
		self.instance?.property(name, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	open override func property(_ name: String, number value: CGFloat) {
		self.instance?.property(name, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ name: String, boolean value: Bool) {
		self.instance?.property(name, boolean: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ name: String) -> JavaScriptValue {
		return self.instance?.property(name) ?? self.context.jsundefined
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ index: Int, value: JavaScriptValue?) {
		self.instance?.property(index, value: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ index: Int, string value: String) {
		self.instance?.property(index, string: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ index: Int, number value: Double) {
		self.instance?.property(index, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	open override func property(_ index: Int, number value: Float) {
		self.instance?.property(index, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	open override func property(_ index: Int, number value: Int) {
		self.instance?.property(index, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	open override func property(_ index: Int, number value: CGFloat) {
		self.instance?.property(index, number: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ index: Int, boolean value: Bool) {
		self.instance?.property(index, boolean: value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	open override func property(_ index: Int) -> JavaScriptValue {
		return self.instance?.property(index) ?? self.context.jsundefined
	}

	/**
	 * @inherited
	 * @method forEach
	 * @since 0.7.0
	 */
	open override func forEach(_ handler: @escaping JavaScriptForEachHandler) {
		self.instance?.forEach(handler)
	}

	/**
	 * @inherited
	 * @method forOwn
	 * @since 0.7.0
	 */
	open override func forOwn(_ handler: @escaping JavaScriptForOwnHandler) {
		self.instance?.forOwn(handler)
	}

	/**
	 * @inherited
	 * @method prototype
	 * @since 0.7.0
	 */
	open override func prototype(_ prototype: JavaScriptValue) {
		self.instance?.prototype(prototype)
	}

	/**
	 * @inherited
	 * @method prototype
	 * @since 0.7.0
	 */
	open override func prototype() -> JavaScriptValue {
		return self.instance?.prototype() ?? self.context.jsundefined
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
		self.instance = callback.argument(0)
		self.instance?.unprotect()
	}
}
