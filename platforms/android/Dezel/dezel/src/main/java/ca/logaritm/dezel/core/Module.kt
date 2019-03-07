package ca.logaritm.dezel.core

/**
 * The base class for context modules.
 * @class Module
 * @since 0.1.0
 */
open class Module(context: JavaScriptContext) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @method create
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun create(module: Class<*>, context: JavaScriptContext): Module {
			return module.asSubclass(Module::class.java).getConstructor(JavaScriptContext::class.java).newInstance(context)
		}
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The module context.
	 * @property context
	 * @since 0.1.0
	 */
	public var context: JavaScriptContext
		private set

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
	 * Initializes the module.
	 * @method initialize
	 * @since 0.1.0
	 */
	open fun initialize() {

	}

	/**
	 * Disposes the module.
	 * @method dispose
	 * @since 0.1.0
	 */
	open fun dispose() {

	}
}
