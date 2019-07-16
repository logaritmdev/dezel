package ca.logaritm.dezel.core

import android.util.Log
import ca.logaritm.dezel.BuildConfig
import ca.logaritm.dezel.application.ApplicationActivity

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
	 * The null JavaScript value.
	 * @const jsnull
	 * @since 0.7.0
	 */
	public val jsnull: JavaScriptValue by lazy {
		this.createNull()
	}

	/**
	 * The undefined JavaScript value.
	 * @const jsundefined
	 * @since 0.7.0
	 */
	public val jsundefined: JavaScriptValue by lazy {
		this.createUndefined()
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
	 * The context's console.
	 * @property console
	 * @since 0.4.0
	 */
	public val console: JavaScriptConsole by lazy {
		JavaScriptConsole(this)
	}

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

		val code = """

			self = this;
			global = this;
			window = this;

			(function() {

				var log = console.log.bind(console);

				console.log = function() {
					log.apply(this, arguments)
					dezel.log.apply(dezel, arguments)
				};

			})();

			const __throwError = function(error) {
				throw (typeof error == 'string' ? new Error(error) : error)
			}

		"""

		this.evaluate(code)
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
	open fun registerModule(uid: String, value: Class<*>) {
		this.modules[uid] = Module.create(value, this)
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
	 * Creates a handle which contains a string JavaScript handle.
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
	 * Creates a handle which contains a numeric JavaScript handle with a specific unit.
	 * @method createNumber
	 * @since 0.2.0
	 */
	open fun createNumber(value: Double, unit: PropertyUnit): JavaScriptValue {
		return when (unit) {
			PropertyUnit.PX -> JavaScriptValue.createNumber(this, value)
			PropertyUnit.PC -> JavaScriptValue.createString(this, Conversion.ntos(value) + "%")
			PropertyUnit.VW -> JavaScriptValue.createString(this, Conversion.ntos(value) + "vw")
			PropertyUnit.VH -> JavaScriptValue.createString(this, Conversion.ntos(value) + "vh")
			PropertyUnit.PW -> JavaScriptValue.createString(this, Conversion.ntos(value) + "pw")
			PropertyUnit.PH -> JavaScriptValue.createString(this, Conversion.ntos(value) + "ph")
			PropertyUnit.CW -> JavaScriptValue.createString(this, Conversion.ntos(value) + "cw")
			PropertyUnit.CH -> JavaScriptValue.createString(this, Conversion.ntos(value) + "ch")
			PropertyUnit.DEG -> JavaScriptValue.createString(this, Conversion.ntos(value) + "rad")
			PropertyUnit.RAD -> JavaScriptValue.createString(this, Conversion.ntos(value) + "deg")
			else             -> JavaScriptValue.createNumber(this, value)
		}
	}

	/**
	 * Creates a value which contains a numeric JavaScript value.
	 * @method createNumber
	 * @since 0.3.0
	 */
	open fun createNumber(value: Float): JavaScriptValue {
		return JavaScriptValue.createNumber(this, value.toDouble())
	}

	/**
	 * Creates a value which contains a numeric JavaScript value.
	 * @method createNumber
	 * @since 0.3.0
	 */
	open fun createNumber(value: Int): JavaScriptValue {
		return JavaScriptValue.createNumber(this, value.toDouble())
	}

	/**
	 * Creates a handle which contains a boolean JavaScript handle.
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
	 * Creates a value bound to a native function.
	 * @method createFunction
	 * @since 0.1.0
	 */
	open fun createFunction(value: JavaScriptFunctionHandler): JavaScriptValue {
		return JavaScriptValue.createFunction(this, value)
	}

	/**
	 * Creates a value bound to a native function.
	 * @method createFunction
	 * @since 0.1.0
	 */
	open fun createFunction(name: String, value: JavaScriptFunctionHandler): JavaScriptValue {
		return JavaScriptValue.createFunction(this, value, name)
	}

	/**
	 * Creates a value bound to an object template instance.
	 * @method createObject
	 * @since 0.1.0
	 */
	open fun createObject(template: Class<*>): JavaScriptValue {
		return JavaScriptValue.createObject(this, template)
	}

	/**
	 * Creates a value bound to a class template.
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
	open fun attribute(key: String, value: Any?) {
		val hash = key.hashCode()
		JavaScriptContextExternal.delAttribute(this.handle, hash)
		JavaScriptContextExternal.setAttribute(this.handle, hash, value)
	}

	/**
	 * Returns a custom attribute from this context.
	 * @method attribute
	 * @since 0.1.0
	 */
	open fun attribute(key: String): Any? {
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
	 * Throws an error.
	 * @method throwError
	 * @since 0.1.0
	 */
	open fun throwError(error: JavaScriptValue) {
		this.global.callMethod("__throwError", arrayOf(error))
	}

	/**
	 * Throws an error.
	 * @method throwError
	 * @since 0.1.0
	 */
	open fun throwError(string: String) {
		this.global.callMethod("__throwError", arrayOf(this.createString(string)))
	}

	/**
	 * Requests a garbage collection.
	 * @method garbageCollect
	 * @since 0.1.0
	 */
	open fun garbageCollect() {
		JavaScriptContextExternal.garbageCollect(this.handle)
	}

	//--------------------------------------------------------------------------
	// Extensions
	//--------------------------------------------------------------------------

	/**
	 * Convenience property to retrieve the application from the context.
	 * @property application
	 * @since 0.1.0
	 */
	public val application: ApplicationActivity by lazy {
		ApplicationActivity.from(this)
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class Dezel
	 * @since 0.1.0
	 * @hidden
	 */
	public class Dezel(context: JavaScriptContext) : JavaScriptObject(context) {

		/**
		 * @method jsFunction_log
		 * @since 0.1.0
		 * @hidden
		 */
		@Suppress("unused")
		public fun jsFunction_log(callback: JavaScriptFunctionCallback) {

			val count = callback.arguments
			if (count == 0) {
				return
			}

			val string = StringBuilder()

			for (i in 0 until count) {
				string.append(callback.argument(i).string)
				string.append(" ")
			}

			Log.d("DEZEL", "Log: " + string.toString())
		}

		/**
		 * @method jsFunction_import
		 * @since 0.1.0
		 * @hidden
		 */
		@Suppress("unused")
		public fun jsFunction_import(callback: JavaScriptFunctionCallback) {
// TODO
			// REMOVE THIS CHECK CoreModule on iOS
			if (callback.arguments < 1) {
				return
			}

			val ident = callback.argument(0).string

			val value = this.context.objects[ident]
			if (value != null) {
				callback.returns(value)
				return
			}

			val klass = this.context.classes[ident]
			if (klass != null) {
				callback.returns(klass)
				return
			}
		}

		/**
		 * @method jsFunction_throwError
		 * @since 0.1.0
		 * @hidden
		 */
		@Suppress("unused")
		public fun jsFunction_throwError(callback: JavaScriptFunctionCallback) {

			if (callback.arguments < 1) {
				return
			}

			JavaScriptContextExternal.throwError(this.context.handle, callback.argument(0).handle)
		}
	}
}
