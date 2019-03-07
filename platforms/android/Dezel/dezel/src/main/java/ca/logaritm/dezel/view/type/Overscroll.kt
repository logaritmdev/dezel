package ca.logaritm.dezel.view.type

import ca.logaritm.dezel.core.Property
import ca.logaritm.dezel.core.PropertyType


/**
 * The scrollable view's overscroll options.
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
		 * Parses the overscroll type from a property.
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: Property): Overscroll {
			return when (value.type) {
				PropertyType.BOOLEAN -> this.get(value.boolean)
				PropertyType.NUMBER  -> this.get(value.number)
				PropertyType.STRING  -> this.get(value.string)
				else                 -> Overscroll.AUTO
			}
		}

		/**
		 * Returns the proper overscroll from a string.
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
		 * Parses the overscroll type from a number.
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: Double): Overscroll {
			return if (value == 0.0) Overscroll.NEVER else Overscroll.AUTO
		}

		/**
		 * Parses the overscroll type from a boolean.
		 * @method get
		 * @since 0.2.0
		 */
		public fun get(value: Boolean): Overscroll {
			return if (value == true)  Overscroll.AUTO else Overscroll.NEVER
		}
	}
}