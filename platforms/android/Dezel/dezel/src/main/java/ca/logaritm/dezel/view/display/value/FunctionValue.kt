package ca.logaritm.dezel.view.display.value

import ca.logaritm.dezel.view.display.external.FunctionValueExternal

/**
 * @class FunctionValue
 * @since 0.7.0
 */
public class FunctionValue(handle: Long): Value(handle) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property name
	 * @since 0.7.0
	 */
	public val name: String
		get() = FunctionValueExternal.getName(this.handle)

	/**
	 * @property arguments
	 * @since 0.7.0
	 */
	public val arguments: Int
		get() = FunctionValueExternal.getArguments(this.handle)

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method argument
	 * @since 0.7.0
	 */
	public fun argument(index: Int): ValueList {
		return ValueList(FunctionValueExternal.getArgument(this.handle, index))
	}
}