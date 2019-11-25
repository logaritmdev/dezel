import { Application } from '../application/Application'
import { native } from '../native/native'
import { $classes } from './symbol/Dezel'
import { $objects } from './symbol/Dezel'

/**
 * @class Dezel
 * @since 0.7.0
 */
export class Dezel {

	/**
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
	 * @method registerApplication
	 * @since 0.7.0
	 */
	public static registerApplication(application: Application) {
		registerApplication(native(application))
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