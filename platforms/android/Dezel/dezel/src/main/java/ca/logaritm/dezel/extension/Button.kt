package ca.logaritm.dezel.extension

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Color
import android.graphics.PorterDuff
import android.graphics.PorterDuffColorFilter
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.widget.Button

/**
 * @method Button.setDrawableLeft
 * @since 0.6.0
 * @hidden
 */
internal fun Button.setDrawableLeft(drawable: Drawable) {
	this.setCompoundDrawablesWithIntrinsicBounds(drawable, null, null, null)
}

/**
 * @method Button.setDrawablePadding
 * @since 0.6.0
 * @hidden
 */
internal fun Button.setDrawablePadding(padding: Int) {
	this.compoundDrawablePadding = padding
}

/**
 * @method Button.setIcon
 * @since 0.6.0
 * @hidden
 */
internal fun Button.setIcon(context: Context, image: Bitmap, width: Int, height: Int, space: Int) {

	val drawable = BitmapDrawable(
		context.resources,
		Bitmap.createScaledBitmap(
			image,
			width,
			height,
			true
		)
	)

	drawable.colorFilter = PorterDuffColorFilter(Color.argb(255, 0, 0, 0), PorterDuff.Mode.SRC_IN)

	this.setDrawableLeft(drawable)
	this.setDrawablePadding(space)
}