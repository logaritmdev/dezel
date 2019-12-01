package ca.logaritm.dezel.view.type

import ca.logaritm.dezel.core.JavaScriptProperty
import ca.logaritm.dezel.core.JavaScriptPropertyType

/**
 * @enum Overscroll
 * @since 0.2.0
 */
public enum class Overscroll {

	AUTO,
	NEVER,
	ALWAYS,
	ALWAYS_X,
	ALWAYS_Y;

	companion object {

		/**
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: JavaScriptProperty): Overscroll {
			return when (value.type) {
				JavaScriptPropertyType.BOOLEAN -> this.get(value.boolean)
				JavaScriptPropertyType.NUMBER  -> this.get(value.number)
				JavaScriptPropertyType.STRING  -> this.get(value.string)
				else                           -> Overscroll.AUTO
			}
		}

		/**
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: String): Overscroll {
			return when (value) {
				"auto"     -> Overscroll.AUTO
				"never"    -> Overscroll.NEVER
				"always"   -> Overscroll.ALWAYS
				"always-x" -> Overscroll.ALWAYS_X
				"always-y" -> Overscroll.ALWAYS_Y
				else       -> Overscroll.AUTO
			}
		}

		/**
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: Double): Overscroll {
			return if (value == 0.0) Overscroll.NEVER else Overscroll.AUTO
		}

		/**
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: Boolean): Overscroll {
			return if (value == true)  Overscroll.AUTO else Overscroll.NEVER
		}
	}
}