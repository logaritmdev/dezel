import { $type } from './private/Event'

/**
 * @class Event
 * @since 0.7.0
 */
export class Event {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property type
	 * @since 0.7.0
	 */
	public get type(): string {
		return this[$type]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(type: string, options?: any) {

		this[$type] = type

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
	 * @method stopPropagation
	 * @since 0.7.0
	 */
	public stopPropagation() {

	}

	/**
	 * @method stopImmediatePropagation
	 * @since 0.7.0
	 */
	public stopImmediatePropagation() {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $type
	 * @since 0.7.0
	 * @hidden
	 */
	private [$type]: string
}

/**
 * @interface EventInit
 * @since 0.7.0
 */
interface EventInit {
	bubbles?: boolean
	cancelable?: boolean
	composed?: boolean
}

/**
 * @interface ProgressEventInit
 * @since 0.7.0
 */
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
