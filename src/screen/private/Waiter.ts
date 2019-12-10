/**
 * @class Waiter
 * @since 0.7.0
 * @hidden
 */
export class Waiter {

	//--------------------------------------------------------------------------
	// Propertis
	//--------------------------------------------------------------------------

	/**
	 * @property promise
	 * @since 0.7.0
	 */
	public promise: Promise<any>

	/**
	 * @property done
	 * @since 0.7.0
	 */
	public clear: any

	//--------------------------------------------------------------------------
	// Propertis
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor() {
		this.promise = new Promise(done => {
			this.clear = done
		})
	}
}