/**
 * Symbols
 */
export const TYPE = Symbol('type')

/**
 * @class Event
 * @since 0.1.0
 */
export class Event {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property type
	 * @since 0.1.0
	 */
	public get type(): string {
		return this[TYPE]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(type: string, options?: EventInit) {

		this[TYPE] = type

		if (options) {
			Object.assign(this, options)
		}
	}

	/**
	 * @method preventDefault
	 * @since 0.1.0
	 */
	public preventDefault() {

	}

	/**
	 * @method stopPropagation
	 * @since 0.1.0
	 */
	public stopPropagation() {

	}

	/**
	 * @method stopImmediatePropagation
	 * @since 0.1.0
	 */
	public stopImmediatePropagation() {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	private [TYPE]: string
}

/**
 * @global Event
 * @since 0.1.0
 */
Object.defineProperty(self, "Event", {
	value: Event,
	writable: false,
	enumerable: false,
	configurable: true
})
