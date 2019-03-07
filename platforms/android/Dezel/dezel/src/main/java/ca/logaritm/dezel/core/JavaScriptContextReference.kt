package ca.logaritm.dezel.core

import java.lang.ref.ReferenceQueue


/**
 * @class JavaScriptContextReference
 * @since 0.4.0
 * @hidden
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
		 * Registers a JavaScriptContext node reference.
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
	 * @inherited
	 * @method finally
	 * @since 0.4.0
	 */
	override fun finally() {
		refs.remove(this)
		JavaScriptContextExternal.delete(this.handle)
	}
}