package ca.logaritm.dezel.modules.locale

import android.text.TextUtils
import android.view.View
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptGetterCallback
import ca.logaritm.dezel.core.Property
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
	 * @property language
	 * @since 0.7.0
	 * @hidden
	 */
	private var language: Property

	/**
	 * @property region
	 * @since 0.7.0
	 * @hidden
	 */
	private var region: Property

	/**
	 * @property ltr
	 * @since 0.7.0
	 * @hidden
	 */
	private var ltr: Property

	/**
	 * @property rtl
	 * @since 0.7.0
	 * @hidden
	 */
	private var rtl: Property

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
		this.language = Property(locale.language)
		this.region = Property(locale.country)
		this.ltr = Property( TextUtils.getLayoutDirectionFromLocale(locale) == View.LAYOUT_DIRECTION_LTR)
		this.rtl = Property(TextUtils.getLayoutDirectionFromLocale(locale) == View.LAYOUT_DIRECTION_RTL)
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
