package ca.logaritm.dezel.view

import android.view.Choreographer

/**
 * @class UpdateDisplayManager
 * @since 0.2.0
 */
public class UpdateDisplayManager {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property scheduled
	 * @since 0.2.0
	 * @hidden
	 */
	private var scheduled: Boolean = false

	/**
	 * @property callbacks
	 * @since 0.2.0
	 * @hidden
	 */
	private var callbacks: MutableList<UpdateDisplayCallback> = mutableListOf()

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.2.0
	 */
	init {

	}

	/**
	 * Schedules an update display callback.
	 * @method schedule
	 * @since 0.2.0
	 */
	public fun schedule(callback: UpdateDisplayCallback) {

		if (this.scheduled == false) {
			this.scheduled = true
			Choreographer.getInstance().postFrameCallback {
				this.dispatch()
			}
		}

		this.callbacks.add(callback)
	}

	/**
	 * Dispatches update display callbacks.
	 * @method dispatch
	 * @since 0.2.0
	 */
	public fun dispatch() {

		if (this.scheduled == false) {
			return
		}

		var index = 0

		/*
		 * A dispatch call might invalidate another view that needs its display
		 * updated on this pass therefore we must loop through this way. It might
		 * be a good idea to look for infinite loop in the future.
		 */

		while (index < this.callbacks.size) {
			this.callbacks[index].performUpdate()
			index++
		}

		this.callbacks = mutableListOf()
		this.scheduled = false
	}

	/**
	 * Cancels a scheduled callback.
	 * @method cancel
	 * @since 0.5.0
	 */
	public fun cancel(callback: UpdateDisplayCallback) {
		this.callbacks.remove(callback)
	}

	/**
	 * Resets the update display manager.
	 * @method reset
	 * @since 0.2.0
	 */
	public fun reset() {
		this.callbacks = mutableListOf()
		this.scheduled = false
	}
}