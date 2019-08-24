package ca.logaritm.dezel.core

/**
 * The base class for bridged classes.
 * @class JavaScriptClass
 * @since 0.1.0
 */
open class JavaScriptClass(context: JavaScriptContext) : JavaScriptObject(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property instance
	 * @since 0.7.0
	 * @hidden
	 */
	internal var instance: JavaScriptValue? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Casts the value to a specified type.
	 * @method cast
	 * @since 0.7.0
	 */
	override fun <T> cast(type: Class<T>): T? {
		return this.instance?.cast(type)
	}

	/**
	 * Executes the value as a function.
	 * @method call
	 * @since 0.7.0
	 */
	override fun call() {
		this.instance?.call()
	}

	/**
	 * Executes the value as a function with arguments.
	 * @method call
	 * @since 0.7.0
	 */
	open fun call(arguments: JavaScriptArguments?, target: JavaScriptValue?) {
		this.instance?.call(arguments, target)
	}

	/**
	 * Executes the value as a function with arguments.
	 * @method call
	 * @since 0.7.0
	 */
	override fun call(arguments: JavaScriptArguments?, target: JavaScriptValue?, result: JavaScriptValue?) {
		this.instance?.call(arguments, target, result)
	}

	/**
	 * Executes a holder from the value.
	 * @method callMethod
	 * @since 0.7.0
	 */
	override fun callMethod(method: String) {
		this.instance?.callMethod(method)
	}

	/**
	 * Executes a holder with arguments from the value.
	 * @method callMethod
	 * @since 0.7.0
	 */
	override fun callMethod(method: String, arguments: JavaScriptArguments?, result: JavaScriptValue?) {
		this.instance?.callMethod(method, arguments, result)
	}

	/**
	 * Executes the value as a constructor.
	 * @method construct
	 * @since 0.7.0
	 */
	override fun construct() {
		this.instance?.construct()
	}

	/**
	 * Executes the value as a constructor with arguments.
	 * @method construct
	 * @since 0.7.0
	 */
	override fun construct(arguments: JavaScriptArguments?, result: JavaScriptValue?) {
		this.instance?.construct(arguments, result)
	}

	/**
	 * Defines a property on this value.
	 * @method defineProperty
	 * @since 0.7.0
	 */
	override fun defineProperty(property: String, value: JavaScriptValue?, getter: JavaScriptGetterHandler?, setter: JavaScriptSetterHandler?, writable: Boolean, enumerable: Boolean, configurable: Boolean) {
		this.instance?.defineProperty(property, value, getter, setter, writable, enumerable, configurable)
	}

	/**
	 * Assigns the value of a property.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, value: JavaScriptValue?) {
		this.instance?.property(name, value)
	}

	/**
	 * Assigns the value of a property using a property.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, property: JavaScriptProperty) {
		this.instance?.property(name, property)
	}

	/**
	 * Assigns the value of a property using a string.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, string: String) {
		this.instance?.property(name, string)
	}

	/**
	 * Assigns the value of a property using a number.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, number: Double) {
		this.instance?.property(name, number)
	}

	/**
	 * Assigns the value of a property using a number.
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(name: String, number: Float) {
		this.instance?.property(name, number)
	}

	/**
	 * Assigns the value of a property using a number.
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(name: String, number: Int) {
		this.instance?.property(name, number)
	}

	/**
	 * Assigns the value of a property using a boolean.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, boolean: Boolean) {
		this.instance?.property(name, boolean)
	}

	/**
	 * Returns the value of a property.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String): JavaScriptValue {
		return this.instance?.property(name) ?: this.context.jsundefined
	}

	/**
	 * Assigns the value of a property at a specified index.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, value: JavaScriptValue) {
		this.instance?.property(index, value)
	}

	/**
	 * Assigns the value of a property at a specified index using a string.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, string: String) {
		this.instance?.property(index, string)
	}

	/**
	 * Assigns the value of a property at a specified index using a number.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, number: Double) {
		this.instance?.property(index, number)
	}

	/**
	 * Assigns the value of a property at a specified index using a number.
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(index: Int, number: Float) {
		this.instance?.property(index, number)
	}

	/**
	 * Assigns the value of a property at a specified index using a number.
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(index: Int, number: Int) {
		this.instance?.property(index, number)
	}

	/**
	 * Assigns the value of a property at a specified index using a boolean.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, boolean: Boolean) {
		this.instance?.property(index, boolean)
	}

	/**
	 * Returns the value of a property at a specified index.
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int): JavaScriptValue {
		return this.instance?.property(index) ?: this.context.jsundefined
	}

	/**
	 * Executes a provided function once for each array element.
	 * @method forEach
	 * @since 0.7.0
	 */
	override fun forEach(handler: JavaScriptForEachHandler) {
		this.instance?.forEach(handler)
	}

	/**
	 * Executes a provided function once for each object properties.
	 * @method forOwn
	 * @since 0.7.0
	 */
	override fun forOwn(handler: JavaScriptForOwnHandler) {
		this.instance?.forOwn(handler)
	}

	/**
	 * Assigns the internal prototype of this value.
	 * @method prototype
	 * @since 0.7.0
	 */
	override fun prototype(prototype: JavaScriptValue) {
		this.instance?.prototype(prototype)
	}

	/**
	 * Returns the internal prototype of this value.
	 * @method prototype
	 * @since 0.7.0
	 */
	override fun prototype(): JavaScriptValue {
		return this.instance?.prototype() ?: this.context.jsundefined
	}

	/**
	 * Called when the value gets protected.
	 * @method onProtectValue
	 * @since 0.6.0
	 */
	override fun onProtectValue() {

		/*
		 * When protecting an object from being collected, we also want to
		 * make sure its holder does not get collected.
		 */

		this.instance?.protect()
	}

	/**
	 * Called when the value gets unprotected.
	 * @method onUnprotectValue
	 * @since 0.6.0
	 */
	override fun onUnprotectValue() {

		/*
		 * When protecting an object from being collected, we also want to
		 * make sure its holder does not get collected.
		 */

		this.instance?.unprotect()
	}

	//--------------------------------------------------------------------------
	// JS Methods
	//--------------------------------------------------------------------------

	/**
	 * Default constructor implementation.
	 * @method jsFunction_constructor
	 * @since 0.1.0
	 */
	open fun jsFunction_constructor(callback: JavaScriptFunctionCallback) {
		this.instance = callback.argument(0)
		this.instance?.unprotect()
	}
}
