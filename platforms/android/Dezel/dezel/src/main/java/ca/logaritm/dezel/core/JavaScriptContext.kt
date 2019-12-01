package ca.logaritm.dezel.core

import ca.logaritm.dezel.BuildConfig

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
	 * @const jsnull
	 * @since 0.7.0
	 */
	public val jsnull: JavaScriptValue by lazy {
		JavaScriptNull(this)
	}

	/**
	 * @const jsundefined
	 * @since 0.7.0
	 */
	public val jsundefined: JavaScriptValue by lazy {
		JavaScriptUndefined(this)
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
	 * @property modules
	 * @since 0.1.0
	 */
	public var modules: MutableMap<String, JavaScriptModule> = mutableMapOf()
		internal set

	/**
	 * @property objects
	 * @since 0.1.0
	 */
	public var objects: MutableMap<String, JavaScriptValue> = mutableMapOf()
		internal set

	/**
	 * @property classes
	 * @since 0.1.0
	 */
	public var classes: MutableMap<String, JavaScriptValue> = mutableMapOf()
		internal set

	/**
	 * @property running
	 * @since 0.1.0
	 * @hidden
	 */
	private var running: Boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {

		this.handle = JavaScriptContextExternal.create(BuildConfig.APPLICATION_ID)

		JavaScriptContextReference.register(this)

		this.global = JavaScriptValue.create(this, JavaScriptContextExternal.getGlobalObject(this.handle))
		this.global.defineProperty("global", value = this.global, getter = null, setter = null, writable = false, enumerable = false, configurable = false)
		this.global.defineProperty("window", value = this.global, getter = null, setter = null, writable = false, enumerable = false, configurable = false)
	}

	/**
	 * @method registerModules
	 * @since 0.7.0
	 */
	open fun registerModules(modules: Map<String, Class<*>>) {
		modules.forEach {
			this.registerModule(it.key, it.value)
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
	 * @method registerClasses
	 * @since 0.7.0
	 */
	open fun registerClasses(classes: Map<String, Class<*>>) {
		classes.forEach {
			this.registerClass(it.key, it.value)
		}
	}

	/**
	 * @method registerModule
	 * @since 0.1.0
	 */
	open fun registerModule(uid: String, type: Class<*>) {
		this.modules[uid] = JavaScriptModule.create(type, this)
	}

	/**
	 * @method registerObject
	 * @since 0.1.0
	 */
	open fun registerObject(uid: String, type: Class<*>) {
		this.objects[uid] = this.createObject(type)
	}

	/**
	 * @method registerClass
	 * @since 0.1.0
	 */
	open fun registerClass(uid: String, type: Class<*>) {
		this.classes[uid] = this.createClass(type)
	}

	/**
	 * @method setup
	 * @since 0.7.0
	 */
	open fun setup() {

		if (this.running) {
			return
		}

		this.running = true

		this.modules.forEach {
			it.value.initialize()
		}
	}

	open fun reload() {
		// TODO
	}

	/**
	 * @method dispose
	 * @since 0.1.0
	 */
	open fun dispose() {

		if (this.running == false) {
			return
		}

		this.modules.forEach {
			it.value.dispose()
		}

		this.modules.clear()
		this.objects.clear()
		this.classes.clear()

		this.global.dispose()

		this.garbageCollect()

		JavaScriptContextExternal.delete(this.handle)

		this.running = false
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
	open fun evaluate(code: String) {
		JavaScriptContextExternal.evaluate(this.handle, code)
	}

	/**
	 * @method evaluate
	 * @since 0.1.0
	 */
	open fun evaluate(code: String, file: String) {
		JavaScriptContextExternal.evaluate(this.handle, code, file)
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
