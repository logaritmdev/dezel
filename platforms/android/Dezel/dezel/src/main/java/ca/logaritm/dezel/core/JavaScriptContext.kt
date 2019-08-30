package ca.logaritm.dezel.core

import ca.logaritm.dezel.BuildConfig

/**
 * A JavaScript execution environment.
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
	 * The null JavaScript toValue.
	 * @const jsnull
	 * @since 0.7.0
	 */
	public val jsnull: JavaScriptValue by lazy {
		JavaScriptNull(this)
	}

	/**
	 * The undefined JavaScript toValue.
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
	 * The context's execute.
	 * @property handle
	 * @since 0.1.0
	 */
	public var handle: Long = 0
		private set

	/**
	 * The context's global object.
	 * @property global
	 * @since 0.1.0
	 */
	public var global: JavaScriptValue
		private set

	/**
	 * The context's registered modules.
	 * @property modules
	 * @since 0.1.0
	 */
	public var modules: MutableMap<String, Module> = mutableMapOf()
		internal set

	/**
	 * The context's registered objects.
	 * @property objects
	 * @since 0.1.0
	 */
	public var objects: MutableMap<String, JavaScriptValue> = mutableMapOf()
		internal set

	/**
	 * The context's registered classes.
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
	 * Initializes the context.
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
	 * Register multiple modules.
	 * @method registerModules
	 * @since 0.7.0
	 */
	open fun registerModules(modules: Map<String, Class<*>>) {
		modules.forEach {
			this.registerModule(it.key, it.value)
		}
	}

	/**
	 * Register multiple objects.
	 * @method registerObjects
	 * @since 0.7.0
	 */
	open fun registerObjects(objects: Map<String, Class<*>>) {
		objects.forEach {
			this.registerObject(it.key, it.value)
		}
	}

	/**
	 * Register multiple classes.
	 * @method registerClasses
	 * @since 0.7.0
	 */
	open fun registerClasses(classes: Map<String, Class<*>>) {
		classes.forEach {
			this.registerClass(it.key, it.value)
		}
	}

	/**
	 * Registers a context module.
	 * @method registerModule
	 * @since 0.1.0
	 */
	open fun registerModule(uid: String, type: Class<*>) {
		this.modules[uid] = Module.create(type, this)
	}

	/**
	 * Registers a context class.
	 * @method registerObject
	 * @since 0.1.0
	 */
	open fun registerObject(uid: String, type: Class<*>) {
		this.objects[uid] = this.createObject(type)
	}

	/**
	 * Registers a context class.
	 * @method registerClass
	 * @since 0.1.0
	 */
	open fun registerClass(uid: String, type: Class<*>) {
		this.classes[uid] = this.createClass(type)
	}

	/**
	 * Loads the context dependencies.
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
	 * Disposes the context.
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
	 * Creates a handle which contains the null JavaScript handle.
	 * @method createNull
	 * @since 0.1.0
	 */
	open fun createNull(): JavaScriptValue {
		return JavaScriptValue.createNull(this)
	}

	/**
	 * Creates a handle which contains the undefined JavaScript handle.
	 * @method createUndefined
	 * @since 0.1.0
	 */
	open fun createUndefined(): JavaScriptValue {
		return JavaScriptValue.createUndefined(this)
	}

	/**
	 * Creates a handle which contains a toString JavaScript handle.
	 * @method createString
	 * @since 0.1.0
	 */
	open fun createString(value: String): JavaScriptValue {
		return JavaScriptValue.createString(this, value)
	}

	/**
	 * Creates a handle which contains a numeric JavaScript handle.
	 * @method createNumber
	 * @since 0.1.0
	 */
	open fun createNumber(value: Double): JavaScriptValue {
		return JavaScriptValue.createNumber(this, value)
	}

	/**
	 * Creates a toValue which contains a numeric JavaScript toValue.
	 * @method createNumber
	 * @since 0.3.0
	 */
	open fun createNumber(value: Float): JavaScriptValue {
		return JavaScriptValue.createNumber(this, value.toDouble())
	}

	/**
	 * Creates a toValue which contains a numeric JavaScript toValue.
	 * @method createNumber
	 * @since 0.3.0
	 */
	open fun createNumber(value: Int): JavaScriptValue {
		return JavaScriptValue.createNumber(this, value.toDouble())
	}

	/**
	 * Creates a handle which contains a toBoolean JavaScript handle.
	 * @method createBoolean
	 * @since 0.1.0
	 */
	open fun createBoolean(value: Boolean): JavaScriptValue {
		return JavaScriptValue.createBoolean(this, value)
	}

	/**
	 * Creates a handle which contains an empty JavaScript object.
	 * @method createEmptyObject
	 * @since 0.1.0
	 */
	open fun createEmptyObject(): JavaScriptValue {
		return JavaScriptValue.createEmptyObject(this)
	}

	/**
	 * Creates a handle which contains an empty JavaScript array.
	 * @method createEmptyArray
	 * @since 0.1.0
	 */
	open fun createEmptyArray(): JavaScriptValue {
		return JavaScriptValue.createEmptyArray(this)
	}

	/**
	 * Creates a toValue bound to a native function.
	 * @method createFunction
	 * @since 0.1.0
	 */
	open fun createFunction(value: JavaScriptFunctionHandler): JavaScriptValue {
		return JavaScriptValue.createFunction(this, value)
	}

	/**
	 * Creates a toValue bound to a native function.
	 * @method createFunction
	 * @since 0.1.0
	 */
	open fun createFunction(name: String, value: JavaScriptFunctionHandler): JavaScriptValue {
		return JavaScriptValue.createFunction(this, value, name)
	}

	/**
	 * Creates a toValue bound to an object template instance.
	 * @method createObject
	 * @since 0.1.0
	 */
	open fun createObject(template: Class<*>): JavaScriptValue {
		return JavaScriptValue.createObject(this, template)
	}

	/**
	 * Creates a toValue bound to a class template.
	 * @method createClass
	 * @since 0.1.0
	 */
	open fun createClass(template: Class<*>): JavaScriptValue {
		return JavaScriptValue.createClass(this, template)
	}

	/**
	 * Creates an empty return handle.
	 * @method createReturnValue
	 * @since 0.1.0
	 */
	open fun createReturnValue(): JavaScriptValue {
		return JavaScriptValue.createUndefined(this)
	}

	/**
	 * Evaluates JavaScript code.
	 * @method evaluate
	 * @since 0.1.0
	 */
	open fun evaluate(code: String) {
		JavaScriptContextExternal.evaluate(this.handle, code)
	}

	/**
	 * Evaluates JavaScript code with a file indicator.
	 * @method evaluate
	 * @since 0.1.0
	 */
	open fun evaluate(code: String, file: String) {
		JavaScriptContextExternal.evaluate(this.handle, code, file)
	}

	/**
	 * Assigns a custom attribute to this context.
	 * @method attribute
	 * @since 0.1.0
	 */
	open fun attribute(key: Any, value: Any?) {
		val hash = key.hashCode()
		JavaScriptContextExternal.delAttribute(this.handle, hash)
		JavaScriptContextExternal.setAttribute(this.handle, hash, value)
	}

	/**
	 * Returns a custom attribute from this context.
	 * @method attribute
	 * @since 0.1.0
	 */
	open fun attribute(key: Any): Any? {
		return JavaScriptContextExternal.getAttribute(this.handle, key.hashCode())
	}

	/**
	 * Assigns a holder to execute when an error is thrown within this context.
	 * @method handleError
	 * @since 0.6.0
	 */
	open fun handleError(callback: JavaScriptExceptionHandler) {
		JavaScriptContextExternal.setExceptionCallback(this.handle, JavaScriptExceptionWrapper(callback), this)
	}

	/**
	 * Requests a garbage collection.
	 * @method garbageCollect
	 * @since 0.1.0
	 */
	open fun garbageCollect() {
		JavaScriptContextExternal.garbageCollect(this.handle)
	}
}
