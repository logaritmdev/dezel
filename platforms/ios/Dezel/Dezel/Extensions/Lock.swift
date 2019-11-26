/**
 * Indicate whether an object is locked.
 * @function isLocked
 * @since 0.7.0
 */
func isLocked(_ lock: AnyObject?, key: AnyObject?) -> Bool {

	if (lock == nil) {
		return false
	}

	return lock !== key
}
