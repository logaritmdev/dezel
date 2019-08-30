package ca.logaritm.dezel.modules.locale

import android.text.TextUtils
import android.view.View
import ca.logaritm.dezel.core.*
import java.util.*

/**
 * @class JavaScriptLocale
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptLocale(context: JavaScriptContext): JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * The locale's language.
	 * @property language
	 * @since 0.7.0
	 */
	public val language = JavaScriptProperty()

	/**
	 * The locale's region.
	 * @property region
	 * @since 0.7.0
	 */
	public val region = JavaScriptProperty()

	/**
	 * Whether the locale is left to right.
	 * @property ltr
	 * @since 0.7.0
	 */
	public val ltr = JavaScriptProperty()

	/**
	 * Whether the locale is right to left.
	 * @property ltr
	 * @since 0.7.0
	 */
	public val rtl = JavaScriptProperty()

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_language
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_language(callback: JavaScriptGetterCallback) {
		callback.returns(this.language)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_region
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_region(callback: JavaScriptGetterCallback) {
		callback.returns(this.region)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_ltr
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_ltr(callback: JavaScriptGetterCallback) {
		callback.returns(this.ltr)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rtl
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_rtl(callback: JavaScriptGetterCallback) {
		callback.returns(this.rtl)
	}

	//--------------------------------------------------------------------------
	// Initializer
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {

		val locale = Locale.getDefault()

		this.language.reset(locale.language)
		this.region.reset(locale.country)

		this.ltr.reset(TextUtils.getLayoutDirectionFromLocale(locale) == View.LAYOUT_DIRECTION_LTR)
		this.rtl.reset(TextUtils.getLayoutDirectionFromLocale(locale) == View.LAYOUT_DIRECTION_RTL)
	}
}
