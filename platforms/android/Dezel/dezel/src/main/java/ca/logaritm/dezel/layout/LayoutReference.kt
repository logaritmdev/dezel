package ca.logaritm.dezel.layout

import ca.logaritm.dezel.core.FinalizableReference
import ca.logaritm.dezel.core.Finalizer
import java.lang.ref.ReferenceQueue

/**
 * @class LayoutReference
 * @since 0.4.0
 * @hidden
 */
public class LayoutReference(referent: Layout, queue: ReferenceQueue<Any>): FinalizableReference<Layout>(referent, queue) {

	companion object {

		/**
		 * @property refs
		 * @since 0.4.0
		 * @hidden
		 */
		private val refs: MutableSet<LayoutReference> = mutableSetOf()

		/**
		 * Registers a layout reference.
		 * @method register
		 * @since 0.4.0
		 */
		public fun register(referent: Layout) {
			refs.add(LayoutReference(referent, Finalizer.queue))
		}
	}

	/**
	 * @property handle
	 * @since 0.4.0
	 * @hidden
	 */
	private val handle = referent.handle

	/**
	 * @inherited
	 * @method finally
	 * @since 0.4.0
	 */
	override fun finally() {
		refs.remove(this)
		LayoutExternal.delete(this.handle)
	}
}