package ca.logaritm.dezel.core

/**
 * @enum JavaScriptPropertyType
 * @since 0.7.0
 */
public enum class JavaScriptPropertyType(val value: Int) {

	NULL(0),
	STRING(1),
	NUMBER(2),
	BOOLEAN(3),
	ARRAY(4),
	OBJECT(5),
	CALLBACK(6),
	VARIABLE(7),
	FUNCTION(8),
	COMPOSITE(9);

	companion object {
		fun from(value: Int): JavaScriptPropertyType? = values().find { it.value == value }
	}
}