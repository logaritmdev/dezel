package ca.logaritm.dezel.extension


import kotlin.properties.ReadWriteProperty
import kotlin.reflect.KProperty

typealias OnSetCallback<T> = (value: T) -> Unit
typealias OnSetOptionalCallback<T> = (value: T?) -> Unit

/**
 * @object Delegates
 * @since 0.1.0
 */
public object Delegates {

	/**
	 * @class OnSet
	 * @since 0.1.0
	 */
	public class OnSet<T: Any>(init: T, val callback: OnSetCallback<T>) : ReadWriteProperty<Any?, T> {

		/**
		 * @property field
		 * @since 0.1.0
		 * @hidden
		 */
		protected var field: T = init

		/**
		 * @method getValue
		 * @since 0.1.0
		 */
		override fun getValue(thisRef: Any?, property: KProperty<*>): T {
			return this.field
		}

		/**
		 * @method setValue
		 * @since 0.1.0
		 */
		override fun setValue(thisRef: Any?, property: KProperty<*>, value: T) {

			val oldValue = this.field
			this.field = value
			val newValue = this.field

			if (oldValue == newValue) {
				return
			}

			this.callback.invoke(value)
		}
	}

	/**
	 * @class OnSetOptional
	 * @since 0.1.0
	 */
	public class OnSetOptional<T: Any>(init: T?, val callback: OnSetOptionalCallback<T>) : ReadWriteProperty<Any?, T?> {

		/**
		 * @property field
		 * @since 0.1.0
		 * @hidden
		 */
		protected var field: T? = init

		/**
		 * @method getValue
		 * @since 0.1.0
		 */
		override fun getValue(thisRef: Any?, property: KProperty<*>): T? {
			return this.field
		}

		/**
		 * @method setValue
		 * @since 0.1.0
		 */
		override fun setValue(thisRef: Any?, property: KProperty<*>, value: T?) {

			val oldValue = this.field
			this.field = value
			val newValue = this.field

			if (oldValue == newValue) {
				return
			}

			this.callback.invoke(value)
		}
	}
}
