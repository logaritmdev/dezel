/**
 * @class TranslationModule
 * @since 0.5.0
 */
open class TranslationModule : Module {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.5.0
	 */
	override open func initialize() {
		self.context.registerClass("dezel.i18n.TranslationManager", type: TranslationManager.self)
	}
}
