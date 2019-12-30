package ca.logaritm.dezel.extension.activity

import android.app.Activity
import android.graphics.Point
import android.os.Build
import android.provider.Settings
import android.util.Size
import android.util.SizeF
import ca.logaritm.dezel.view.graphic.Convert

/**
 * @property Activity.viewport
 * @since 0.5.0
 * @hidden
 */
internal val Activity.viewport: SizeF; get() {

	val viewport = Point()

	this.windowManager.defaultDisplay.getRealSize(viewport)

	if (this.navigationBarVisible) {
		viewport.y = viewport.y - this.navigationBarSize.height
	}

	val w = Convert.toDp(viewport.x)
	val h = Convert.toDp(viewport.y)

	return SizeF(w, h)
}

/**
 * @property Activity.navigationBarSize
 * @since 0.5.0
 * @hidden
 */
internal val Activity.navigationBarSize: Size; get() {

	val size = Point()
	val real = Point()

	this.windowManager.defaultDisplay.getSize(size)
	this.windowManager.defaultDisplay.getRealSize(real)

	return Size(real.x - size.x, real.y - size.y)
}

/**
 * @property Activity.navigationBarVisible
 * @since 0.5.0
 * @hidden
 */
internal val Activity.navigationBarVisible: Boolean; get()  {

	if (Build.FINGERPRINT.startsWith("generic")) {
		return true
	}

	if (this.isSamsungDevice) {
		try {
			return Settings.Global.getInt(this.contentResolver, "navigationbar_hide_bar_enabled") == 0
		} catch (e: Settings.SettingNotFoundException) {
			// ?
		}
	}

	val size = Point()
	val real = Point()

	this.windowManager.defaultDisplay.getSize(size)
	this.windowManager.defaultDisplay.getRealSize(real)

	return (
		size.x < real.x ||
		size.y < real.y
	)
}

/**
 * @property Activity.isSamsungDevice
 * @since 0.5.0
 * @hidden
 */
internal val Activity.isSamsungDevice: Boolean
	get() = Build.MANUFACTURER == "samsung"