import ObjectiveC

private var canceledKey: UInt8 = 0
private var capturedKey: UInt8 = 0
private var receiverKey: UInt8 = 0
private var touchCanceledKey: UInt8 = 0

/**
* @extension UITouch
* @since 0.7.0
* @hidden
*/
extension UITouch {

	/**
	 * @property canceled
	 * @since 0.7.0
	 * @hidden
	 */
    var canceled: Bool {

        get {
            return objc_getAssociatedObject(self, &canceledKey) as? Bool ?? false
        }

        set {
            objc_setAssociatedObject(self, &canceledKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

	/**
	 * @property captured
	 * @since 0.7.0
	 * @hidden
	 */
    var captured: Bool {

        get {
            return objc_getAssociatedObject(self, &capturedKey) as? Bool ?? false
        }

        set {
            objc_setAssociatedObject(self, &capturedKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

	/**
	 * @property receiver
	 * @since 0.7.0
	 * @hidden
	 */
    var receiver: UIView? {

        get {
            return objc_getAssociatedObject(self, &receiverKey) as? UIView
        }

        set {
            objc_setAssociatedObject(self, &receiverKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

	/**
	 * @property touchCanceled
	 * @since 0.7.0
	 * @hidden
	 */
    var touchCanceled: Bool {

		get {
			return objc_getAssociatedObject(self, &touchCanceledKey) as? Bool ?? false
		}

		set {
			objc_setAssociatedObject(self, &touchCanceledKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
		}
	}
}
