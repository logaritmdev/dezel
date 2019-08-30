package ca.logaritm.dezel.extension

/**
 * Indicate whether an object is locked.
 * @function isLocked
 * @since 0.7.0
 */
fun isLocked(lock: Any?, key: Any?): Boolean {

	if (lock == null) {
		return false
	}

	if (key != null) {
		return lock === key
	}

	return true
}
