/**
 * Symbols
 */
export const TYPE = Symbol('type')

interface EventInit {
	bubbles?: boolean
	cancelable?: boolean
	composed?: boolean
}

/**
 * TODO
 * @class Event
 * @since 0.7.0
 */
export class Event {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * TODO
	 * @property type
	 * @since 0.7.0
	 */
	public get type(): string {
		return this[TYPE]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(type: string, options?: any) {

		this[TYPE] = type

		if (options) {
			Object.assign(this, options)
		}
	}

	/**
	 * TODO
	 * @method preventDefault
	 * @since 0.7.0
	 */
	public preventDefault() {

	}

	/**
	 * TODO
	 * @method stopPropagation
	 * @since 0.7.0
	 */
	public stopPropagation() {

	}

	/**
	 * TODO
	 * @method stopImmediatePropagation
	 * @since 0.7.0
	 */
	public stopImmediatePropagation() {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property TYPE
	 * @since 0.7.0
	 * @hidden
	 */
	private [TYPE]: string
}

interface ProgressEventInit extends EventInit {
	lengthComputable?: boolean
	loaded?: number
	total?: number
}

/**
 * @class ProgressEvent
 * @since 0.7.0
 */
export class ProgressEvent extends Event {
	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(type: string, options?: ProgressEventInit) {
		super(type, options)
	}
}

/**
 * @class MessageEvent
 * @since 0.7.0
 */
export class MessageEvent extends Event {

}


/**
 * @class CloseEvent
 * @since 0.7.0
 */
export class CloseEvent extends Event {

}
