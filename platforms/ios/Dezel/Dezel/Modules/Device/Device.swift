import AudioToolbox

/**
 * @class Device
 * @since 0.4.0
 * @hidden
 */
open class Device: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_name
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_uuid(callback: JavaScriptGetterCallback) {

		var uuid = UserDefaults.standard.string(forKey: "dezel.device.uuid")
		if (uuid == nil) {
			uuid = UUID().uuidString
			UserDefaults.standard.set(uuid, forKey: "dezel.device.uuid")
		}

		callback.returns(string: uuid!)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_sound
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_sound(callback: JavaScriptFunctionCallback) {

		switch (callback.argument(0).string) {

			case "shutter":
				AudioServicesPlaySystemSound(SystemSoundID(1108))
				return

			default:
				break
		}

		AudioServicesPlaySystemSound(SystemSoundID(callback.argument(0).number.int()))
	}

	/**
	 * @method jsFunction_vibrate
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsFunction_vibrate(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			AudioServicesPlaySystemSound(SystemSoundID(4095))
			return
		}

		if (callback.arguments == 1) {

			switch (callback.argument(0).string) {

				case "peek":
					AudioServicesPlaySystemSound(SystemSoundID(1519))
					return

				case "pop":
					AudioServicesPlaySystemSound(SystemSoundID(1520))
					return

				case "cancel":
					AudioServicesPlaySystemSound(SystemSoundID(1521))
					return

				case "retry":
					AudioServicesPlaySystemSound(SystemSoundID(1102))
					return

				case "failed":
					AudioServicesPlaySystemSound(SystemSoundID(1107))
					return

				default:
					AudioServicesPlaySystemSound(SystemSoundID(4095))
					break
			}
		}

		AudioServicesPlaySystemSound(SystemSoundID(callback.argument(0).number.int()))
	}
}
