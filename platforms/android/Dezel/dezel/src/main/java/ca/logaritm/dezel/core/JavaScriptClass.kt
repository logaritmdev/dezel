package ca.logaritm.dezel.core

/**
 * @class JavaScriptClass
 * @super JavaScriptObject
 * @since 0.1.0
 */
open class JavaScriptClass(context: JavaScriptContext) : JavaScriptObject(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property wrapper
	 * @since 0.7.0
	 * @hidden
	 */
	private var wrapper: JavaScriptValue? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method call
	 * @since 0.7.0
	 */
	override fun call() {
		
		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.call()
			return
		}
		
		super.call()
	}

	/**
	 * @method call
	 * @since 0.7.0
	 */
	open fun call(arguments: JavaScriptArguments?, target: JavaScriptValue?) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.call(arguments, target)
			return
		}
		
		super.call(arguments, target, null)
	}

	/**
	 * @method call
	 * @since 0.7.0
	 */
	override fun call(arguments: JavaScriptArguments?, target: JavaScriptValue?, result: JavaScriptValue?) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.call(arguments, target, result)
			return
		}

		super.call(arguments, target, result)
	}

	/**
	 * @method callMethod
	 * @since 0.7.0
	 */
	override fun callMethod(method: String) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.callMethod(method)
			return
		}
		
		super.callMethod(method)
	}

	/**
	 * @method callMethod
	 * @since 0.7.0
	 */
	override fun callMethod(method: String, arguments: JavaScriptArguments?, result: JavaScriptValue?) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.callMethod(method, arguments, result)
			return
		}
		
		super.callMethod(method, arguments, result)
	}

	/**
	 * @method construct
	 * @since 0.7.0
	 */
	override fun construct() {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.construct()
			return
		}
		
		super.construct()
	}

	/**
	 * @method construct
	 * @since 0.7.0
	 */
	override fun construct(arguments: JavaScriptArguments?, result: JavaScriptValue?) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.construct(arguments, result)
			return
		}
		
		super.construct(arguments, result)
	}

	/**
	 * @method defineProperty
	 * @since 0.7.0
	 */
	override fun defineProperty(property: String, value: JavaScriptValue?, getter: JavaScriptGetterHandler?, setter: JavaScriptSetterHandler?, writable: Boolean, enumerable: Boolean, configurable: Boolean) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.defineProperty(property, value, getter, setter, writable, enumerable, configurable)
			return
		}		
		
		super.defineProperty(property, value, getter, setter, writable, enumerable, configurable)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, value: JavaScriptValue?) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(name, value)
			return
		}		
		
		super.property(name, value)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, property: JavaScriptProperty) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(name, property)
			return
		}
		
		super.property(name, property)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, string: String) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(name, string)
			return
		}		
		
		super.property(name, string)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, number: Double) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(name, number)
			return
		}		
		
		super.property(name, number)
	}

	/**
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(name: String, number: Float) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(name, number)
			return
		}		
		
		super.property(name, number)
	}

	/**
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(name: String, number: Int) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(name, number)
			return
		}		
		
		super.property(name, number)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, boolean: Boolean) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(name, boolean)
			return
		}		
		
		super.property(name, boolean)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String): JavaScriptValue {
		return this.wrapper?.property(name) ?: super.property(name)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, value: JavaScriptValue) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(index, value)
			return
		}		
		
		super.property(index, value)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, string: String) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(index, string)
			return
		}		
		
		super.property(index, string)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, number: Double) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(index, number)
			return
		}		
		
		super.property(index, number)
	}

	/**
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(index: Int, number: Float) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(index, number)
			return
		}		
		
		super.property(index, number)
	}

	/**
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(index: Int, number: Int) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(index, number)
			return
		}		
		
		super.property(index, number)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, boolean: Boolean) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.property(index, boolean)
			return
		}		
		
		super.property(index, boolean)
	}

	/**
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int): JavaScriptValue {
		return this.wrapper?.property(index) ?: super.property(index)
	}

	/**
	 * @method forEach
	 * @since 0.7.0
	 */
	override fun forEach(handler: JavaScriptForEachHandler) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.forEach(handler)
			return
		}		
		
		super.forEach(handler)
	}

	/**
	 * @method forOwn
	 * @since 0.7.0
	 */
	override fun forOwn(handler: JavaScriptForOwnHandler) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.forOwn(handler)
			return
		}		
		
		super.forOwn(handler)
	}

	/**
	 * @method prototype
	 * @since 0.7.0
	 */
	override fun prototype(prototype: JavaScriptValue) {

		val wrapper = this.wrapper
		if (wrapper != null) {
			wrapper.prototype(prototype)
			return
		}		
		
		super.prototype(prototype)
	}

	/**
	 * @method prototype
	 * @since 0.7.0
	 */
	override fun prototype(): JavaScriptValue {
		return this.wrapper?.prototype() ?: super.prototype()
	}

	/**
	 * @method onProtectValue
	 * @since 0.6.0
	 */
	override fun onProtectValue() {

		/*
		 * When protecting an object from being collected, we also want to
		 * make sure its holder does not get collected.
		 */

		this.wrapper?.protect()
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

		this.wrapper?.unprotect()
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

		if (callback.arguments == 0) {

			/*
			 * It's possible this class does not have a native JavaScript
			 * wrapper class. In this case all class related method will
			 * be called on this wrapper instead.
			 */

			return
		}

		this.wrapper = callback.argument(0)
		this.wrapper?.unprotect()
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method toHandle
	 * @since 0.7.0
	 * @hidden
	 */
	override fun toHandle(context: JavaScriptContext): Long {
		return this.wrapper?.toHandle(context) ?: super.toHandle(context)
	}
}
