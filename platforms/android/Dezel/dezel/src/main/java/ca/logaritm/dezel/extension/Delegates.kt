package ca.logaritm.dezel.extension


import kotlin.properties.ReadWriteProperty
import kotlin.reflect.KProperty

typealias OnSetCallback<T> = (value: T) -> Unit
typealias OnSetOptionalCallback<T> = (value: T?) -> Unit
typealias OnChangeCallback<T> = (newValue: T, oldValue: T) -> Unit
typealias OnChangeOptionalCallback<T> = (newValue: T?, oldValue: T?) -> Unit
typealias OnInitCallback<T> = () -> T

/**
 * Delegates creators
 * @object Delegates
 * @since 0.1.0
 */
public object Delegates {

	/**
	 * Delegates that executes the handler when the handle changes with the new handle.
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
		 * @inherited
		 * @method getValue
		 * @since 0.1.0
		 */
		override fun getValue(thisRef: Any?, property: KProperty<*>): T {
			return this.field
		}

		/**
		 * @inherited
		 * @method setValue
		 * @since 0.1.0
		 */
		override fun setValue(thisRef: Any?, property: KProperty<*>, value: T) {
			this.field = value
			this.callback.invoke(value)
		}
	}

	/**
	 * Delegates that executes the handler when the handle changes with the new handle.
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
		 * @inherited
		 * @method getValue
		 * @since 0.1.0
		 */
		override fun getValue(thisRef: Any?, property: KProperty<*>): T? {
			return this.field
		}

		/**
		 * @inherited
		 * @method setValue
		 * @since 0.1.0
		 */
		override fun setValue(thisRef: Any?, property: KProperty<*>, value: T?) {
			this.field = value
			this.callback.invoke(value)
		}
	}

	/**
	 * Delegates that executes the handler when the handle changes with the new and old handle.
	 * @class OnChange
	 * @since 0.1.0
	 */
	public class OnChange<T: Any>(init: T, val callback: OnChangeCallback<T>) : ReadWriteProperty<Any?, T> {

		/**
		 * @property field
		 * @since 0.1.0
		 * @hidden
		 */
		protected var field: T = init

		/**
		 * @inherited
		 * @method getValue
		 * @since 0.1.0
		 */
		override fun getValue(thisRef: Any?, property: KProperty<*>): T {
			return this.field
		}

		/**
		 * @inherited
		 * @method setValue
		 * @since 0.1.0
		 */
		override fun setValue(thisRef: Any?, property: KProperty<*>, value: T) {

			if (this.field != value) {

				val oldValue = this.field
				this.field = value
				val newValue = this.field

				this.callback.invoke(newValue, oldValue)
			}
		}
	}

	/**
	 * Delegates that executes the handler when the handle changes with the new and old handle.
	 * @class OnChangeOptional
	 * @since 0.1.0
	 */
	public class OnChangeOptional<T: Any>(init: T?, val callback: OnChangeOptionalCallback<T>) : ReadWriteProperty<Any?, T?> {

		/**
		 * @property field
		 * @since 0.1.0
		 * @hidden
		 */
		protected var field: T? = init

		/**
		 * @inherited
		 * @method getValue
		 * @since 0.1.0
		 */
		override fun getValue(thisRef: Any?, property: KProperty<*>): T? {
			return this.field
		}

		/**
		 * @inherited
		 * @method setValue
		 * @since 0.1.0
		 */
		override fun setValue(thisRef: Any?, property: KProperty<*>, value: T?) {

			if (this.field != value) {

				val oldValue = this.field
				this.field = value
				val newValue = this.field

				this.callback.invoke(newValue, oldValue)
			}
		}
	}

	/**
	 * Delegates for a watchable lazy property.
	 * @class Lazy
	 * @since 0.1.0
	 */
	open class Lazy<T: Any>(val init: OnInitCallback<T>) : ReadWriteProperty<Any?, T> {

		/**
		 * @property field
		 * @since 0.1.0
		 * @hidden
		 */
		protected lateinit var field: T

		/**
		 * @inherited
		 * @method getValue
		 * @since 0.1.0
		 */
		override fun getValue(thisRef: Any?, property: KProperty<*>): T {

			if (::field.isInitialized == false) {
				this.field = init()
			}

			return this.field
		}

		/**
		 * @inherited
		 * @method setValue
		 * @since 0.1.0
		 */
		override fun setValue(thisRef: Any?, property: KProperty<*>, value: T) {
			this.field = value
		}
	}
}
