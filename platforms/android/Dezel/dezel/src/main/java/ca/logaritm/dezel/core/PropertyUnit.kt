package ca.logaritm.dezel.core

/**
 * The unit of the property.
 * @enum PropertyUnit
 * @since 0.1.0
 */
public enum class PropertyUnit(val value: Int) {

	NONE(0),
	PX(1),
	PC(2),
	VW(3),
	VH(4),
	PW(5),
	PH(6),
	CW(7),
	CH(8),
	DEG(9),
	RAD(10);

	fun isRelativeToWindow(): Boolean {
		return (
			this == PropertyUnit.VW ||
			this == PropertyUnit.VH
		)
	}

	fun isRelativeToParent(): Boolean {
		return (
			this == PropertyUnit.PC ||
			this == PropertyUnit.PW ||
			this == PropertyUnit.PH ||
			this == PropertyUnit.CW ||
			this == PropertyUnit.CH
		)
	}

	companion object {

		fun of(value: Int): PropertyUnit {

			when (value) {
				0  -> return PropertyUnit.NONE
				1  -> return PropertyUnit.PX
				2  -> return PropertyUnit.PC
				3  -> return PropertyUnit.VW
				4  -> return PropertyUnit.VH
				5  -> return PropertyUnit.PW
				6  -> return PropertyUnit.PH
				7  -> return PropertyUnit.CW
				8  -> return PropertyUnit.CH
				9  -> return PropertyUnit.DEG
				10 -> return PropertyUnit.RAD
			}

			return PropertyUnit.NONE
		}
	}
}