package ca.logaritm.dezel.view.display

import ca.logaritm.dezel.core.FinalizableReference
import ca.logaritm.dezel.core.Finalizer
import java.lang.ref.ReferenceQueue

/**
 * @class DisplayNodeReference
 * @since 0.7.0
 * @hidden
 */
public class DisplayNodeReference(referent: DisplayNode, queue: ReferenceQueue<Any>): FinalizableReference<DisplayNode>(referent, queue) {

	companion object {

		/**
		 * @property refs
		 * @since 0.7.0
		 * @hidden
		 */
		private val refs: MutableSet<DisplayNodeReference> = mutableSetOf()

		/**
		 * Registers a layout reference.
		 * @method register
		 * @since 0.7.0
		 */
		public fun register(referent: DisplayNode) {
			refs.add(DisplayNodeReference(referent, Finalizer.queue))
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
		DisplayNodeExternal.delete(this.handle)
	}
}