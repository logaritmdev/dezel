package ca.logaritm.dezel.view.graphic

import ca.logaritm.dezel.core.JavaScriptProperty

/**
 * @class LinearGradient
 * @since 0.1.0
 */
open class LinearGradient(value: JavaScriptProperty) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property colors
	 * @since 0.1.0
	 */
	public var colors: MutableList<Int> = mutableListOf()
		private set

	/**
	 * @property points
	 * @since 0.1.0
	 */
	public var points: MutableList<Float> = mutableListOf()
		private set

	/**
	 * @property angle
	 * @since 0.1.0
	 */
	public var angle: Float = 0f
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {

	}
}
