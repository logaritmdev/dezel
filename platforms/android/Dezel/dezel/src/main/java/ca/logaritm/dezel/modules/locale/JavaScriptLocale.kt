package ca.logaritm.dezel.modules.locale

import android.text.TextUtils
import android.view.View
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptGetterCallback
import ca.logaritm.dezel.core.JavaScriptProperty
import java.util.*

/**
 * @class JavaScriptLocale
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptLocale(context: JavaScriptContext): JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The locale language.
	 * @property language
	 * @since 0.7.0
	 */
	open val language: JavaScriptProperty by lazy {
		JavaScriptProperty(context)
	}

	/**
	 * The locale region.
	 * @property region
	 * @since 0.7.0
	 */
	open val region: JavaScriptProperty by lazy {
		JavaScriptProperty(context)
	}

	/**
	 * Whether the locale is left to right.
	 * @property ltr
	 * @since 0.7.0
	 */
	open val ltr: JavaScriptProperty by lazy {
		JavaScriptProperty(context)
	}

	/**
	 * Whether the locale is right to left.
	 * @property ltr
	 * @since 0.7.0
	 */
	open val rtl: JavaScriptProperty by lazy {
		JavaScriptProperty(context)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {
		val locale = Locale.getDefault()
		this.language.set(locale.language)
		this.region.set(locale.country)
		this.ltr.set(TextUtils.getLayoutDirectionFromLocale(locale) == View.LAYOUT_DIRECTION_LTR)
		this.rtl.set(TextUtils.getLayoutDirectionFromLocale(locale) == View.LAYOUT_DIRECTION_RTL)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
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
}
