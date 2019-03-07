import { bound } from '../decorator/bound'
import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Emitter } from '../event/Emitter'

@bridge('dezel.i18n.TranslationManager')

/**
 * Manages translations.
 * @class TranslationManager
 * @super Emitter
 * @since 0.5.0
 */
export class TranslationManager extends Emitter {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * The default translation manager.
	 * @property main
	 * @since 0.5.0
	 */
	public static get main(): TranslationManager {

		if (main == null) {
			main = new TranslationManager()
		}

		return main
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Loads a file or let the system decide which file to use.
	 * @method load
	 * @since 0.5.0
	 */
	public load(file?: string) {
		return file
			? this.native.load(file)
			: this.native.load()
	}

	/**
	 * Translates a message.
	 * @method translate
	 * @since 0.5.0
	 */
	public translate(message: string, context: string | null = null): string {
		return context
			? this.native.translate(message, context)
			: this.native.translate(message)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.5.0
	 * @hidden
	 */
	public native: any

}

/**
 * The main translation manager.
 * @var main
 * @since 0.5.0
 */
let main: TranslationManager | null = null

/**
 * Common function used to translate text.
 * @function t
 * @since 0.5.0
 */
export function t(message: string, context?: string) {
	return TranslationManager.main.translate(message, context)
}

/**
 * Translates text.
 * @function __
 * @since 0.5.0
 */
export function __(message: string) {
	return TranslationManager.main.translate(message)
}

/**
 * Translates context text.
 * @function _x
 * @since 0.5.0
 */
export function _x(message: string, context: string) {
	return TranslationManager.main.translate(message, context)
}
