package ca.logaritm.dezel.core

import java.lang.ref.ReferenceQueue

/**
 * @class Finalizer
 * @super Thread
 * @since 0.4.0
 */
public class Finalizer: Thread() {

	companion object {

		/**
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
		 */
		init {
			this.main = Finalizer()
			this.main.start()
		}
	}

	/**
	 * @method run
	 * @since 0.4.0
	 */
	override fun run() {

		while (interrupted() == false) {

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