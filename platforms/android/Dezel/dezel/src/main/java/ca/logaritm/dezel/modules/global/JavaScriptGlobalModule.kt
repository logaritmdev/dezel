package ca.logaritm.dezel.modules.global


import android.util.Log
import android.view.Choreographer
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.core.JavaScriptModule
import ca.logaritm.dezel.core.JavaScriptValue
import ca.logaritm.dezel.extension.fatalError
import ca.logaritm.dezel.util.timer.Ticker
import ca.logaritm.dezel.util.timer.Timer
import kotlin.math.max

/**
 * @class GlobalModule
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptGlobalModule: JavaScriptModule() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property scheduledTimers
	 * @since 0.7.0
	 * @hidden
	 */
	private var scheduledTimers: MutableMap<Double, ScheduledTimer> = mutableMapOf()

	/**
	 * @property scheduledFrames
	 * @since 0.7.0
	 * @hidden
	 */
	private var scheduledFrames: MutableMap<Double, ScheduledFrame> = mutableMapOf()

	/**
	 * @property scheduledTimersTotal
	 * @since 0.7.0
	 * @hidden
	 */
	private var scheduledTimersTotal: Double = 0.0

	/**
	 * @property scheduledFramesTotal
	 * @since 0.7.0
	 * @hidden
	 */
	private var scheduledFramesTotal: Double = 0.0

	/**
	 * @property scheduledFrameRequested
	 * @since 0.7.0
	 * @hidden
	 */
	private var scheduledFrameRequested: Boolean = false

	/**
	 * @property scheduledFrameCallback
	 * @since 0.7.0
	 * @hidden
	 */
	private val scheduledFrameCallback: Choreographer.FrameCallback = Choreographer.FrameCallback {

		val frames = this.scheduledFrames

		this.scheduledFrames = mutableMapOf()
		this.scheduledFrameRequested = false

		for ((_, frame) in frames) {
			frame.execute()
		}
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	override fun configure(context: JavaScriptContext) {

		context.registerClass("dezel.global.WebSocket", JavaScriptWebSocket::class.java)
		context.registerClass("dezel.global.XMLHttpRequest", JavaScriptXMLHttpRequest::class.java)

		context.global.defineProperty("setImmediate", context.createFunction { callback -> this.setImmediate(callback) })
		context.global.defineProperty("setInterval", context.createFunction { callback -> this.setInterval(callback) })
		context.global.defineProperty("setTimeout", context.createFunction { callback -> this.setTimeout(callback) })
		context.global.defineProperty("clearImmediate", context.createFunction { callback -> this.clearImmediate(callback) })
		context.global.defineProperty("clearInterval", context.createFunction { callback -> this.clearInterval(callback) })
		context.global.defineProperty("clearTimeout", context.createFunction { callback -> this.clearTimeout(callback) })
		context.global.defineProperty("requestAnimationFrame", context.createFunction { callback -> this.requestAnimationFrame(callback) })
		context.global.defineProperty("cancelAnimationFrame", context.createFunction { callback -> this.cancelAnimationFrame(callback) })

		context.global.defineProperty("LOG", context.createFunction { callback ->
			Log.e("DEZEL", callback.argument(0).string)
		})
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method scheduleInterval
	 * @since 0.7.0
	 * @hidden
	 */
	private fun scheduleInterval(callback: JavaScriptValue, interval: Double): Double {
		this.scheduledTimersTotal += 1
		this.scheduledTimers[this.scheduledTimersTotal] = ScheduledTimer(callback, interval, true, this, this.scheduledTimersTotal)
		return this.scheduledTimersTotal
	}

	/**
	 * @method scheduleTimeout
	 * @since 0.7.0
	 * @hidden
	 */
	private fun scheduleTimeout(callback: JavaScriptValue, interval: Double): Double {
		this.scheduledTimersTotal += 1
		this.scheduledTimers[this.scheduledTimersTotal] = ScheduledTimer(callback, interval, false, this, this.scheduledTimersTotal)
		return this.scheduledTimersTotal
	}

	/**
	 * @method scheduleFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private fun scheduleFrame(callback: JavaScriptValue): Double {
		this.scheduledFramesTotal += 1
		this.scheduledFrames[this.scheduledFramesTotal] = ScheduledFrame(callback)
		return this.scheduledFramesTotal
	}

	/**
	 * @method removeTimer
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeTimer(identifier: Double) {
		this.scheduledTimers[identifier]?.cancel()
		this.scheduledTimers.remove(identifier)
	}

	/**
	 * @method removeFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeFrame(identifier: Double) {
		this.scheduledFrames[identifier]?.cancel()
		this.scheduledFrames.remove(identifier)
	}

	/**
	 * @property setImmediate
	 * @since 0.7.0
	 * @hidden
	 */
	private fun setImmediate(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Function setImmediate() requires 1 argument.")
		}

		callback.returns(this.scheduleTimeout(callback.argument(0), 0.0))
	}

	/**
	 * @property setInterval
	 * @since 0.7.0
	 * @hidden
	 */
	private fun setInterval(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Function setInterval() requires at least 1 argument.")
		}

		if (callback.arguments == 1) {
			callback.returns(this.scheduleInterval(callback.argument(0), 10.0))
			return
		}

		if (callback.arguments == 2) {

			val function = callback.argument(0)
			val interval = callback.argument(1).number

			callback.returns(this.scheduleInterval(function, max(10.0, interval)))

			return
		}
	}

	/**
	 * @property setTimeout
	 * @since 0.7.0
	 * @hidden
	 */
	private fun setTimeout(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Function setTimeout() requires at least 1 argument.")
		}

		if (callback.arguments == 1) {
			callback.returns(this.scheduleTimeout(callback.argument(0), 0.0))
			return
		}

		if (callback.arguments == 2) {
			callback.returns(this.scheduleTimeout(callback.argument(0), callback.argument(1).number))
			return
		}
	}

	/**
	 * @property clearImmediate
	 * @since 0.7.0
	 * @hidden
	 */
	private fun clearImmediate(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Function clearImmediate() requires 1 argument.")
		}

		this.removeTimer(callback.argument(0).number)
	}

	/**
	 * @property clearTimeout
	 * @since 0.7.0
	 * @hidden
	 */
	private fun clearTimeout(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Function clearImmediate() requires 1 argument.")
		}

		this.removeTimer(callback.argument(0).number)
	}

	/**
	 * @property clearInterval
	 * @since 0.7.0
	 * @hidden
	 */
	private fun clearInterval(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Function clearInterval() requires 1 argument.")
		}

		this.removeTimer(callback.argument(0).number)
	}

	/**
	 * @property requestAnimationFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private fun requestAnimationFrame(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Function requestAnimationFrame() requires 1 argument.")
		}

		if (this.scheduledFrameRequested == false) {
			this.scheduledFrameRequested = true
			Choreographer.getInstance().postFrameCallback(this.scheduledFrameCallback)
		}

		callback.returns(this.scheduleFrame(callback.argument(0)))
	}

	/**
	 * @property cancelAnimationFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private fun cancelAnimationFrame(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Function cancelAnimationFrame() requires 1 argument.")
		}

		this.removeFrame(callback.argument(0).number)
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class ScheduledTimer
	 * @since 0.7.0
	 * @hidden
	 */
	private class ScheduledTimer(callback: JavaScriptValue, interval: Double, repeated: Boolean, module: JavaScriptGlobalModule, handle: Double): Ticker {

		/**
		 * @property callback
		 * @since 0.7.0
		 * @hidden
		 */
		private var callback: JavaScriptValue

		/**
		 * @property interval
		 * @since 0.7.0
		 * @hidden
		 */
		private var interval: Double

		/**
		 * @property repeated
		 * @since 0.7.0
		 * @hidden
		 */
		private var repeated: Boolean

		/**
		 * @property module
		 * @since 0.7.0
		 * @hidden
		 */
		private var module: JavaScriptGlobalModule

		/**
		 * @property handle
		 * @since 0.7.0
		 * @hidden
		 */
		private var handle: Double

		/**
		 * @property timer
		 * @since 0.7.0
		 * @hidden
		 */
		private var timer: Timer?

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		init {

			this.callback = callback
			this.interval = interval
			this.repeated = repeated
			this.module = module
			this.handle = handle

			this.callback.protect()

			this.timer = Timer(this, interval, repeated)
		}

		/**
		 * @method execute
		 * @since 0.7.0
		 */
		public fun execute() {

			this.callback.call()

			if (this.repeated == false) {
				this.cancel()
				this.remove()
			}
		}

		/**
		 * @method cancel
		 * @since 0.7.0
		 */
		public fun cancel() {
			this.callback.unprotect()
			this.timer?.invalidate()
			this.timer = null
		}

		/**
		 * @method remove
		 * @since 0.7.0
		 */
		public fun remove() {
			this.module.scheduledTimers.remove(this.handle)
		}

		/**
		 * @method onTick
		 * @since 0.7.0
		 */
		override fun onTick() {
			this.execute()
		}		
	}

	/**
	 * @struct ScheduledFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private class ScheduledFrame(callback: JavaScriptValue) {

		/**
		 * @property callback
		 * @since 0.7.0
		 * @hidden
		 */
		private var callback: JavaScriptValue

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		init {
			this.callback = callback
			this.callback.protect()
		}

		/**
		 * @method invalidate
		 * @since 0.7.0
		 */
		public fun execute() {
			this.callback.call()
			this.callback.unprotect()
		}

		/**
		 * @method cancel
		 * @since 0.7.0
		 */
		public fun cancel() {
			this.callback.unprotect()
		}
	}	
}