package ca.logaritm.dezel.view.type

import ca.logaritm.dezel.core.Property
import ca.logaritm.dezel.core.PropertyType


/**
 * The scrollable view's scrollbars options.
 * @enum Scrollbars
 * @since 0.2.0
 */
public enum class Scrollbars {

	NONE,
	BOTH,
	VERTICAL,
	HORIZONTAL;

	companion object {

		/**
		 * Parses the scrollbars type from a property.
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: Property): Scrollbars {
			return when (value.type) {
				PropertyType.NUMBER  -> this.get(value.number)
				PropertyType.STRING  -> this.get(value.string)
				PropertyType.BOOLEAN -> this.get(value.boolean)
				else                 -> Scrollbars.NONE
			}
		}

		/**
		 * Returns the proper scrollbars from a string.
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: String): Scrollbars {
			return when (value) {
				"none"       -> Scrollbars.NONE
				"both"       -> Scrollbars.BOTH
				"vertical"   -> Scrollbars.VERTICAL
				"horizontal" -> Scrollbars.HORIZONTAL
				else         -> Scrollbars.NONE
			}
		}

		/**
		 * Parses the scrollbars type from a number.
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: Double): Scrollbars {
			return if (value == 0.0) Scrollbars.NONE else Scrollbars.BOTH
		}

		/**
		 * Parses the scrollbars type from a boolean.
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: Boolean): Scrollbars {
			return if (value == true)  Scrollbars.BOTH else Scrollbars.NONE
		}
	}
}