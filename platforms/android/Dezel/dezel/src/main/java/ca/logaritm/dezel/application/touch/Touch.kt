package ca.logaritm.dezel.application.touch

import android.view.View

/**
 * @class Touch
 * @since 0.7.0
 */
public class Touch {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property pointer
	 * @since 0.7.0
	 */
	public var pointer: Int = 0

	/**
	 * @property x
	 * @since 0.7.0
	 */
	public var x: Float = 0f

	/**
	 * @property y
	 * @since 0.7.0
	 */
	public var y: Float = 0f

	/**
	 * @property canceled
	 * @since 0.7.0
	 */
	public var canceled: Boolean = false

	/**
	 * @property captured
	 * @since 0.7.0
	 */
	public var captured: Boolean = false

	/**
	 * @property reverted
	 * @since 0.7.0
	 */
	public var reverted: Boolean = false

	/**
	 * @property receiver
	 * @since 0.7.0
	 */
	public var receiver: View? = null

}