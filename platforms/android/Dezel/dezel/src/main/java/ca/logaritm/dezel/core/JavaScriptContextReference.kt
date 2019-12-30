package ca.logaritm.dezel.core

import ca.logaritm.dezel.core.external.JavaScriptContextExternal
import java.lang.ref.ReferenceQueue

/**
 * @class JavaScriptContextReference
 * @super FinalizableReference
 * @since 0.4.0
 */
public class JavaScriptContextReference(referent: JavaScriptContext, queue: ReferenceQueue<Any>): FinalizableReference<JavaScriptContext>(referent, queue) {

	companion object {

		/**
		 * @property refs
		 * @since 0.4.0
		 * @hidden
		 */
		private val refs: MutableSet<JavaScriptContextReference> = mutableSetOf()

		/**
		 * @method register
		 * @since 0.4.0
		 */
		public fun register(referent: JavaScriptContext) {
			refs.add(JavaScriptContextReference(referent, Finalizer.queue))
		}
	}

	/**
	 * @property handle
	 * @since 0.4.0
	 * @hidden
	 */
	private val handle = referent.handle

	/**
	 * @method finally
	 * @since 0.4.0
	 */
	override fun finally() {
		refs.remove(this)
		JavaScriptContextExternal.delete(this.handle)
	}
}