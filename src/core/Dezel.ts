
/**
 * TODO
 * @class Dezel
 * @since 0.7.0
 */
export class Dezel {

	/**
	 * Imports a native class.
	 * @method import
	 * @since 0.7.0
	 */
	public static import(className: string, init: boolean = false): any {

		let Class = this.cache[className]
		if (Class == null) {
			Class = this.cache[className] = importClass(className)
		}

		return init ? new Class : Class
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property cache
	 * @since 0.7.0
	 * @hidden
	 */
	private static cache: any = {}

	/**
	 * @property native
	 * @since 0.7.0
	 * @hidden
	 */
	private static native: any
}
