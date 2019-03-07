package ca.logaritm.dezel.style

import ca.logaritm.dezel.extension.Delegates

/**
 * Contextual image required by styless.
 * @class Styler
 * @since 0.4.0
 */
open class Styler() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property root
	 * @since 0.4.0
	 */
	open var root: StylerNode? by Delegates.OnSetOptional<StylerNode>(null) { value ->
		StylerExternal.setRoot(this.handle, value?.handle ?: 0)
	}

	/**
	 * @property handle
	 * @since 0.4.0
	 * @hidden
	 */
	internal var handle: Long = 0

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 */
	init {
		this.handle = StylerExternal.create()
		StylerReference.register(this)
	}

	/**
	 * Loads the specified styles.
	 * @method load
	 * @since 0.3.0
	 */
	open fun load(code: String, file: String) {
		StylerExternal.load(this.handle, code, file)
	}

	/**
	 * Sets a numeric variable on the context.
	 * @method setVariable
	 * @since 0.3.0
	 */
	open fun setVariable(name: String, value: String) {
		StylerExternal.setVariable(this.handle, name, value)
	}
}
