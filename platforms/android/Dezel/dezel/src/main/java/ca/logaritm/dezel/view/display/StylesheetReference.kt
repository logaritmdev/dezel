package ca.logaritm.dezel.view.display

import ca.logaritm.dezel.core.FinalizableReference
import ca.logaritm.dezel.core.Finalizer
import ca.logaritm.dezel.view.display.external.StylesheetExternal
import java.lang.ref.ReferenceQueue

/**
 * @class StylesheetReference
 * @super FinalizableReference
 * @since 0.7.0
 */
public class StylesheetReference(referent: Stylesheet, queue: ReferenceQueue<Any>): FinalizableReference<Stylesheet>(referent, queue) {

	companion object {

		/**
		 * @property refs
		 * @since 0.7.0
		 * @hidden
		 */
		private val refs: MutableSet<StylesheetReference> = mutableSetOf()

		/**
		 * @method register
		 * @since 0.7.0
		 */
		public fun register(referent: Stylesheet) {
			refs.add(StylesheetReference(referent, Finalizer.queue))
		}
	}

	/**
	 * @property handle
	 * @since 0.7.0
	 * @hidden
	 */
	private val handle = referent.handle

	/**
	 * @method finally
	 * @since 0.7.0
	 */
	override fun finally() {
		refs.remove(this)
		StylesheetExternal.delete(this.handle)
	}
}