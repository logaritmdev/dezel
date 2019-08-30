package ca.logaritm.dezel.extension.widget

import android.content.Context
import android.content.res.ColorStateList
import android.graphics.*
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.view.View
import android.widget.Button

val textColor: Int = Color.parseColor("#212121")
val iconColor: Int = Color.parseColor("#757575")

/**
 * @class BottomSheetButton
 * @since 0.6.0
 * @hidden
 */
internal class BottomSheetButton(context: Context, text: String): Button(context) {

	init {
		this.text = text
		this.textSize = 18f
		this.typeface = Typeface.SANS_SERIF
		this.textAlignment = View.TEXT_ALIGNMENT_VIEW_START
		this.backgroundTintList = ColorStateList.valueOf(Color.WHITE)
		this.backgroundTintMode = null
		this.stateListAnimator = null
		this.transformationMethod = null
		this.setTextColor(textColor)
	}

	/**
	 * @method setIcon
	 * @since 1.0.0
	 * @hidden
	 */
	internal fun setIcon(image: Bitmap, width: Int, height: Int, space: Int) {

		val drawable = BitmapDrawable(this.context.resources,
			Bitmap.createScaledBitmap(
				image,
				width,
				height,
				true
			)
		)

		drawable.colorFilter = PorterDuffColorFilter(iconColor, PorterDuff.Mode.SRC_IN)

		this.setDrawableLeft(drawable)
		this.setDrawablePadding(space)
	}
}

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