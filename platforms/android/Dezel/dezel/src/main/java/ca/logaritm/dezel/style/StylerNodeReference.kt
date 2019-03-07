package ca.logaritm.dezel.style


import ca.logaritm.dezel.core.FinalizableReference
import ca.logaritm.dezel.core.Finalizer
import java.lang.ref.ReferenceQueue

/**
 * @class StylerNodeReference
 * @since 0.4.0
 * @hidden
 */
public class StylerNodeReference(referent: StylerNode, queue: ReferenceQueue<Any>): FinalizableReference<StylerNode>(referent, queue) {

	companion object {

		/**
		 * @property refs
		 * @since 0.4.0
		 * @hidden
		 */
		private val refs: MutableSet<StylerNodeReference> = mutableSetOf()

		/**
		 * Registers a StylerNode node reference.
		 * @method register
		 * @since 0.4.0
		 */
		public fun register(referent: StylerNode) {
			refs.add(StylerNodeReference(referent, Finalizer.queue))
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
		StylerNodeExternal.delete(this.handle)
	}
}