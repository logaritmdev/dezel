package ca.logaritm.dezel.modules.core

import ca.logaritm.dezel.application.activity
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule
import ca.logaritm.dezel.extension.fatalError
import ca.logaritm.dezel.extension.type.let
import ca.logaritm.dezel.modules.application.JavaScriptApplication

/**
 * @class CoreModule
 * @since 0.7.0
 * @hidden
 */
open class CoreModule : JavaScriptModule() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property importClass
	 * @since 0.7.0
	 * @hidden
	 */
	private val importClass = context.createFunction { callback ->

		if (callback.arguments < 1) {
			fatalError("Function importClass() requires 1 argument.")
		}

		val identifier = callback.argument(0).string
		if (identifier == "") {
			return@createFunction
		}

		val result = this.context.classes[identifier]
		if (result != null) {
			callback.returns(result)
		}
	}

	/**
	 * @property importObject
	 * @since 0.7.0
	 * @hidden
	 */
	private val importObject = context.createFunction { callback ->

		if (callback.arguments < 1) {
			fatalError("Function importObject() requires 1 argument.")
		}

		val identifier = callback.argument(0).string
		if (identifier == "") {
			return@createFunction
		}

		val result = this.context.objects[identifier]
		if (result != null) {
			callback.returns(result)
		}
	}

	/**
	 * @property registerApplication
	 * @since 0.7.0
	 * @hidden
	 */
	private val registerApplication = context.createFunction { callback ->

		if (callback.arguments < 2) {
			fatalError("Function registerApplication() requires 2 arguments.")
		}

		val app = callback.argument(0)
		val uid = callback.argument(1).string

		app.cast(JavaScriptApplication::class.java).let {
			this.context.activity.launch(it, uid)
		}
	}
	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	override fun initialize() {
		this.context.global.defineProperty("importClass", this.importClass)
		this.context.global.defineProperty("importObject", this.importObject)
		this.context.global.defineProperty("registerApplication", this.registerApplication)
	}
}