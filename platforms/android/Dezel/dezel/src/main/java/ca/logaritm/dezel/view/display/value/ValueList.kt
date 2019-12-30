package ca.logaritm.dezel.view.display.value

import ca.logaritm.dezel.view.display.external.ValueListExternal
import ca.logaritm.dezel.view.display.value.Value

/**
 * @class ValueList
 * @since 0.7.0
 */
public class ValueList(handle: Long) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property count
	 * @since 0.7.0
	 */
	public val count: Int
		get() = ValueListExternal.getCount(this.handle)

	/**
	 * @property handle
	 * @since 0.7.0
	 */
	public var handle: Long = 0L
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.handle = handle
	}

	/**
	 * @method get
	 * @since 0.7.0
	 */
	public fun get(index: Int): Value {
		return Value(ValueListExternal.getValue(this.handle, index))
	}

	internal fun delete() {
		ValueListExternal.delete(this.handle)
	}
}