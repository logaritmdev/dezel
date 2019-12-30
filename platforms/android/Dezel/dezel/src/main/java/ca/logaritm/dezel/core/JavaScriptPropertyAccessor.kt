package ca.logaritm.dezel.core

import java.lang.reflect.Method

/**
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
			 * In case the method does not exist, the accessor will attempt to
			 * set the value to the actual JavaScript object backing the
			 * native instance.
			 */

		}
	}

	/**
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