package ca.logaritm.dezel.core

import java.lang.reflect.Method

/**
 * A reflection based name accessor.
 * @class JavaScriptPropertyAccessor
 * @since 0.7.0
 */
open class JavaScriptPropertyAccessor(type: Class<*>, name: String) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @name cache
		 * @since 0.1.0
		 * @hidden
		 */
		private var cache: MutableMap<Class<*>, MutableMap<String, JavaScriptPropertyAccessor>> = mutableMapOf()

		/**
		 * Retrieves the handle of a name dynamically.
		 * @method get
		 * @since 0.1.0
		 */
		public fun get(instance: JavaScriptObject, property: String): JavaScriptPropertyAccessor {
			return this.cache.getOrPut(instance.javaClass, { mutableMapOf() }).getOrPut(property, { JavaScriptPropertyAccessor(instance.javaClass, property) })
		}
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @name type
	 * @since 0.7.0
	 * @hidden
	 */
	private val type: Class<*> = type

	/**
	 * @name name
	 * @since 0.7.0
	 * @hidden
	 */
	private val name: String = name

	/**
	 * @name method
	 * @since 0.7.0
	 * @hidden
	 */
	private var method: Method? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {

		try {

			this.method = this.type.getMethod("get" + this.name.capitalize())

		} catch (e: NoSuchMethodException) {

			/*
			 * In case the method does not exist, the accessor will attemtp to
			 * set the valie to the actual JavaScript object backing the
			 * native instance.
			 */

		}
	}

	/**
	 * Dynamically assigns a JavaScript toValue.
	 * @method set
	 * @since 0.7.0
	 */
	open fun set(instance: JavaScriptObject, value: JavaScriptValue?): Boolean {

		val property = this.get(instance)
		if (property == null) {
			return false
		}

		property.reset(value)

		return true
	}

	/**
	 * Dynamically assigns a toString.
	 * @method set
	 * @since 0.7.0
	 */
	open fun set(instance: JavaScriptObject, string: String): Boolean {

		val property = this.get(instance)
		if (property == null) {
			return false
		}

		property.reset(string)

		return true
	}

	/**
	 * Dynamically assigns a toNumber.
	 * @method set
	 * @since 0.7.0
	 */
	public fun set(instance: JavaScriptObject, number: Double, unit: JavaScriptPropertyUnit): Boolean {

		val property = this.get(instance)
		if (property == null) {
			return false
		}

		property.reset(number, unit)

		return true
	}

	/**
	 * Dynamically assigns a toBoolean.
	 * @method set
	 * @since 0.7.0
	 */
	public fun set(instance: JavaScriptObject, boolean: Boolean): Boolean {

		val property = this.get(instance)
		if (property == null) {
			return false
		}

		property.reset(boolean)

		return true
	}
	
	/**
	 * Retrieves a handle from specified object.
	 * @method get
	 * @since 0.7.0
	 */
	public fun get(instance: JavaScriptObject): JavaScriptProperty? {

		if (this.method == null) {
			return null
		}

		try {
			return this.method?.invoke(instance) as JavaScriptProperty
		} catch (e: Exception) {
			return null
		}
	}
}