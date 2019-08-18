package ca.logaritm.dezel.core

import android.os.Handler
import android.os.Looper
import java.lang.ref.PhantomReference
import java.lang.ref.ReferenceQueue

/**
 * @class FinalizableReference
 * @since 0.4.0
 * @hidden
 */
abstract class FinalizableReference<T: Any>(referent: T, queue: ReferenceQueue<Any>): PhantomReference<T>(referent, queue) {

	companion object {

		/**
		 * Convenience callback to execute stuff on the main thread.
		 * @property handler
		 * @since 0.4.0
		 */
		public val handler: Handler by lazy {
			Handler(Looper.getMainLooper())
		}
	}

	/**
	 * @method finally
	 * @since 0.4.0
	 * @hidden
	 */
	abstract fun finally()
}