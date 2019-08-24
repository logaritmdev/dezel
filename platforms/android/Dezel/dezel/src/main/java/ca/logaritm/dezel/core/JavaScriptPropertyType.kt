package ca.logaritm.dezel.core

/**
 * The type of properties.
 * @enum JavaScriptPropertyType
 * @since 0.1.0
 */
public enum class JavaScriptPropertyType(val value: Int) {

	NULL(0),
	STRING(1),
	NUMBER(2),
	BOOLEAN(3),
	OBJECT(4),
	ARRAY(5);

	companion object {

		fun from(value: Int): JavaScriptPropertyType? = values().find { it.value == value }

		fun from(value: JavaScriptValue): JavaScriptPropertyType {

			if (value.isNull ||
				value.isUndefined) {
				return NULL
			}

			if (value.isString) {
				return STRING
			}

			if (value.isNumber) {
				return NUMBER
			}

			if (value.isBoolean) {
				return BOOLEAN
			}

			if (value.isObject) {
				return OBJECT
			}

			if (value.isArray) {
				return ARRAY
			}

			return NULL
		}
	}
}