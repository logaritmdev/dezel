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
	 * Dynamically assigns a JavaScript value.
	 * @method set
	 * @since 0.7.0
	 */
	open fun set(instance: JavaScriptObject, value: JavaScriptValue?) {

		val property = this.get(instance)
		if (property == null) {
			instance.property(this.name, value)
			return
		}

		property.set(value)
	}

	/**
	 * Dynamically assigns a string.
	 * @method set
	 * @since 0.7.0
	 */
	open fun set(instance: JavaScriptObject, string: String) {

		val property = this.get(instance)
		if (property == null) {
			instance.property(this.name, string)
			return
		}

		property.set(string)
	}

	/**
	 * Dynamically assigns a number.
	 * @method set
	 * @since 0.7.0
	 */
	public fun set(instance: JavaScriptObject, number: Double, unit: JavaScriptPropertyUnit) {

		val property = this.get(instance)
		if (property == null) {

			when (unit) {
				JavaScriptPropertyUnit.NONE -> instance.property(this.name, number)
				JavaScriptPropertyUnit.PX   -> instance.property(this.name, Conversion.toString(number) + "px")
				JavaScriptPropertyUnit.PC   -> instance.property(this.name, Conversion.toString(number) + "%")
				JavaScriptPropertyUnit.VW   -> instance.property(this.name, Conversion.toString(number) + "vw")
				JavaScriptPropertyUnit.VH   -> instance.property(this.name, Conversion.toString(number) + "vh")
				JavaScriptPropertyUnit.PW   -> instance.property(this.name, Conversion.toString(number) + "pw")
				JavaScriptPropertyUnit.PH   -> instance.property(this.name, Conversion.toString(number) + "ph")
				JavaScriptPropertyUnit.CW   -> instance.property(this.name, Conversion.toString(number) + "cw")
				JavaScriptPropertyUnit.CH   -> instance.property(this.name, Conversion.toString(number) + "ch")
				JavaScriptPropertyUnit.DEG  -> instance.property(this.name, Conversion.toString(number) + "deg")
				JavaScriptPropertyUnit.RAD  -> instance.property(this.name, Conversion.toString(number) + "rad")
			}

			return
		}

		property.set(number, unit)
	}

	/**
	 * Dynamically assigns a boolean.
	 * @method set
	 * @since 0.7.0
	 */
	public fun set(instance: JavaScriptObject, boolean: Boolean) {

		val property = this.get(instance)
		if (property == null) {
			instance.property(this.name, boolean)
			return
		}

		property.set(boolean)
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