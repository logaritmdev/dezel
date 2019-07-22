import { Application } from '../application/Application'

/**
 * TODO
 * @class Dezel
 * @since 0.7.0
 */
export class Dezel {

	/**
	 * Imports a native class.
	 * @method importClass
	 * @since 0.7.0
	 */
	public static importClass(uid: string, init: boolean = false): any {

		let Class = this.classes[uid]
		if (Class == null) {
			Class = this.classes[uid] = importClass(uid)
		}

		return init ? new Class : Class
	}

	/**
	 * Imports a native object.
	 * @method importObject
	 * @since 0.7.0
	 */
	public static importObject(uid: string) {

		let object = this.objects[uid]
		if (object == null) {
			object = this.objects[uid] = importObject(uid)
		}

		return object
	}

	/**
	 * Register the main application.
	 * @method registerApplication
	 * @since 0.7.0
	 */
	public static registerApplication(application: Application, uid: string = '') {

		if (uid == '') {
			uid = 'default'
		}

		registerApplication(toNative(application), uid || 'dezel.application.main')
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property classes
	 * @since 0.7.0
	 * @hidden
	 */
	private static classes: any = {}

	/**
	 * @property objects
	 * @since 0.7.0
	 * @hidden
	 */
	private static objects: any = {}

	/**
	 * @property native
	 * @since 0.7.0
	 * @hidden
	 */
	private static native: any
}
