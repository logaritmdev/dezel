package ca.logaritm.dezel.application.touch

import android.view.MotionEvent
import ca.logaritm.dezel.extension.view.pointer
import ca.logaritm.dezel.modules.view.JavaScriptView

/**
 * @class Touch
 * @since 0.7.0
 */
public class Touch(pointer: Int, target: JavaScriptView) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @property touches
		 * @since 0.7.0
		 * @hidden
		 */
		private var touches: MutableMap<Int, Touch> = mutableMapOf()

		/**
		 * @method get
		 * @since 0.7.0
		 */
		public fun get(event: MotionEvent): Touch? {
			return this.touches[event.pointer]
		}

		/**
		 * @method acquire
		 * @since 0.7.0
		 */
		public fun acquire(event: MotionEvent, target: JavaScriptView): Touch {

			if (this.touches[event.pointer] == null) {
				this.touches[event.pointer] = Touch(event.pointer, target)
				return this.touches[event.pointer]!!
			}

			throw Exception("Unexpected error.")
		}

		/**
		 * @method release
		 * @since 0.7.0
		 */
		public fun release(event: MotionEvent) {
			this.touches.remove(event.pointer)
		}
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property pointer
	 * @since 0.7.0
	 */
	public var id: Int

	/**
	 * @property target
	 * @since 0.7.0
	 */
	public var target: JavaScriptView

	/**
	 * @property x
	 * @since 0.7.0
	 */
	public var x: Double = 0.0

	/**
	 * @property y
	 * @since 0.7.0
	 */
	public var y: Double = 0.0

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
	 * @property disposed
	 * @since 0.7.0
	 */
	public var disposed: Boolean = false

	/**
	 * @property receiver
	 * @since 0.7.0
	 */
	public var receiver: JavaScriptView? = null

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.id = pointer
		this.target = target
	}
}