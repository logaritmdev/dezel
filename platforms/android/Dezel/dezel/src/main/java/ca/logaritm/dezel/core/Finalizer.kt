package ca.logaritm.dezel.core

import java.lang.ref.ReferenceQueue

/**
 * @class Finalizer
 * @since 0.4.0
 * @hidden
 */
public class Finalizer: Thread() {

	companion object {

		/**
		 * The actual reference queue.
		 * @property queue
		 * @since 0.4.0
		 */
		public val queue: ReferenceQueue<Any> = ReferenceQueue()

		/**
		 * @property main
		 * @since 0.4.0
		 * @hidden
		 */
		private var main: Finalizer = Finalizer()

		/**
		 * @constructor
		 * @since 0.4.0
		 * @hidden
		 */
		init {
			this.main = Finalizer()
			this.main.start()
		}
	}

	/**
	 * @inherited
	 * @method run
	 * @since 0.4.0
	 */
	override fun run() {

		while (Thread.interrupted() == false) {

			try {

				queue.remove().let {

					if (it is FinalizableReference) {
						it.finally()
					}

					it.clear()
				}

			} catch (e: InterruptedException) {
				// Interrupted
			}
		}
	}
}