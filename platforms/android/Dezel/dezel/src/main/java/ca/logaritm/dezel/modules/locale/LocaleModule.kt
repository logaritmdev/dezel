package ca.logaritm.dezel.modules.locale

import android.text.TextUtils
import android.view.View
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module
import java.util.*


/**
 * @class LocaleModule
 * @since 0.1.0
 * @hidden
 */
open class LocaleModule(context: JavaScriptContext) : Module(context) {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		val current = Locale.getDefault()
		val locale = this.context.createEmptyObject()
		locale.property("language", current.language)
		locale.property("region", current.country)
		locale.property("ltr", TextUtils.getLayoutDirectionFromLocale(current) == View.LAYOUT_DIRECTION_LTR)
		locale.property("rtl", TextUtils.getLayoutDirectionFromLocale(current) == View.LAYOUT_DIRECTION_RTL)
		this.context.global.property("locale", locale)
	}
}
