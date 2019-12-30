package ca.logaritm.dezel.view.display.value

import ca.logaritm.dezel.view.display.external.ValueExternal

/**
 * @class Value
 * @since 0.7.0
 */
open class Value(handle: Long) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------
	
	companion object {

		/**
		 * @method parse
		 * @since 0.7.0
		 */
		public fun parse(source: String): ValueList? {

			val values = ValueExternal.parse(source)
			if (values == 0L) {
				return null
			}

			return ValueList(values)
		}
		
	}
	
	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property type
	 * @since 0.7.0
	 */
	public val type: Int
		get() = ValueExternal.getType(this.handle)

	/**
	 * @property unit
	 * @since 0.7.0
	 */
	public val unit: Int
		get() = ValueExternal.getUnit(this.handle)

	/**
	 * @property string
	 * @since 0.7.0
	 */
	public val string: String
		get() = ValueExternal.getString(this.handle)

	/**
	 * @property number
	 * @since 0.7.0
	 */
	public val number: Double
		get() = ValueExternal.getNumber(this.handle)

	/**
	 * @property boolean
	 * @since 0.7.0
	 */
	public val boolean: Boolean
		get() = ValueExternal.getBoolean(this.handle)

	/**
	 * @property handle
	 * @since 0.7.0
	 */
	public var handle: Long = 0L
		private set

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.handle = handle
	}
}