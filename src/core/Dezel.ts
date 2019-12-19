import { $classes } from './private/Dezel'
import { $objects } from './private/Dezel'
import { native } from '../native/native'
import { Application } from '../application/Application'

/**
 * @class Dezel
 * @since 0.7.0
 */
export class Dezel {

	/**
	 * Imports a native class to this context.
	 * @method importClass
	 * @since 0.7.0
	 */
	public static importClass(name: string): any {

		let value = this[$classes][name]
		if (value == null) {
			value = this[$classes][name] = importClass(name)
		}

		return value
	}

	/**
	 * Imports a native object to this context.
	 * @method importObject
	 * @since 0.7.0
	 */
	public static importObject(name: string) {

		let value = this[$objects][name]
		if (value == null) {
			value = this[$objects][name] = importObject(name)
		}

		return value
	}

	/**
	 * Registers the main application.
	 * @method registerApplication
	 * @since 0.7.0
	 */
	public static registerApplication(application: Application) {
		registerApplication(native(application))
		return this
	}

	/**
	 * Reloads the whole application.
	 * @method registerApplication
	 * @since 0.7.0
	 */
	public static reloadApplication() {
		reloadApplication()
		return this
	}

	/**
	 * Reloads the application styles only.
	 * @method registerApplication
	 * @since 0.7.0
	 */
	public static reloadApplicationStyles() {
		reloadApplicationStyles()
		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $classes
	 * @since 0.7.0
	 * @hidden
	 */
	private static [$classes]: any = {}

	/**
	 * @property $objects
	 * @since 0.7.0
	 * @hidden
	 */
	private static [$objects]: any = {}
}

/**
 * @const __util__
 * @since 0.7.0
 * @hidden
 */
declare const __util__: any

/**
 * @const importClass
 * @since 0.7.0
 * @hidden
 */
const importClass = __util__.importClass.bind(__util__)

/**
 * @const importObject
 * @since 0.7.0
 * @hidden
 */
const importObject = __util__.importObject.bind(__util__)

/**
 * @const registerApplication
 * @since 0.7.0
 * @hidden
 */
const registerApplication = __util__.registerApplication.bind(__util__)

/**
 * @const reloadApplication
 * @since 0.7.0
 * @hidden
 */
const reloadApplication = __util__.reloadApplication.bind(__util__)

/**
 * @const reloadApplicationStyles
 * @since 0.7.0
 * @hidden
 */
const reloadApplicationStyles = __util__.reloadApplicationStyles.bind(__util__)