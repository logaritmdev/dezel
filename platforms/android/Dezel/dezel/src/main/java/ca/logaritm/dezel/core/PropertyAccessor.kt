package ca.logaritm.dezel.core

import java.lang.reflect.Method

/**
 * A reflection based property accessor.
 * @class PropertyAccessor
 * @since 0.1.0
 */
public class PropertyAccessor(val clazz: Class<*>, val field: String) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @property cache
		 * @since 0.1.0
		 * @hidden
		 */
		private var cache: MutableMap<Class<*>, MutableMap<String, PropertyAccessor>> = mutableMapOf()

		/**
		 * Assigns the handle of a property dynamically.
		 * @method set
		 * @since 0.1.0
		 */
		public fun set(target: Any, field: String, value: Property): Boolean {
			return this.accessor(target, field).set(target, value)
		}

		/**
		 * Retrieves the handle of a property dynamically.
		 * @method get
		 * @since 0.1.0
		 */
		public fun get(target: Any, field: String): Property? {
			return this.accessor(target, field).get(target)
		}

		/**
		 * @method accessor
		 * @since 0.1.0
		 * @hidden
		 */
		private fun accessor(target: Any, name: String): PropertyAccessor {
			val type = target.javaClass
			return this.cache
				.getOrPut(type, { mutableMapOf() })
				.getOrPut(name, { PropertyAccessor(type, name) })
		}
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property getter
	 * @since 0.1.0
	 * @hidden
	 */
	private var getter: Method? = null

	/**
	 * @property setter
	 * @since 0.1.0
	 * @hidden
	 */
	private var setter: Method? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {

		val getter = "get" + field[0].toUpperCase() + field.substring(1)
		val setter = "set" + field[0].toUpperCase() + field.substring(1)

		try {
			this.getter = this.clazz.getMethod(getter)
			this.setter = this.clazz.getMethod(setter, Property::class.java)
		} catch (e: NoSuchMethodException) {

		}
	}

	/**
	 * Assigns a handle to specified object.
	 * @method set
	 * @since 0.1.0
	 */
	public fun set(target: Any, value: Property): Boolean {

		try {
			this.setter?.invoke(target, value)
		} catch (e: Exception) {
			return false
		}

		return true
	}

	/**
	 * Retrieves a handle from specified object.
	 * @method get
	 * @since 0.1.0
	 */
	public fun get(target: Any): Property? {

		try {
			return this.getter?.invoke(target) as Property
		} catch (e: Exception) {
		}

		return null
	}
}