/**
 * @class Styler
 * @since 0.1.0
 */
open class Styler {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property root
	 * @since 0.1.0
	 */
	open var root: StylerNode? {
		willSet {
			DLStylerSetRoot(self.handle, newValue?.handle)
		}
	}

	/**
	 * @property handle
	 * @since 0.1.0
	 * @hidden
	 */
	internal var handle: DLStylerNodeRef!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init() {
		self.handle = DLStylerCreate()
	}

	/**
	 * @destructor
	 * @since 0.1.0
	 */
	deinit {
		DLStylerDelete(self.handle)
	}

	/**
	 * Loads the specified styles.
	 * @method load
	 * @since 0.3.0
	 */
	open func load(_ code: String, file: String) {
		DLStylerLoadStyles(self.handle, code, file)
	}

	/**
	 * Sets a numeric variable on the context.
	 * @method setVariable
	 * @since 0.3.0
	 */
	open func setVariable(_ name: String, value: String) {
		DLStylerSetVariable(self.handle, name, value)
	}
}
