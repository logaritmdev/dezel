package ca.logaritm.dezel.modules.global


import android.content.BroadcastReceiver
import android.util.Log
import android.view.Choreographer
import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptValue
import ca.logaritm.dezel.core.Module
import ca.logaritm.dezel.modules.application.Application
import ca.logaritm.dezel.timer.Ticker
import ca.logaritm.dezel.timer.Timer

/**
 * @class GlobalModule
 * @since 0.7.0
 * @hidden
 */
open class GlobalModule(context: JavaScriptContext) : Module(context) {

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

	/**
	 * @property setInterval
	 * @since 0.7.0
	 * @hidden
	 */
	private val setImmediate = context.createFunction { callback ->

		val count = callback.arguments
		if (count < 1) {
			throw Exception("Failed to execute 'setImmediate': 1 argument required but only $count present.")
		}

		callback.returns(this.scheduleTimeout(callback.argument(0), 0.0))
	}

	/**
	 * @property setInterval
	 * @since 0.7.0
	 * @hidden
	 */
	private val setInterval = context.createFunction { callback ->

		val count = callback.arguments
		if (count < 1) {
			throw Exception("Failed to execute 'setInterval': 1 argument required but only $count present.")
		}

		var delay = 10.0
		if (count > 1) {
			delay = Math.max(delay, callback.argument(1).number)
		}

		callback.returns(this.scheduleInterval(callback.argument(0), delay))
	}

	/**
	 * @property setTimeout
	 * @since 0.7.0
	 * @hidden
	 */
	private val setTimeout = context.createFunction { callback ->

		val count = callback.arguments
		if (count < 1) {
			throw Exception("Failed to execute 'setTimeout': 2 arguments required but only $count present.")
		}

		if (count == 1) {
			callback.returns(this.scheduleTimeout(callback.argument(0), 0.0))
		} else {
			callback.returns(this.scheduleTimeout(callback.argument(0), callback.argument(1).number))
		}
	}

	/**
	 * @property clearImmediate
	 * @since 0.7.0
	 * @hidden
	 */
	private val clearImmediate = context.createFunction { callback ->

		val count = callback.arguments
		if (count < 1) {
			throw Exception("Failed to execute 'clearImmediate': 1 argument required but only $count present.")
		}

		this.removeTimer(callback.argument(0).number)
	}

	/**
	 * @property clearInterval
	 * @since 0.7.0
	 * @hidden
	 */
	private val clearInterval = context.createFunction { callback ->

		val count = callback.arguments
		if (count < 1) {
			throw Exception("Failed to execute 'clearInterval': 1 argument required but only $count present.")
		}

		this.removeTimer(callback.argument(0).number)
	}

	/**
	 * @property clearTimeout
	 * @since 0.7.0
	 * @hidden
	 */
	private val clearTimeout = context.createFunction("clearTimeout") { callback ->

		val count = callback.arguments
		if (count < 1) {
			throw Exception("Failed to execute 'clearTimeout': 1 argument required but only $count present.")
		}

		this.removeTimer(callback.argument(0).number)
	}

	/**
	 * @property requestAnimationFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private val requestAnimationFrame = context.createFunction { callback ->

		val count = callback.arguments
		if (count < 2) {
			throw Exception("Failed to execute 'requestAnimationFrame': 2 arguments required but only $count present.")
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
	private val cancelAnimationFrame = context.createFunction { callback ->

		val count = callback.arguments
		if (count < 1) {
			throw Exception("Failed to execute 'cancelAnimationFrame': 1 argument required but only $count present.")
		}

		this.removeFrame(callback.argument(0).number)
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.7.0
	 */
	override fun initialize() {

		this.context.registerClass("dezel.global.WebSocket", JavaScriptWebSocket::class.java)
		this.context.registerClass("dezel.global.XMLHttpRequest", JavaScriptXMLHttpRequest::class.java)

		this.context.global.defineProperty("setImmediate", this.setImmediate)
		this.context.global.defineProperty("setInterval", this.setInterval)
		this.context.global.defineProperty("setTimeout", this.setTimeout)
		this.context.global.defineProperty("clearImmediate", this.clearImmediate)
		this.context.global.defineProperty("clearInterval", this.clearInterval)
		this.context.global.defineProperty("clearTimeout", this.clearTimeout)
		this.context.global.defineProperty("requestAnimationFrame", this.requestAnimationFrame)
		this.context.global.defineProperty("cancelAnimationFrame", this.cancelAnimationFrame)
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.7.0
	 */
	override fun dispose() {

		this.scheduledTimers.forEach { it.value.cancel() }
		this.scheduledFrames.forEach { it.value.cancel() }
		this.scheduledTimers.clear()
		this.scheduledFrames.clear()

		super.dispose()
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

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class ScheduledTimer
	 * @since 0.7.0
	 */
	private class ScheduledTimer(callback: JavaScriptValue, interval: Double, repeated: Boolean, module: GlobalModule, handle: Double): Ticker {

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
		private var module: GlobalModule

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
		 * @hidden
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
		 * @hidden
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
		 * @hidden
		 */
		public fun cancel() {
			this.callback.unprotect()
			this.timer?.invalidate()
			this.timer = null
		}

		/**
		 * @method remove
		 * @since 0.7.0
		 * @hidden
		 */
		public fun remove() {
			this.module.scheduledTimers.remove(this.handle)
		}

		/**
		 * @method onTick
		 * @since 0.7.0
		 * @hidden
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
		 * @hidden
		 */
		init {
			this.callback = callback
			this.callback.protect()
		}

		/**
		 * @method invalidate
		 * @since 0.7.0
		 * @hidden
		 */
		public fun execute() {
			this.callback.call()
			this.callback.unprotect()
		}

		/**
		 * @method cancel
		 * @since 0.7.0
		 * @hidden
		 */
		public fun cancel() {
			this.callback.unprotect()
		}
	}	
}