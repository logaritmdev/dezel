package ca.logaritm.dezel.core

/**
 * The unit of the property.
 * @enum JavaScriptPropertyUnit
 * @since 0.1.0
 */
public enum class JavaScriptPropertyUnit(val value: Int) {

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
			this == JavaScriptPropertyUnit.VW ||
			this == JavaScriptPropertyUnit.VH
		)
	}

	fun isRelativeToParent(): Boolean {
		return (
			this == JavaScriptPropertyUnit.PC ||
			this == JavaScriptPropertyUnit.PW ||
			this == JavaScriptPropertyUnit.PH ||
			this == JavaScriptPropertyUnit.CW ||
			this == JavaScriptPropertyUnit.CH
		)
	}

	companion object {

		fun of(value: Int): JavaScriptPropertyUnit {

			when (value) {
				0  -> return JavaScriptPropertyUnit.NONE
				1  -> return JavaScriptPropertyUnit.PX
				2  -> return JavaScriptPropertyUnit.PC
				3  -> return JavaScriptPropertyUnit.VW
				4  -> return JavaScriptPropertyUnit.VH
				5  -> return JavaScriptPropertyUnit.PW
				6  -> return JavaScriptPropertyUnit.PH
				7  -> return JavaScriptPropertyUnit.CW
				8  -> return JavaScriptPropertyUnit.CH
				9  -> return JavaScriptPropertyUnit.DEG
				10 -> return JavaScriptPropertyUnit.RAD
			}

			return JavaScriptPropertyUnit.NONE
		}
	}
}