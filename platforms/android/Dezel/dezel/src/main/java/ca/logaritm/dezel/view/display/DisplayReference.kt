package ca.logaritm.dezel.view.display

import ca.logaritm.dezel.core.FinalizableReference
import ca.logaritm.dezel.core.Finalizer
import ca.logaritm.dezel.view.display.Display
import ca.logaritm.dezel.view.display.DisplayExternal
import java.lang.ref.ReferenceQueue

/**
 * @class DisplayReference
 * @since 0.7.0
 * @hidden
 */
public class DisplayReference(referent: Display, queue: ReferenceQueue<Any>): FinalizableReference<Display>(referent, queue) {

	companion object {

		/**
		 * @property refs
		 * @since 0.7.0
		 * @hidden
		 */
		private val refs: MutableSet<DisplayReference> = mutableSetOf()

		/**
		 * Registers a layout reference.
		 * @method register
		 * @since 0.7.0
		 */
		public fun register(referent: Display) {
			refs.add(DisplayReference(referent, Finalizer.queue))
		}
	}

	/**
	 * @property handle
	 * @since 0.7.0
	 * @hidden
	 */
	private val handle = referent.handle

	/**
	 * @inherited
	 * @method finally
	 * @since 0.7.0
	 */
	override fun finally() {
		refs.remove(this)
		DisplayExternal.delete(this.handle)
	}
}