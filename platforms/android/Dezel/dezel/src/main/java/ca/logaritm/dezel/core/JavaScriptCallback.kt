package ca.logaritm.dezel.core

import ca.logaritm.dezel.core.external.JavaScriptValueExternal

/**
 * @class JavaScriptCallback
 * @since 0.1.0
 */
open class JavaScriptCallback(context: JavaScriptContext, target: Long, callee: Long, argc: Int, argv: LongArray) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property context
	 * @since 0.1.0
	 */
	public var context: JavaScriptContext
		private set

	/**
	 * @property target
	 * @since 0.1.0
	 */
	public val target: JavaScriptValue by lazy {
		JavaScriptValue.create(context, this.callbackTarget, false)
	}

	/**
	 * @property callee
	 * @since 0.1.0
	 */
	public val callee: JavaScriptValue by lazy {
		JavaScriptValue.create(context, this.callbackCallee, false)
	}

	/**
	 * @property arguments
	 * @since 0.1.0
	 */
	public var arguments: Int
		private set

	/**
	 * @property argc
	 * @since 0.1.0
	 * @hidden
	 */
	internal var argc: Int
		private set

	/**
	 * @property argv
	 * @since 0.1.0
	 * @hidden
	 */
	internal var argv: LongArray
		private set

	/**
	 * @property result
	 * @since 0.1.0
	 * @hidden
	 */
	internal var result: Long = 0
		private set

	/**
	 * @property callbackTarget
	 * @since 0.2.0
	 * @hidden
	 */
	private var callbackTarget: Long = 0

	/**
	 * @property callbackCallee
	 * @since 0.2.0
	 * @hidden
	 */
	private var callbackCallee: Long = 0

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {

		this.context = context

		this.callbackTarget = target
		this.callbackCallee = callee
		this.arguments = argc

		this.argc = argc
		this.argv = argv
	}

	/**
	 * @method returns
	 * @since 0.1.0
	 */
	public fun returns(value: JavaScriptValue?) {
		this.result = toJs(value, this.context)
	}

	/**
	 * @method returns
	 * @since 0.1.0
	 */
	public fun returns(property: JavaScriptProperty) {
		this.result = toJs(property, this.context)
	}

	/**
	 * @method returns
	 * @since 0.1.0
	 */
	public fun returns(string: String) {
		this.result = JavaScriptValueExternal.createString(this.context.handle, string)
	}

	/**
	 * @method returns
	 * @since 0.1.0
	 */
	public fun returns(number: Double) {
		this.result = JavaScriptValueExternal.createNumber(this.context.handle, number)
	}

	/**
	 * @method returns
	 * @since 0.3.0
	 */
	public fun returns(number: Float) {
		this.result = JavaScriptValueExternal.createNumber(this.context.handle, number.toDouble())
	}

	/**
	 * @method returns
	 * @since 0.3.0
	 */
	public fun returns(number: Int) {
		this.result = JavaScriptValueExternal.createNumber(this.context.handle, number.toDouble())
	}

	/**
	 * @method returns
	 * @since 0.1.0
	 */
	public fun returns(boolean: Boolean) {
		this.result = JavaScriptValueExternal.createBoolean(this.context.handle, boolean)
	}
}