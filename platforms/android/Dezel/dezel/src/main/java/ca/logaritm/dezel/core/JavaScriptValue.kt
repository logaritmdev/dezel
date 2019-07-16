package ca.logaritm.dezel.core

/**
 * Contains a JavaScript handle from the current context.
 * @class JavaScriptValue
 * @since 0.1.0
 */
open class JavaScriptValue(context: JavaScriptContext) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @method createNull
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createNull(context: JavaScriptContext): JavaScriptValue {
			return create(context, JavaScriptValueExternal.createNull(context.handle))
		}

		/**
		 * @method createUndefined
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createUndefined(context: JavaScriptContext): JavaScriptValue {
			return create(context, JavaScriptValueExternal.createUndefined(context.handle))
		}

		/**
		 * @method createString
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createString(context: JavaScriptContext, value: String): JavaScriptValue {
			return create(context, JavaScriptValueExternal.createString(context.handle, value))
		}

		/**
		 * @method createNumber
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createNumber(context: JavaScriptContext, value: Double): JavaScriptValue {
			return create(context, JavaScriptValueExternal.createNumber(context.handle, value))
		}

		/**
		 * @method createBoolean
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createBoolean(context: JavaScriptContext, value: Boolean): JavaScriptValue {
			return create(context, JavaScriptValueExternal.createBoolean(context.handle, value))
		}

		/**
		 * @method createEmptyObject
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createEmptyObject(context: JavaScriptContext): JavaScriptValue {
			return create(context, JavaScriptValueExternal.createEmtpyObject(context.handle))
		}

		/**
		 * @method createEmptyArray
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createEmptyArray(context: JavaScriptContext): JavaScriptValue {
			return create(context, JavaScriptValueExternal.createEmptyArray(context.handle))
		}

		/**
		 * @method createFunction
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createFunction(context: JavaScriptContext, handler: JavaScriptFunctionHandler): JavaScriptValue {
			return create(context, JavaScriptValueExternal.createFunction(context.handle, JavaScriptFunctionWrapper(handler), null, context))
		}

		/**
		 * @method createFunction
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createFunction(context: JavaScriptContext, handler: JavaScriptFunctionHandler, name: String): JavaScriptValue {
			return create(context, JavaScriptValueExternal.createFunction(context.handle, JavaScriptFunctionWrapper(handler), name, context))
		}

		/**
		 * @method createObject
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createObject(context: JavaScriptContext, template: Class<*>): JavaScriptValue {
			return JavaScriptObjectBuilder.build(context, template)
		}

		/**
		 * @method createClass
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun createClass(context: JavaScriptContext, template: Class<*>): JavaScriptValue {
			return JavaScriptClassBuilder.build(context, template)
		}

		/**
		 * @method create
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun create(context: JavaScriptContext, handle: Long, protect: Boolean = true): JavaScriptValue {
			val value = JavaScriptValue(context)
			value.reset(handle, protect)
			return value
		}
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The value's context.
	 * @property context
	 * @since 0.1.0
	 */
	public var context: JavaScriptContext
		private set

	/**
	 * The value's handle.
	 * @property handle
	 * @since 0.1.0
	 */
	public var handle: Long = 0L
		private set

	/**
	 * @property protected
	 * @since 0.1.0
	 * @hidden
	 */
	private var protected: Int = 0

	//--------------------------------------------------------------------------
	// Properties - Types
	//--------------------------------------------------------------------------

	/**
	 * Indicates whether the value is undefined.
	 * @property isUndefined
	 * @since 0.4.0
	 */
	public val isUndefined: Boolean
		get() = JavaScriptValueExternal.getType(this.context.handle, this.handle) == 1

	/**
	 * Indicates whether the value is null.
	 * @property isNull
	 * @since 0.4.0
	 */
	public val isNull: Boolean
		get() = JavaScriptValueExternal.getType(this.context.handle, this.handle) == 2

	/**
	 * Indicates whether the value is a boolean.
	 * @property isBoolean
	 * @since 0.4.0
	 */
	public val isBoolean: Boolean
		get() = JavaScriptValueExternal.getType(this.context.handle, this.handle) == 3

	/**
	 * Indicates whether the value is a number.
	 * @property isNumber
	 * @since 0.4.0
	 */
	public val isNumber: Boolean
		get() = JavaScriptValueExternal.getType(this.context.handle, this.handle) == 4

	/**
	 * Indicates whether the value is a string.
	 * @property isString
	 * @since 0.4.0
	 */
	public val isString: Boolean
		get() = JavaScriptValueExternal.getType(this.context.handle, this.handle) == 5

	/**
	 * Indicates whether the value is an object.
	 * @property isObject
	 * @since 0.4.0
	 */
	public val isObject: Boolean
		get() = JavaScriptValueExternal.getType(this.context.handle, this.handle) == 6

	/**
	 * Indicates whether the value is an array.
	 * @property isObject
	 * @since 0.4.0
	 */
	public val isArray: Boolean
		get() = JavaScriptValueExternal.getType(this.context.handle, this.handle) == 7

	/**
	 * Indicates whether the value is a function.
	 * @property isFunction
	 * @since 0.4.0
	 */
	public val isFunction: Boolean
		get() = JavaScriptValueExternal.getType(this.context.handle, this.handle) == 8

	//--------------------------------------------------------------------------
	// Properties - Conversions
	//--------------------------------------------------------------------------

	/**
	 * Converts the value to a string handle.
	 * @property string
	 * @since 0.2.0
	 */
	public val string: String by lazy {
		JavaScriptValueExternal.toString(context.handle, this.handle)
	}

	/**
	 * Converts the value to a double handle.
	 * @property number
	 * @since 0.2.0
	 */
	public val number: Double by lazy {
		JavaScriptValueExternal.toNumber(context.handle, this.handle)
	}

	/**
	 * Converts the value to a boolean handle.
	 * @property boolean
	 * @since 0.2.0
	 */
	public val boolean: Boolean by lazy {
		JavaScriptValueExternal.toBoolean(context.handle, this.handle)
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init {
		this.context = context
	}

	/**
	 * Increments the value's protection count.
	 * @method protect
	 * @since 0.1.0
	 */
	public fun protect() {

		this.protected += 1

		if (this.protected == 1) {
			JavaScriptValueExternal.protect(this.context.handle, this.handle)
			JavaScriptValueReference.protect(this)
		}

		this.onProtectValue()
	}

	/**
	 * Decrements the value's protection count.
	 * @method unprotect
	 * @since 0.1.0
	 */
	public fun unprotect() {

		if (this.handle == 0L) {
			return
		}

		if (this.protected == 1) {
			JavaScriptValueExternal.unprotect(this.context.handle, this.handle)
			JavaScriptValueReference.unprotect(this)
		}

		if (this.protected > 0) {
			this.protected -= 1
		}

		this.onUnprotectValue()
	}

	/**
	 * Disposes the value's.
	 * @method dispose
	 * @since 0.1.0
	 */
	open fun dispose() {

		if (this.handle == 0L) {
			return
		}

		this.unprotect()

		this.handle = 0L
	}

	/**
	 * Casts the value to a specified type.
	 * @method cast
	 * @since 0.1.0
	 */
	public fun <T> cast(type: Class<T>): T? {

		try {

			val value = JavaScriptValueExternal.getAssociatedObject(this.context.handle, this.handle)
			if (value == null) {
				return null
			}

			return type.cast(value)

		} catch (e: ClassCastException) {
			return null
		}
	}

	/**
	 * Executes the value as a function.
	 * @method call
	 * @since 0.1.0
	 */
	public fun call() {
		JavaScriptValueExternal.call(this.context.handle, this.handle, 0, null, 0, null)
	}

	/**
	 * Executes the value as a function with arguments.
	 * @method call
	 * @since 0.1.0
	 */
	public fun call(arguments: JavaScriptArguments?, target: JavaScriptValue?, result: JavaScriptValue? = null) {
		JavaScriptValueExternal.call(this.context.handle, this.handle, toHandle(target, this.context), toArgv(arguments, this.context), toArgc(arguments), result)
	}

	/**
	 * Executes a holder from the value.
	 * @method callMethod
	 * @since 0.1.0
	 */
	public fun callMethod(method: String) {
		JavaScriptValueExternal.callMethod(this.context.handle, this.handle, method, null, 0, null)
	}

	/**
	 * Executes a holder with arguments from the value.
	 * @method callMethod
	 * @since 0.1.0
	 */
	public fun callMethod(method: String, arguments: JavaScriptArguments?, result: JavaScriptValue? = null) {
		JavaScriptValueExternal.callMethod(this.context.handle, this.handle, method, toArgv(arguments, context), toArgc(arguments), result)
	}

	/**
	 * Executes the value as a constructor.
	 * @method construct
	 * @since 0.1.0
	 */
	public fun construct() {
		JavaScriptValueExternal.construct(this.context.handle, this.handle, null, 0, null)
	}

	/**
	 * Executes the value as a constructor with arguments.
	 * @method construct
	 * @since 0.1.0
	 */
	public fun construct(arguments: JavaScriptArguments?, result: JavaScriptValue? = null) {
		JavaScriptValueExternal.construct(this.context.handle, this.handle, toArgv(arguments, context), toArgc(arguments), result)
	}

	/**
	 * Defines a property on this value.
	 * @method defineProperty
	 * @since 0.1.0
	 */
	public fun defineProperty(property: String, value: JavaScriptValue?, getter: JavaScriptGetterHandler?, setter: JavaScriptSetterHandler?, writable: Boolean, enumerable: Boolean, configurable: Boolean) {

		var get: JavaScriptGetterWrapper? = null
		var set: JavaScriptSetterWrapper? = null

		if (getter != null) get = JavaScriptGetterWrapper(getter)
		if (setter != null) set = JavaScriptSetterWrapper(setter)

		JavaScriptValueExternal.defineProperty(this.context.handle, this.handle, property, toHandle(value, this.context), get, set, writable, enumerable, configurable, context)
	}

	/**
	 * Assigns the value of a property.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(name: String, value: JavaScriptValue?) {
		JavaScriptValueExternal.setProperty(this.context.handle, this.handle, name, toHandle(value, this.context))
	}

	/**
	 * Assigns the value of a property using a property.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(name: String, property: Property) {
		JavaScriptValueExternal.setProperty(this.context.handle, this.handle, name, property.value(this.context).handle)
	}

	/**
	 * Assigns the value of a property using a string.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(name: String, string: String) {
		JavaScriptValueExternal.setProperty(this.context.handle, this.handle, name, string)
	}

	/**
	 * Assigns the value of a property using a number.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(name: String, number: Double) {
		JavaScriptValueExternal.setProperty(this.context.handle, this.handle, name, number)
	}

	/**
	 * Assigns the value of a property using a number.
	 * @method property
	 * @since 0.4.0
	 */
	public fun property(name: String, number: Float) {
		JavaScriptValueExternal.setProperty(this.context.handle, this.handle, name, number.toDouble())
	}

	/**
	 * Assigns the value of a property using a number.
	 * @method property
	 * @since 0.4.0
	 */
	public fun property(name: String, number: Int) {
		JavaScriptValueExternal.setProperty(this.context.handle, this.handle, name, number.toDouble())
	}

	/**
	 * Assigns the value of a property using a boolean.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(name: String, boolean: Boolean) {
		JavaScriptValueExternal.setProperty(this.context.handle, handle, name, boolean)
	}

	/**
	 * Returns the value of a property.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(name: String): JavaScriptValue {
		return create(this.context, JavaScriptValueExternal.getProperty(this.context.handle, this.handle, name))
	}

	/**
	 * Assigns the value of a property at a specified index.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(index: Int, value: JavaScriptValue) {
		JavaScriptValueExternal.setPropertyAtIndex(this.context.handle, this.handle, index, value.handle)
	}

	/**
	 * Assigns the value of a property at a specified index using a string.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(index: Int, string: String) {
		JavaScriptValueExternal.setPropertyAtIndex(this.context.handle, this.handle, index, string)
	}

	/**
	 * Assigns the value of a property at a specified index using a number.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(index: Int, number: Double) {
		JavaScriptValueExternal.setPropertyAtIndex(this.context.handle, this.handle, index, number)
	}

	/**
	 * Assigns the value of a property at a specified index using a number.
	 * @method property
	 * @since 0.4.0
	 */
	public fun property(index: Int, number: Float) {
		JavaScriptValueExternal.setPropertyAtIndex(this.context.handle, this.handle, index, number.toDouble())
	}

	/**
	 * Assigns the value of a property at a specified index using a number.
	 * @method property
	 * @since 0.4.0
	 */
	public fun property(index: Int, number: Int) {
		JavaScriptValueExternal.setPropertyAtIndex(this.context.handle, this.handle, index, number.toDouble())
	}

	/**
	 * Assigns the value of a property at a specified index using a boolean.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(index: Int, boolean: Boolean) {
		JavaScriptValueExternal.setPropertyAtIndex(this.context.handle, this.handle, index, boolean)
	}

	/**
	 * Returns the value of a property at a specified index.
	 * @method property
	 * @since 0.1.0
	 */
	public fun property(index: Int): JavaScriptValue {
		return create(context, JavaScriptValueExternal.getPropertyAtIndex(this.context.handle, this.handle, index))
	}

	/**
	 * Convenience holder to loop through this value's array values.
	 * @method forEach
	 * @since 0.1.0
	 */
	public fun forEach(handler: JavaScriptForEachHandler) {
		val length = this.length()
		if (length > 0) {
			for (i in 0 until length) {
				handler(i, this.property(i))
			}
		}
	}

	/**
	 * Assigns the internal prototype of this value.
	 * @method prototype
	 * @since 0.1.0
	 */
	public fun prototype(prototype: JavaScriptValue) {
		JavaScriptValueExternal.setPrototype(this.context.handle, this.handle, toHandle(prototype, this.context))
	}

	/**
	 * Returns the internal prototype of this value.
	 * @method prototype
	 * @since 0.1.0
	 */
	public fun prototype(): JavaScriptValue {
		return create(this.context, JavaScriptValueExternal.getPrototype(this.context.handle, this.handle))
	}

	/**
	 * Indicates the value is equal and the same type as the specified handle.
	 * @method equals
	 * @since 0.1.0
	 */
	public fun equals(value: JavaScriptValue): Boolean {
		return JavaScriptValueExternal.equals(this.context.handle, this.handle, toHandle(value, this.context))
	}

	/**
	 * Indicates if the value is the specified string.
	 * @method equals
	 * @since 0.1.0
	 */
	public fun equals(string: String): Boolean {
		return JavaScriptValueExternal.equals(this.context.handle, this.handle, string)
	}

	/**
	 * Indicates if the value is the specified number.
	 * @method equals
	 * @since 0.1.0
	 */
	public fun equals(number: Double): Boolean {
		return JavaScriptValueExternal.equals(this.context.handle, this.handle, number)
	}

	/**
	 * Indicates if the value is the specified boolean.
	 * @method equals
	 * @since 0.1.0
	 */
	public fun equals(boolean: Boolean): Boolean {
		return JavaScriptValueExternal.equals(this.context.handle, this.handle, boolean)
	}

	//--------------------------------------------------------------------------
	// Methods - Extensions
	//--------------------------------------------------------------------------

	/**
	 * Called when the value gets protected.
	 * @method onProtectValue
	 * @since 0.4.0
	 */
	open fun onProtectValue() {

	}

	/**
	 * Called when the value gets unprotected.
	 * @method onUnprotectValue
	 * @since 0.4.0
	 */
	open fun onUnprotectValue() {

	}

	/**
	 * Called when the value gets resetted.
	 * @method onResetValue
	 * @since 0.4.0
	 */
	open fun onResetValue() {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method length
	 * @since 0.1.0
	 * @hidden
	 */
	internal fun length(): Int {
		return this.property("length").number.toInt()
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 * @hidden
	 */
	public fun reset(handle: Long, protect: Boolean = true) {

		this.unprotect()

		this.handle = handle

		if (protect) {
			this.protect()
		}

		this.onResetValue()
	}
}
