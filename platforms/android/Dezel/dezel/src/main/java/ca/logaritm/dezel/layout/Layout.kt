package ca.logaritm.dezel.layout

import ca.logaritm.dezel.extension.Delegates

/**
 * The layout manager.
 * @class Layout
 * @since 0.4.0
 */
open class Layout {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property invalid
	 * @since 0.4.0
	 */
	open var invalid: Boolean = false
		get() = LayoutExternal.isInvalid(this.handle)

	/**
	 * @property resolving
	 * @since 0.4.0
	 */
	open var resolving: Boolean = false
		get() = LayoutExternal.isResolving(this.handle)

	/**
	 * @property root
	 * @since 0.4.0
	 */
	open var root: LayoutNode? by Delegates.OnSetOptional<LayoutNode>(null) { value ->
		LayoutExternal.setRoot(this.handle, value?.handle ?: 0)
	}

	/**
	 * @property viewportWidth
	 * @since 0.4.0
	 */
	open var viewportWidth: Float by Delegates.OnSet(0f) { value ->
		LayoutExternal.setViewportWidth(this.handle, value.toDouble())
	}

	/**
	 * @property viewportHeight
	 * @since 0.4.0
	 */
	open var viewportHeight: Float by Delegates.OnSet(0f) { value ->
		LayoutExternal.setViewportHeight(this.handle, value.toDouble())
	}

	/**
	 * @property scale
	 * @since 0.4.0
	 */
	open var scale: Float by Delegates.OnSet(1f) { value ->
		LayoutExternal.setScale(this.handle, value.toDouble())
	}

	/**
	 * @property handle
	 * @since 0.4.0
	 * @hidden
	 */
	public var handle: Long
		private set

	/**
	 * @property layoutBeganCallbacks
	 * @since 0.4.0
	 * @hidden
	 */
	private var layoutBeganCallbacks: MutableList<LayoutBeganCallback> = mutableListOf()

	/**
	 * @property layoutEndedCallbacks
	 * @since 0.4.0
	 * @hidden
	 */
	private var layoutEndedCallbacks: MutableList<LayoutEndedCallback> = mutableListOf()

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 * @hidden
	 */
	init {
		this.handle = LayoutExternal.create(this)
		LayoutReference.register(this)
	}

	/**
	 * Requests a handler that will be executed when the global layout begins.
	 * @method requestLayoutBeganCallback
	 * @since 0.4.0
	 */
	public fun requestLayoutBeganCallback(callback: (() -> Unit)) {
		this.layoutBeganCallbacks.add(LayoutBeganCallback(callback))
	}

	/**
	 * Requests a handler that will be executed when the global layout finishes.
	 * @method requestLayoutEndedCallback
	 * @since 0.4.0
	 */
	open fun requestLayoutEndedCallback(callback: (() -> Unit)) {
		this.layoutEndedCallbacks.add(LayoutEndedCallback(callback))
	}

	/**
	 * @method dispatchLayoutBeganEvent
	 * @since 0.4.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun dispatchLayoutBeganEvent() {
		this.layoutBeganCallbacks.forEach { it.callback() }
		this.layoutBeganCallbacks.clear()
	}

	/**
	 * @method dispatchLayoutEndedEvent
	 * @since 0.4.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun dispatchLayoutEndedEvent() {
		this.layoutEndedCallbacks.forEach { it.callback() }
		this.layoutEndedCallbacks.clear()
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class LayoutBeganCallback
	 * @since 0.4.0
	 * @hidden
	 */
	private data class LayoutBeganCallback(val callback: (() -> Unit))

	/**
	 * @class LayoutEndedCallback
	 * @since 0.4.0
	 * @hidden
	 */
	private data class LayoutEndedCallback(val callback: (() -> Unit))
}