package ca.logaritm.dezel.extension

import android.content.res.AssetManager
import java.io.InputStream

/**
 * @method getFile
 * @since 0.5.0
 * @hidden
 */
internal fun AssetManager.getFile(directory: String, named: String): InputStream? {
	try {
		return this.open(directory + "/" + named)
	} catch (e: Exception) {
		return null
	}
}

/**
 * @method getFile
 * @since 0.5.0
 * @hidden
 */
internal fun AssetManager.getFile(directory: String, match: Regex): InputStream? {

	val file: InputStream? = null

	try {

		this.list(directory).firstOrNull { match.matches(it) }?.let {
			return this.open("languages/$it")
		}

	} catch (e: Exception) {
		return null
	}

	return file
}