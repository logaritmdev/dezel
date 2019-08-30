package ca.logaritm.dezel.modules.device

import android.content.Context.VIBRATOR_SERVICE
import android.content.SharedPreferences
import android.media.MediaActionSound
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.core.JavaScriptGetterCallback
import ca.logaritm.dezel.extension.fatalError
import java.util.*

/**
 * @class JavaScriptDevice
 * @since 0.4.0
 * @hidden
 */
open class JavaScriptDevice(context: JavaScriptContext): JavaScriptClass(context) {

	/**
	 * @property preferences
	 * @since 0.1.0
	 * @hidden
	 */
	private val preferences: SharedPreferences = this.context.application.getSharedPreferences("dezel.device.uuid", android.content.Context.MODE_PRIVATE)

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_name
	 * @since 0.4.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_uuid(callback: JavaScriptGetterCallback) {

		var value = this.preferences.getString("dezel.device.uuid", null)
		if (value == null) {

			val editor = this.preferences.edit()
			if (editor == null) {
				return
			}

			value = UUID.randomUUID().toString()

			editor.putString("dezel.device.uuid", value)
			editor.apply()
		}

		callback.returns(value)
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_sound
	 * @since 0.4.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_sound(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("sound requires 1 argument")
		}

		val sound = callback.argument(0)

		if (sound.isString) {

			when (sound.string) {

				"shutter" -> {
					MediaActionSound().play(MediaActionSound.SHUTTER_CLICK)
					return
				}

			}

			return
		}

		MediaActionSound().play(sound.number.toInt())
	}

	/**
	 * @method jsFunction_vibrate
	 * @since 0.4.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_vibrate(callback: JavaScriptFunctionCallback) {

		val vibrator: Vibrator

		try {
			vibrator = this.context.application.getSystemService(VIBRATOR_SERVICE) as Vibrator
		} catch (e: Exception) {
			return
		}

		if (callback.arguments == 0) {

			if (Build.VERSION.SDK_INT >= 26) {
				vibrator.vibrate(VibrationEffect.createOneShot(150, VibrationEffect.DEFAULT_AMPLITUDE))
			} else {
				vibrator.vibrate(150)
			}

			return
		}
	}
}
