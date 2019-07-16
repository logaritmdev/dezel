package ca.logaritm.dezel.modules.dezel

import android.util.Log
import android.view.animation.PathInterpolator
import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptContextExternal
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.core.JavaScriptObject
import ca.logaritm.dezel.view.animation.Transition

/**
 * @class Dezel
 * @since 0.1.0
 */
open class Dezel(context: JavaScriptContext) : JavaScriptObject(context) {

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_log
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_log(callback: JavaScriptFunctionCallback) {

		val count = callback.arguments
		if (count == 0) {
			return
		}

		val string = StringBuilder()

		for (i in 0 until count) {
			string.append(callback.argument(i).string)
			string.append(" ")
		}

		Log.i("DEZEL", "Log: " + string.toString())
	}

	/**
	 * @method jsFunction_dir
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_dir(callback: JavaScriptFunctionCallback) {

		val count = callback.arguments
		if (count == 0) {
			return
		}

		val string = StringBuilder()

		for (i in 0 until count) {
			string.append(callback.argument(i).string)
			string.append(" ")
		}

		Log.i("DEZEL", "Log: " + string.toString())
	}

	/**
	 * @method jsFunction_imports
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_imports(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			throw Exception("Function dezel.imports needs 1 argument.")
		}

		val ident = callback.argument(0).string

		val obj = this.context.objects[ident]
		if (obj != null) {
			callback.returns(obj)
			return
		}

		val cls = this.context.classes[ident]
		if (cls != null) {
			callback.returns(cls)
			return
		}

		Log.e("DEZEL", "Unable to import $ident")
	}

	/**
	 * @method jsFunction_throwError
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_throwError(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			return
		}

		JavaScriptContextExternal.throwError(this.context.handle, callback.argument(0).handle)
	}

	/**
	 * @method jsFunction_transition
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_transition(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 8) {
			return
		}

		val activity = callback.context.application

		val duration = callback.argument(0).number
		val equation = PathInterpolator(
			callback.argument(1).number.toFloat(),
			callback.argument(2).number.toFloat(),
			callback.argument(3).number.toFloat(),
			callback.argument(4).number.toFloat()
		)

		val delay = callback.argument(5).number

		val complete = callback.argument(6)
		val function = callback.argument(7)

		val animate = {

			Transition.create(
				activity,
				duration,
				equation,
				delay
			)

			function.call()
			complete.protect()

			Transition.commit {
				complete.call()
				complete.unprotect()
			}
		}

		if (this.context.application.layout.resolving) {
			this.context.application.layout.requestLayoutEndedCallback(animate)
			return
		}

		animate()
	}

	/**
	 * @method jsFunction_reload
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_reload(callback: JavaScriptFunctionCallback) {
		Log.i("DEZEL", "Reloading application")
		this.context.application.reload()
	}
}
