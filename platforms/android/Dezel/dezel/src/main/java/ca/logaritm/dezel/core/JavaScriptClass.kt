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
	 * @inherited
	 * @method call
	 * @since 0.7.0
	 */
	override fun call() {
		
		val instance = this.instance
		if (instance != null) {
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
	open fun call(arguments: JavaScriptArguments?, target: JavaScriptValue?) {

		val instance = this.instance
		if (instance != null) {
			instance.call(arguments, target)
			return
		}
		
		super.call(arguments, target, null)
	}

	/**
	 * @inherited
	 * @method call
	 * @since 0.7.0
	 */
	override fun call(arguments: JavaScriptArguments?, target: JavaScriptValue?, result: JavaScriptValue?) {

		val instance = this.instance
		if (instance != null) {
			instance.call(arguments, target, result)
			return
		}

		super.call(arguments, target, result)
	}

	/**
	 * @inherited
	 * @method callMethod
	 * @since 0.7.0
	 */
	override fun callMethod(method: String) {

		val instance = this.instance
		if (instance != null) {
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
	override fun callMethod(method: String, arguments: JavaScriptArguments?, result: JavaScriptValue?) {

		val instance = this.instance
		if (instance != null) {
			instance.callMethod(method, arguments, result)
			return
		}
		
		super.callMethod(method, arguments, result)
	}

	/**
	 * @inherited
	 * @method construct
	 * @since 0.7.0
	 */
	override fun construct() {

		val instance = this.instance
		if (instance != null) {
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
	override fun construct(arguments: JavaScriptArguments?, result: JavaScriptValue?) {

		val instance = this.instance
		if (instance != null) {
			instance.construct(arguments, result)
			return
		}
		
		super.construct(arguments, result)
	}

	/**
	 * @inherited
	 * @method defineProperty
	 * @since 0.7.0
	 */
	override fun defineProperty(property: String, value: JavaScriptValue?, getter: JavaScriptGetterHandler?, setter: JavaScriptSetterHandler?, writable: Boolean, enumerable: Boolean, configurable: Boolean) {

		val instance = this.instance
		if (instance != null) {
			instance.defineProperty(property, value, getter, setter, writable, enumerable, configurable)
			return
		}		
		
		super.defineProperty(property, value, getter, setter, writable, enumerable, configurable)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, value: JavaScriptValue?) {

		val instance = this.instance
		if (instance != null) {
			instance.property(name, value)
			return
		}		
		
		super.property(name, value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, property: JavaScriptProperty) {

		val instance = this.instance
		if (instance != null) {
			instance.property(name, property)
			return
		}
		
		super.property(name, property)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, string: String) {

		val instance = this.instance
		if (instance != null) {
			instance.property(name, string)
			return
		}		
		
		super.property(name, string)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, number: Double) {

		val instance = this.instance
		if (instance != null) {
			instance.property(name, number)
			return
		}		
		
		super.property(name, number)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(name: String, number: Float) {

		val instance = this.instance
		if (instance != null) {
			instance.property(name, number)
			return
		}		
		
		super.property(name, number)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(name: String, number: Int) {

		val instance = this.instance
		if (instance != null) {
			instance.property(name, number)
			return
		}		
		
		super.property(name, number)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String, boolean: Boolean) {

		val instance = this.instance
		if (instance != null) {
			instance.property(name, boolean)
			return
		}		
		
		super.property(name, boolean)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(name: String): JavaScriptValue {
		return this.instance?.property(name) ?: super.property(name)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, value: JavaScriptValue) {

		val instance = this.instance
		if (instance != null) {
			instance.property(index, value)
			return
		}		
		
		super.property(index, value)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, string: String) {

		val instance = this.instance
		if (instance != null) {
			instance.property(index, string)
			return
		}		
		
		super.property(index, string)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, number: Double) {

		val instance = this.instance
		if (instance != null) {
			instance.property(index, number)
			return
		}		
		
		super.property(index, number)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(index: Int, number: Float) {

		val instance = this.instance
		if (instance != null) {
			instance.property(index, number)
			return
		}		
		
		super.property(index, number)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.4.0
	 */
	override fun property(index: Int, number: Int) {

		val instance = this.instance
		if (instance != null) {
			instance.property(index, number)
			return
		}		
		
		super.property(index, number)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int, boolean: Boolean) {

		val instance = this.instance
		if (instance != null) {
			instance.property(index, boolean)
			return
		}		
		
		super.property(index, boolean)
	}

	/**
	 * @inherited
	 * @method property
	 * @since 0.7.0
	 */
	override fun property(index: Int): JavaScriptValue {
		return this.instance?.property(index) ?: super.property(index)
	}

	/**
	 * @inherited
	 * @method forEach
	 * @since 0.7.0
	 */
	override fun forEach(handler: JavaScriptForEachHandler) {

		val instance = this.instance
		if (instance != null) {
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
	override fun forOwn(handler: JavaScriptForOwnHandler) {

		val instance = this.instance
		if (instance != null) {
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
	override fun prototype(prototype: JavaScriptValue) {

		val instance = this.instance
		if (instance != null) {
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
	override fun prototype(): JavaScriptValue {
		return this.instance?.prototype() ?: super.prototype()
	}

	/**
	 * @inherited
	 * @method onProtectValue
	 * @since 0.6.0
	 */
	override fun onProtectValue() {

		/*
		 * When protecting an object from being collected, we also want to
		 * make sure its holder does not get collected.
		 */

		super.protect()
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

		super.unprotect()
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
			 * be called on this very instance instead.
			 */

			return
		}

		this.instance = callback.argument(0)
		this.instance?.unprotect()
	}

	//--------------------------------------------------------------------------
	// MARK: Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method toHandle
	 * @since 0.7.0
	 * @hidden
	 */
	override fun toHandle(context: JavaScriptContext): Long {
		return this.instance?.toHandle(context) ?: super.toHandle(context)
	}
}
