package ca.logaritm.dezel.extension.type

import kotlin.contracts.ExperimentalContracts
import kotlin.contracts.InvocationKind
import kotlin.contracts.contract

fun <T : Any> T?.let(f: (it: T) -> Unit) {
	if (this != null) f(this)
}