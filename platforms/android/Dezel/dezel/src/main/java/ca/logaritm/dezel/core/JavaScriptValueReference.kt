package ca.logaritm.dezel.core

import java.lang.ref.ReferenceQueue

/**
 * @class JavaScriptValueReference
 * @since 0.4.0
 * @hidden
 */
public class JavaScriptValueReference(referent: JavaScriptValue, queue: ReferenceQueue<Any>): FinalizableReference<JavaScriptValue>(referent, queue) {

	companion object {

		private val refs: MutableMap<Long, JavaScriptValueReference> = mutableMapOf()

		/**
		 * Registers a JavaScript value reference.
		 * @method register
		 * @since 0.4.0
		 */
		public fun protect(referent: JavaScriptValue) {

			val reference = this.refs[referent.handle]
			if (reference == null) {
				this.refs[referent.handle] = JavaScriptValueReference(referent, Finalizer.queue)
				return
			}

			reference.protected = true
			reference.context = referent.context
			reference.handle = referent.handle
		}

		/**
		 * Registers a JavaScript value reference.
		 * @method register
		 * @since 0.4.0
		 */
		public fun unprotect(referent: JavaScriptValue) {

			val reference = this.refs[referent.handle]
			if (reference == null) {
				return
			}

			reference.protected = false
			reference.context = null
			reference.handle = 0
		}
	}

	/**
	 * @property protected
	 * @since 0.4.0
	 * @hidden
	 */
	private var protected: Boolean = false

	/**
	 * @property context
	 * @since 0.4.0
	 * @hidden
	 */
	private var context: JavaScriptContext? = null

	/**
	 * @property handle
	 * @since 0.4.0
	 * @hidden
	 */
	private var handle: Long = 0L

	/**
	 * @inherited
	 * @method finally
	 * @since 0.4.0
	 */
	override fun finally() {

		if (this.protected) {
			val context = this.context
			if (context != null) {
				handler.post {
					JavaScriptValueExternal.unprotect(context.handle, this.handle)
				}
			}
		}

		refs.remove(this.handle)
	}
}