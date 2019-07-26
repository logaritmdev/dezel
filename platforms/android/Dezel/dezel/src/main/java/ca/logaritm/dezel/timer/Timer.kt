package ca.logaritm.dezel.timer

import android.os.Handler
import android.os.Looper

/**
 * Fires a callbac after a time interval.
 * @class Ticker
 * @since 0.7.0
 */
open class Timer(target: Ticker, interval: Double, repeated: Boolean) {

	/**
	 * @property target
	 * @since 0.7.0
	 * @hidden
	 */
	private val target: Ticker

	/**
	 * @property interval
	 * @since 0.7.0
	 * @hidden
	 */
	private val interval: Double

	/**
	 * @property repeated
	 * @since 0.7.0
	 * @hidden
	 */
	private val repeated: Boolean

	/**
	 * @property handler
	 * @since 0.7.0
	 * @hidden
	 */
	private val handler: Handler = Handler()

	/**
	 * @property invalidated
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidated: Boolean = false

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {

		this.target = target
		this.interval = interval
		this.repeated = repeated

		val run = object: Runnable {

			override fun run() {

				if (invalidated) {
					return
				}

				target.onTick()

				if (repeated) {
					handler.postDelayed(this, interval.toLong())
				}
			}
		}

		this.handler.postDelayed(run, this.interval.toLong())
	}

	/**
	 * @method invalidate
	 * @since 0.7.0
	 * @hidden
	 */
	public fun invalidate() {
		this.invalidated = true
	}
}
