package ca.logaritm.dezel.modules.core

import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module
import ca.logaritm.dezel.modules.application.Application

/**
 * @class CoreModule
 * @since 0.7.0
 * @hidden
 */
open class CoreModule(context: JavaScriptContext) : Module(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property importClass
	 * @since 0.7.0
	 * @hidden
	 */
	private val importClass = context.createFunction { callback ->
		val result = this.context.classes[callback.argument(0).string]
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
		val result = this.context.objects[callback.argument(0).string]
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

		val app = callback.argument(0)
		val uid = callback.argument(1).string

		val application = app.cast(Application::class.java)
		if (application != null) {
			this.context.application.launch(application, uid)
		}
	}
	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.global.defineProperty("importClass", this.importClass)
		this.context.global.defineProperty("importObject", this.importObject)
		this.context.global.defineProperty("registerApplication", this.registerApplication)
	}
}