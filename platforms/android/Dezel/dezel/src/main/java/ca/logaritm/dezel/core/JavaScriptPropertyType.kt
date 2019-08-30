package ca.logaritm.dezel.core

/**
 * The type of properties.
 * @enum JavaScriptPropertyType
 * @since 0.7.0
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
	}
}