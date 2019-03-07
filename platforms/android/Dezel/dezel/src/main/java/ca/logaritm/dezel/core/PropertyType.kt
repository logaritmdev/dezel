package ca.logaritm.dezel.core

/**
 * The type of properties.
 * @enum PropertyType
 * @since 0.1.0
 */
public enum class PropertyType(val value: Int) {

	NULL(0),
	STRING(1),
	NUMBER(2),
	BOOLEAN(3),
	OBJECT(4),
	ARRAY(5);

	companion object {
		fun from(value: Int): PropertyType? = PropertyType.values().find { it.value == value }
	}
}