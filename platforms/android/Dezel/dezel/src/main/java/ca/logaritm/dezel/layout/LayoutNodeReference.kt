package ca.logaritm.dezel.layout

import ca.logaritm.dezel.core.FinalizableReference
import ca.logaritm.dezel.core.Finalizer
import java.lang.ref.ReferenceQueue

/**
 * @class LayoutNodeReference
 * @since 0.4.0
 * @hidden
 */
public class LayoutNodeReference(referent: LayoutNode, queue: ReferenceQueue<Any>): FinalizableReference<LayoutNode>(referent, queue) {

	companion object {

		/**
		 * @property refs
		 * @since 0.4.0
		 * @hidden
		 */
		private val refs: MutableSet<LayoutNodeReference> = mutableSetOf()

		/**
		 * Registers a layout reference.
		 * @method register
		 * @since 0.4.0
		 */
		public fun register(referent: LayoutNode) {
			refs.add(LayoutNodeReference(referent, Finalizer.queue))
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
		LayoutNodeExternal.delete(this.handle)
	}
}