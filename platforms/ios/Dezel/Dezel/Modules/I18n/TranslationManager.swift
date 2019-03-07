/**
 * @class TranslationManager
 * @since 0.5.0
 * @hidden
 */
public class TranslationManager: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The translation file used.
	 * @property file
	 * @since 0.5.0
	 */
	private(set) public var file: TranslationFile?

	//--------------------------------------------------------------------------
	// MARK: JS Methods
	//--------------------------------------------------------------------------

	/**
     * @method jsFunction_load
     * @since 0.5.0
     * @hidden
     */
	@objc open func jsFunction_load(callback: JavaScriptFunctionCallback) {

		switch (callback.arguments) {

			case 0: self.file = TranslationFile()
			case 1: self.file = TranslationFile(file: callback.argument(0).string)

			default:
				break
		}

		callback.returns(boolean: self.file!.loaded)
	}

	/**
     * @method jsFunction_translate
     * @since 0.5.0
     * @hidden
     */
	@objc open func jsFunction_translate(callback: JavaScriptFunctionCallback) {

		switch (callback.arguments) {

			case 1:

				callback.returns(string: DLTranslationManagerTranslate(
					callback.argument(0).string, nil
				).string)

			case 2:

				callback.returns(string: DLTranslationManagerTranslate(
					callback.argument(0).string,
					callback.argument(1).string
				).string)

			default:
				break
		}
	}
}
