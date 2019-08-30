/**
 * Indicate whether an object is locked.
 * @function isLocked
 * @since 0.7.0
 */
func isLocked(_ lock: AnyObject?, key: AnyObject?) -> Bool {

	guard let lock = lock else {
		return false
	}

	if let key = key {
		return lock === key
	}

	return true
}
