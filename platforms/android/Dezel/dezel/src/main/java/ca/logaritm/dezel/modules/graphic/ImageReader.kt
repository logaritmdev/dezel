package ca.logaritm.dezel.modules.graphic

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import ca.logaritm.dezel.extension.type.baseName
import ca.logaritm.dezel.extension.type.fileExt
import ca.logaritm.dezel.extension.type.fileName
import java.io.IOException
import java.io.InputStream
import kotlin.math.ceil

/**
 * @class ImageReader
 * @since 0.7.0
 */
public object ImageReader {

    /**
     * @property assets
     * @since 0.1.0
     * @hidden
     */
    private var assets: MutableMap<String, Array<String>> = mutableMapOf()

    /**
     * @method read
     * @since 0.7.0
     */
    public fun read(context: Context, source: String, callback: (Bitmap) -> Unit) {

        var path = source

        /*
         * This does not handle relative path starting with ./ very well. This is
         * a hopefully temporary hack to remove the first ./ from the beginning
         */

        if (path.startsWith("./")) {
            path = path.substring(2)
        }

        var stream: ImageStream? = null

        if (path.startsWith("content://")) {

            try {

                val input = context.contentResolver.openInputStream(Uri.parse(path))
                if (input == null) {
                    throw Error("Invalid content stream.")
                }

                stream = ImageStream(input, 1)

            } catch (e: Exception) {

            }

        } else {
            stream = this.getImageStream(context, path)
        }

        if (stream == null) {
            throw Exception("Unable to read stream at $path")
        }

        val dpi = context.resources.displayMetrics.densityDpi

        val options = BitmapFactory.Options()
        options.inDensity = stream.scale * 160
        options.inTargetDensity = dpi
        options.inScreenDensity = dpi

        val bitmap = BitmapFactory.decodeStream(stream, null, options)
        if (bitmap == null) {
            throw Exception("Unable to decode bitmap.")
        }

        callback(bitmap)
    }

    /**
     * @method getImageStream
     * @since 0.1.0
     * @hidden
     */
    private fun getImageStream(context: Context, file: String): ImageStream? {

        val dir = file.baseName

        var files = assets[dir]
        if (files == null) {
            files = context.assets.list(dir)
            assets[dir] = files
        }

        if (files == null) {
            return null
        }

        val density = ceil(context.resources.displayMetrics.density).toInt()

        var image = this.getImagePath(file, density, files)
        var scale = density

        if (image == null) {
            image = this.getImagePath(file, 4, files)
            scale = 4
        }

        if (image == null) {
            image = this.getImagePath(file, 3, files)
            scale = 3
        }

        if (image == null) {
            image = this.getImagePath(file, 2, files)
            scale = 2
        }

        if (image == null) {
            image = this.getImagePath(file, 1, files)
            scale = 1
        }

        if (image == null) {
            image = file
            scale = 1
        }

        val stream: InputStream

        try {
            stream = context.assets.open(image)
        } catch (exception: IOException) {
            return null
        }

        return ImageStream(stream, scale)
    }

    /**
     * @method getImagePath
     * @since 0.1.0
     * @hidden
     */
    private fun getImagePath(file: String, density: Int, files: Array<String>): String? {

        val baseName = file.baseName
        val fileName = file.fileName
        val fileType = file.fileExt

        val image = "$fileName@${density}x$fileType"

        for (item in files) {
            if (image == item) {
                return "$baseName/$image"
            }
        }

        return null
    }

    /**
     * @class ImageStream
     * @since 0.1.0
     * @hidden
     */
    private class ImageStream(val stream: InputStream, val scale: Int) : InputStream() {

        /**
         * @method read
         * @since 0.1.0
         * @hidden
         */
        @Throws(IOException::class)
        override fun read(): Int {
            return this.stream.read()
        }
    }    

}