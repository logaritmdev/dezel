package ca.logaritm.dezel.view.drawable

import android.graphics.Bitmap
import android.graphics.Rect
import android.graphics.drawable.NinePatchDrawable

import java.nio.ByteBuffer
import java.nio.ByteOrder

/**
 * @class NineSliceDrawable
 * @super NinePatchDrawable
 * @since 0.1.0
 */
open class NineSliceDrawable(bitmap:Bitmap, t:Int, l:Int, r:Int, b:Int) : NinePatchDrawable(null, bitmap, getBytesBuffer(t, l, r, b), Rect(), "") {

	companion object {

		/**
		 * @property NO_COLOR
		 * @since 0.1.0
		 * @hidden
		 */
		private val NO_COLOR: Int = 0x00000001

		/**
		 * @method getBytesBuffer
		 * @since 0.1.0
		 * @hidden
		 */
		private fun getBytesBuffer(t:Int, l:Int, r:Int, b:Int) : ByteArray {
			val buffer = ByteBuffer.allocate(84).order(ByteOrder.nativeOrder())
			buffer.put(0x01.toByte())
			buffer.put(0x02.toByte())
			buffer.put(0x02.toByte())
			buffer.put(0x09.toByte())
			buffer.putInt(0)
			buffer.putInt(0)
			buffer.putInt(0)
			buffer.putInt(0)
			buffer.putInt(0)
			buffer.putInt(0)
			buffer.putInt(0)
			buffer.putInt(l)
			buffer.putInt(r)
			buffer.putInt(t)
			buffer.putInt(b)
			buffer.putInt(NO_COLOR)
			buffer.putInt(NO_COLOR)
			buffer.putInt(NO_COLOR)
			buffer.putInt(NO_COLOR)
			buffer.putInt(NO_COLOR)
			buffer.putInt(NO_COLOR)
			buffer.putInt(NO_COLOR)
			buffer.putInt(NO_COLOR)
			buffer.putInt(NO_COLOR)
			return buffer.array()
		}
	}
}
