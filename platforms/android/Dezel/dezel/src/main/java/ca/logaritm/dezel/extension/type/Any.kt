package ca.logaritm.dezel.extension.type

fun <T : Any> T?.let(f: (it: T) -> Unit) {
	if (this != null) f(this)
}