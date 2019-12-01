package ca.logaritm.dezel.view

import android.view.Choreographer
import java.lang.ref.WeakReference

/**
 * @class Synchronizer
 * @since 0.7.0
 */
public class Synchronizer {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @property main
		 * @sine 0.7.0
		 */
		public val main: Synchronizer = Synchronizer()
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property scheduled
	 * @since 0.7.0
	 * @hidden
	 */
	private var scheduled: Boolean = false

	/**
	 * @property callbacks
	 * @since 0.7.0
	 * @hidden
	 */
	private var callbacks: MutableList<WeakReference<SynchronizerCallback>> = mutableListOf()

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method schedule
	 * @since 0.7.0
	 */
	public fun schedule(callback: SynchronizerCallback) {

		if (this.scheduled == false) {
			this.scheduled = true
			Choreographer.getInstance().postFrameCallback {
				this.execute()
			}
		}

		this.callbacks.add(WeakReference(callback))
	}

	/**
	 * @method execute
	 * @since 0.7.0
	 */
	public fun execute() {

		if (this.scheduled == false) {
			return
		}

		var index = 0

		/*
		 * A execute call might invalidate another view that needs its display
		 * updated on this pass therefore we must loop through this way. It might
		 * be a good idea to look for infinite loop in the future.
		 */

		while (index < this.callbacks.size) {

			val callback = this.callbacks[index].get()
			if (callback != null) {
				callback.performUpdate()
			}

			index++
		}

		this.callbacks = mutableListOf()
		this.scheduled = false
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public fun reset() {
		this.callbacks = mutableListOf()
		this.scheduled = false
	}
}