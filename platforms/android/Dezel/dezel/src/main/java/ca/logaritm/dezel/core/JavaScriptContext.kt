package ca.logaritm.dezel.core

import ca.logaritm.dezel.BuildConfig
import ca.logaritm.dezel.core.external.JavaScriptContextExternal

/**
 * @class JavaScriptContext
 * @since 0.1.0
 */
open class JavaScriptContext {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {
		init {
			System.loadLibrary("jsc")
			System.loadLibrary("dezel")
		}
	}

	//--------------------------------------------------------------------------
	// Constants
	//--------------------------------------------------------------------------

	/**
	 * @const Null
	 * @since 0.7.0
	 */
	public val Null: JavaScriptValue by lazy {
		this.createNull()
	}

	/**
	 * @const Undefined
	 * @since 0.7.0
	 */
	public val Undefined: JavaScriptValue by lazy {
		this.createUndefined()
	}

	/**
	 * @const True
	 * @since 0.7.0
	 */
	public val True: JavaScriptValue by lazy {
		this.createBoolean(true)
	}

	/**
	 * @const False
	 * @since 0.7.0
	 */
	public val False: JavaScriptValue by lazy {
		this.createBoolean(false)
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property handle
	 * @since 0.1.0
	 */
	public var handle: Long = 0
		private set

	/**
	 * @property global
	 * @since 0.1.0
	 */
	public var global: JavaScriptValue
		private set

	/**
	 * @property classes
	 * @since 0.1.0
	 */
	public var classes: MutableMap<String, JavaScriptValue> = mutableMapOf()
		internal set

	/**
	 * @property objects
	 * @since 0.1.0
	 */
	public var objects: MutableMap<String, JavaScriptValue> = mutableMapOf()
		internal set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {

		this.handle = JavaScriptContextExternal.create(BuildConfig.APPLICATION_ID)

		this.global = JavaScriptValue.create(this, JavaScriptContextExternal.getGlobalObject(this.handle))
		this.global.defineProperty("global", value = this.global, getter = null, setter = null, writable = false, enumerable = false, configurable = false)
		this.global.defineProperty("window", value = this.global, getter = null, setter = null, writable = false, enumerable = false, configurable = false)

		JavaScriptContextReference.register(this)
	}

	/**
	 * @method registerClasses
	 * @since 0.7.0
	 */
	open fun registerClasses(classes: Map<String, Class<*>>) {
		classes.forEach {
			this.registerClass(it.key, it.value)
		}
	}

	/**
	 * @method registerObjects
	 * @since 0.7.0
	 */
	open fun registerObjects(objects: Map<String, Class<*>>) {
		objects.forEach {
			this.registerObject(it.key, it.value)
		}
	}

	/**
	 * @method registerClass
	 * @since 0.1.0
	 */
	open fun registerClass(uid: String, type: Class<*>) {
		this.classes[uid] = this.createClass(type)
	}

	/**
	 * @method registerObject
	 * @since 0.1.0
	 */
	open fun registerObject(uid: String, type: Class<*>) {
		this.objects[uid] = this.createObject(type)
	}

	/**
	 * @method dispose
	 * @since 0.1.0
	 */
	open fun dispose() {

		this.objects.clear()
		this.classes.clear()
		this.global.dispose()

		this.garbageCollect()

		JavaScriptContextExternal.delete(this.handle)
	}

	/**
	 * @method createNull
	 * @since 0.1.0
	 */
	open fun createNull(): JavaScriptValue {
		return JavaScriptValue.createNull(this)
	}

	/**
	 * @method createUndefined
	 * @since 0.1.0
	 */
	open fun createUndefined(): JavaScriptValue {
		return JavaScriptValue.createUndefined(this)
	}

	/**
	 * @method createString
	 * @since 0.1.0
	 */
	open fun createString(value: String): JavaScriptValue {
		return JavaScriptValue.createString(this, value)
	}

	/**
	 * @method createNumber
	 * @since 0.1.0
	 */
	open fun createNumber(value: Double): JavaScriptValue {
		return JavaScriptValue.createNumber(this, value)
	}

	/**
	 * @method createNumber
	 * @since 0.3.0
	 */
	open fun createNumber(value: Float): JavaScriptValue {
		return JavaScriptValue.createNumber(this, value.toDouble())
	}

	/**
	 * @method createNumber
	 * @since 0.3.0
	 */
	open fun createNumber(value: Int): JavaScriptValue {
		return JavaScriptValue.createNumber(this, value.toDouble())
	}

	/**
	 * @method createBoolean
	 * @since 0.1.0
	 */
	open fun createBoolean(value: Boolean): JavaScriptValue {
		return JavaScriptValue.createBoolean(this, value)
	}

	/**
	 * @method createEmptyObject
	 * @since 0.1.0
	 */
	open fun createEmptyObject(): JavaScriptValue {
		return JavaScriptValue.createEmptyObject(this)
	}

	/**
	 * @method createEmptyArray
	 * @since 0.1.0
	 */
	open fun createEmptyArray(): JavaScriptValue {
		return JavaScriptValue.createEmptyArray(this)
	}

	/**
	 * @method createFunction
	 * @since 0.1.0
	 */
	open fun createFunction(value: JavaScriptFunctionHandler): JavaScriptValue {
		return JavaScriptValue.createFunction(this, value)
	}

	/**
	 * @method createFunction
	 * @since 0.1.0
	 */
	open fun createFunction(name: String, value: JavaScriptFunctionHandler): JavaScriptValue {
		return JavaScriptValue.createFunction(this, value, name)
	}

	/**
	 * @method createObject
	 * @since 0.1.0
	 */
	open fun createObject(template: Class<*>): JavaScriptValue {
		return JavaScriptValue.createObject(this, template)
	}

	/**
	 * @method createClass
	 * @since 0.1.0
	 */
	open fun createClass(template: Class<*>): JavaScriptValue {
		return JavaScriptValue.createClass(this, template)
	}

	/**
	 * @method createReturnValue
	 * @since 0.1.0
	 */
	open fun createReturnValue(): JavaScriptValue {
		return JavaScriptValue.createUndefined(this)
	}

	/**
	 * @method evaluate
	 * @since 0.1.0
	 */
	open fun evaluate(source: String) {
		JavaScriptContextExternal.evaluate(this.handle, source)
	}

	/**
	 * @method evaluate
	 * @since 0.1.0
	 */
	open fun evaluate(source: String, url: String) {
		JavaScriptContextExternal.evaluate(this.handle, source, url)
	}

	/**
	 * @method attribute
	 * @since 0.1.0
	 */
	open fun attribute(key: Any, value: Any?) {
		val hash = key.hashCode()
		JavaScriptContextExternal.delAttribute(this.handle, hash)
		JavaScriptContextExternal.setAttribute(this.handle, hash, value)
	}

	/**
	 * @method attribute
	 * @since 0.1.0
	 */
	open fun attribute(key: Any): Any? {
		return JavaScriptContextExternal.getAttribute(this.handle, key.hashCode())
	}

	/**
	 * @method handleError
	 * @since 0.6.0
	 */
	open fun handleError(callback: JavaScriptExceptionHandler) {
		JavaScriptContextExternal.setExceptionCallback(this.handle, JavaScriptExceptionWrapper(callback), this)
	}

	/**
	 * @method garbageCollect
	 * @since 0.1.0
	 */
	open fun garbageCollect() {
		JavaScriptContextExternal.garbageCollect(this.handle)
	}
}
