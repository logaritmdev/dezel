package ca.logaritm.dezel.style

import ca.logaritm.dezel.core.FinalizableReference
import ca.logaritm.dezel.core.Finalizer
import java.lang.ref.ReferenceQueue

/**
 * @class StylerReference
 * @since 0.4.0
 * @hidden
 */
public class StylerReference(referent: Styler, queue: ReferenceQueue<Any>): FinalizableReference<Styler>(referent, queue) {

	companion object {

		/**
		 * @property refs
		 * @since 0.4.0
		 * @hidden
		 */
		private val refs: MutableSet<StylerReference> = mutableSetOf()

		/**
		 * Registers a Styler node reference.
		 * @method register
		 * @since 0.4.0
		 */
		public fun register(referent: Styler) {
			refs.add(StylerReference(referent, Finalizer.queue))
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
		StylerExternal.delete(this.handle)
	}
}