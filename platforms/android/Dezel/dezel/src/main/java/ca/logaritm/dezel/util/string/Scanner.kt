package ca.logaritm.dezel.util.string

public class Scanner(string: String) {

	companion object {
		public val ALPHANUM = arrayOf(
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'X', 'Y', 'Z',
			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'x', 'y', 'z',
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'
		)
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	public var string: String = string
		private set

	public var location: Int = -1

	public val isAtEnd: Boolean
		get() = this.location >= this.string.length - 1

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	public fun hasNext(string: String): Boolean {

		val location = this.location

		if (this.scan(string) != null) {
			this.location = location
			return true
		}

		this.location = location

		return false
	}

	public fun scan(string: String): String? {

		val start = this.location

		for (character in string) {
			val current = this.advance()
			if (current == null ||
				current != character) {
				this.location = start
				return null
			}
		}

		return string
	}

	public fun scan(pattern: Array<Char>): String? {

		var value = ""
		val start = this.location

		while (true) {

			val current = this.advance()
			if (current == null) {
				break
			}

			if (pattern.contains(current)) {
				value += current
				continue
			}

			break
		}

		if (value.length == 0) {
			this.location = start
			return null
		}

		this.location -= 1

		return value
	}

	public fun scanDouble(): Double? {

		var value = ""
		val start = this.location

		while (true) {

			val skipWhitespace = value.isEmpty()

			val current = this.advance(value.isEmpty() == false)
			if (current == null) {
				break
			}

			if (current == ' ' && skipWhitespace) {
				continue
			}

			if (current == '1' || current == '2' || current == '3' || current == '4' || current == '5' ||
				current == '6' || current == '7' || current == '8' || current == '9' || current == '0' ||
				current == '.' ) {
				value += current
				continue
			}

			break
		}

		if (value.isEmpty()) {
			this.location = start
			return null
		}

		this.location -= 1

		return value.toDoubleOrNull()
	}

	public fun scanFloat(): Float? {

		var value = ""
		val start = this.location

		while (true) {

			val skipWhitespace = value.isEmpty()

			val current = this.advance(value.isEmpty() == false)
			if (current == null) {
				break
			}

			if (current == ' ' && skipWhitespace) {
				continue
			}

			if (current == '1' || current == '2' || current == '3' || current == '4' || current == '5' ||
				current == '6' || current == '7' || current == '8' || current == '9' || current == '0' ||
				current == '.' ) {
				value += current
				continue
			}

			break
		}

		if (value.isEmpty()) {
			this.location = start
			return null
		}

		this.location -= 1

		return value.toFloatOrNull()
	}

	public fun scanInt(radix: Int = 10): Int? {

		var value = ""
		val start = this.location

		while (true) {

			val skipWhitespace = value.isEmpty()

			val current = this.advance(skipWhitespace)
			if (current == null) {
				break
			}

			if (current == ' ' && skipWhitespace) {
				continue
			}

			if (radix == 10) {

				if (current == '1' || current == '2' || current == '3' || current == '4' || current == '5' ||
					current == '6' || current == '7' || current == '8' || current == '9' || current == '0') {
					value += current
					continue
				}

				this.location -= 1

				break
			}

			if (radix == 16) {

				if (current == 'A' || current == 'B' || current == 'C' || current == 'D' || current == 'E' || current == 'F' ||
					current == 'a' || current == 'b' || current == 'c' || current == 'd' || current == 'e' || current == 'f' ||
					current == '1' || current == '2' || current == '3' || current == '4' || current == '5' || current == '6' ||
					current == '7' || current == '8' || current == '9' ||current == '0') {
					value += current
					continue
				}

				this.location -= 1

				break
			}
		}

		if (value.isEmpty()) {
			this.location = start
			return null
		}

		return value.toIntOrNull(radix)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	private fun advance(skipWhitespace: Boolean = true): Char? {

		while (true) {

			this.location += 1

			if (this.location < 0 ||
				this.location > this.string.length - 1) {
				return null
			}

			val character = this.string[this.location]
			if (character == ' ' && skipWhitespace) {
				continue
			}

			return character
		}
	}

}