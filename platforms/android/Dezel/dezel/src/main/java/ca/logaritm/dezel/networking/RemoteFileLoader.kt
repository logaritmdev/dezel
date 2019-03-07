package ca.logaritm.dezel.networking

import android.os.AsyncTask
import java.net.URL

/**
 * @class RemoteFileLoader
 * @since 0.1.0
 * @hidden
 */
public class RemoteFileLoader : AsyncTask<String, Void, String>() {

	/**
	 * @method doInBackground
	 * @since 0.1.0
	 * @hidden
	 */
	override fun doInBackground(vararg params: String): String {
		return URL(params[0]).openStream().reader().use {
			it.readText()
		}
	}
}