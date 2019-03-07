package ca.logaritm.dezel.modules.web

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Handler
import android.support.v4.content.LocalBroadcastManager
import android.view.Choreographer
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.core.JavaScriptValue

/**
 * @class WebGlobal
 * @since 0.1.0
 * @hidden
 */
open class WebGlobal(context: JavaScriptContext): JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property scheduledTimers
	 * @since 0.1.0
	 * @hidden
	 */
	private var scheduledTimers: MutableMap<Double, ScheduledTimer> = mutableMapOf()

	/**
	 * @property scheduledFrames
	 * @since 0.1.0
	 * @hidden
	 */
	private var scheduledFrames: MutableMap<Double, JavaScriptValue> = mutableMapOf()

	/**
	 * @property scheduledTimersTotal
	 * @since 0.1.0
	 * @hidden
	 */
	private var scheduledTimersTotal: Double = 0.0

	/**
	 * @property scheduledFramesTotal
	 * @since 0.1.0
	 * @hidden
	 */
	private var scheduledFramesTotal: Double = 0.0

	/**
	 * @property scheduledFrameRequested
	 * @since 0.1.0
	 * @hidden
	 */
	private var scheduledFrameRequested: Boolean = false

	/**
	 * @property scheduledFrameCallback
	 * @since 0.1.0
	 * @hidden
	 */
	private val scheduledFrameCallback: Choreographer.FrameCallback = Choreographer.FrameCallback {

		val values = this.scheduledFrames

		this.scheduledFrames = mutableMapOf()
		this.scheduledFrameRequested = false

		for ((_, value) in values) {
			value.call()
			value.unprotect()
		}
	}

	/**
	 * @property applicationReloadReceiver
	 * @since 0.5.0
	 * @hidden
	 */
	private val applicationReloadReceiver: BroadcastReceiver = object : BroadcastReceiver() {
		override fun onReceive(context: Context, intent: Intent) {
			this@WebGlobal.scheduledTimers.forEach { it.value.timer.invalidate() }
			this@WebGlobal.scheduledTimers.clear()
			this@WebGlobal.scheduledFrames.forEach { it.value.unprotect() }
			this@WebGlobal.scheduledFrames.clear()
		}
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.5.0
	 */
	init {
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.applicationReloadReceiver, IntentFilter("dezel.application.RELOAD"))
	}

	/**
	 * @destructor
	 * @since 0.5.0
	 */
	@Throws(Throwable::class)
	protected fun finalize() {
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.applicationReloadReceiver)
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_setImmediate
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_setImmediate(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		callback.returns(this.scheduleTimeout(callback.argument(0), 0.0))
	}

	/**
	 * @method jsFunction_setInterval
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_setInterval(callback: JavaScriptFunctionCallback) {

		val count = callback.arguments
		if (count == 0) {
			return
		}

		var delay = 10.0
		if (count > 1) {
			delay = Math.max(delay, callback.argument(1).number)
		}

		callback.returns(this.scheduleInterval(callback.argument(0), delay))
	}

	/**
	 * @method jsFunction_setTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_setTimeout(callback: JavaScriptFunctionCallback) {

		val count = callback.arguments
			if (count == 0) {
				return
			}

		val fn = callback.argument(0)

		if (count == 1) {
			callback.returns(this.scheduleTimeout(fn, 0.0))
		} else {
			callback.returns(this.scheduleTimeout(fn, callback.argument(1).number))
		}
	}

	/**
	 * @method jsFunction_clearImmediate
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_clearImmediate(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		this.clearTimers(callback.argument(0).number)
	}

	/**
	 * @method jsFunction_clearTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_clearTimeout(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		this.clearTimers(callback.argument(0).number)
	}

	/**
	 * @method jsFunction_clearInterval
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_clearInterval(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		this.clearTimers(callback.argument(0).number)
	}

	/**
	 * @method jsFunction_requestAnimationFrame
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_requestAnimationFrame(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		if (this.scheduledFrameRequested == false) {
			this.scheduledFrameRequested = true
			Choreographer.getInstance().postFrameCallback(this.scheduledFrameCallback)
		}

		this.scheduledFramesTotal += 1

		val value = callback.argument(0)
		value.protect()
		this.scheduledFrames[this.scheduledFramesTotal] = value

		callback.returns(this.scheduledFramesTotal)
	}

	/**
	 * @method jsFunction_cancelAnimationFrame
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_cancelAnimationFrame(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			return
		}

		val identifier = callback.argument(0).number

		val value = this.scheduledFrames[identifier]
		if (value != null) {
			value.unprotect()
		}

		this.scheduledFrames.remove(identifier)
	}

	//--------------------------------------------------------------------------
	// JavaScriptCallback API
	//--------------------------------------------------------------------------

	/**
	 * @method scheduledTimerInterval
	 * @since 0.1.0
	 * @hidden
	 */
	private fun scheduledTimerInterval(timer: Timer) {
		this.scheduledTimers[timer.identifier]?.value?.call()
	}

	/**
	 * @method scheduledTimerTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	private fun scheduledTimerTimeout(timer: Timer) {

		val scheduledTimer = this.scheduledTimers[timer.identifier]
		if (scheduledTimer == null) {
			return
		}

		scheduledTimer.value.call()
		scheduledTimer.value.unprotect()

		this.scheduledTimers.remove(timer.identifier)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method scheduleInterval
	 * @since 0.1.0
	 * @hidden
	 */
	private fun scheduleInterval(callback: JavaScriptValue, ms: Double): Double {

		this.scheduledTimersTotal += 1

		callback.protect()

		this.scheduledTimers[this.scheduledTimersTotal] = ScheduledTimer(
			Timer(ms, this.scheduledTimersTotal, true),
			callback
		)

		return this.scheduledTimersTotal
	}

	/**
	 * @method scheduleTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	private fun scheduleTimeout(callback: JavaScriptValue, ms: Double): Double {

		this.scheduledTimersTotal += 1

		callback.protect()

		this.scheduledTimers[this.scheduledTimersTotal] = ScheduledTimer(
			Timer(ms, this.scheduledTimersTotal, false),
			callback
		)

		return this.scheduledTimersTotal
	}

	/**
	 * @method clearTimers
	 * @since 0.1.0
	 * @hidden
	 */
	private fun clearTimers(identifier: Double) {
		this.scheduledTimers.remove(identifier)
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class Timer
	 * @since 0.1.0
	 * @hidden
	 */
	private inner class Timer(val interval: Double, val identifier: Double, val repeat: Boolean) {

		/**
		 * @property handler
		 * @since 0.1.0
		 * @hidden
		 */
		private val handler: Handler = Handler()

		/**
		 * @property invalidated
		 * @since 0.1.0
		 * @hidden
		 */
		private var invalidated: Boolean = false

		/**
		 * @constructor
		 * @since 0.1.0
		 */
		init {

			val run = object: Runnable {

				override fun run() {

					if (invalidated) {
						return
					}

					if (repeat) {
						scheduledTimerInterval(this@Timer)
					} else {
						scheduledTimerTimeout(this@Timer)
					}

					if (repeat) {
						handler.postDelayed(this, interval.toLong())
					}
				}
			}

			this.handler.postDelayed(run, this.interval.toLong())
		}

		/**
		 * @method invalidate
		 * @since 0.1.0
		 * @hidden
		 */
		public fun invalidate() {
			this.invalidated = true
		}
	}

	/**
	 * @class ScheduledTimer
	 * @since 0.1.0
	 */
	private data class ScheduledTimer(val timer: Timer, val value: JavaScriptValue)
}
