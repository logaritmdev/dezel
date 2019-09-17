package ca.logaritm.dezel.view.display

/**
 * Manages a display of nodes.
 * @class Display
 * @since 0.7.0
 */
public class Display {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the layout is invalid.
	 * @property invalid
	 * @since 0.7.0
	 */
	public val invalid: Boolean
		get() = DisplayExternal.isInvalid(this.handle)

	/**
	 * Whether the layout is resolving.
	 * @property resolving
	 * @since 0.7.0
	 */
	public val resolving: Boolean
		get() = DisplayExternal.isResolving(this.handle)

	/**
	 * @property handle
	 * @since 0.7.0
	 * @hidden
	 */
	public var handle: Long
		private set

	/**
	 * @property layoutBeganCallbacks
	 * @since 0.7.0
	 * @hidden
	 */
	private var layoutBeganCallbacks: MutableList<() -> Unit> = mutableListOf()

	/**
	 * @property layoutEndedCallbacks
	 * @since 0.7.0
	 * @hidden
	 */
	private var layoutEndedCallbacks: MutableList<() -> Unit> = mutableListOf()

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {
		this.handle = DisplayExternal.create(this)
		DisplayReference.register(this)
	}

	/**
	 * Assigns the display's viewport width.
	 * @property setViewportWidth
	 * @since 0.7.0
	 */
	public fun setViewportWidth(value: Float) {
		DisplayExternal.setViewportWidth(this.handle, value.toDouble())
	}

	/**
	 * Assigns the display's viewport height.
	 * @method setViewportHeight
	 * @since 0.7.0
	 */
	public fun setViewportHeight(value: Float) {
		DisplayExternal.setViewportHeight(this.handle, value.toDouble())
	}

	/**
	 * Assigns the display's scale.
	 * @property setScale
	 * @since 0.7.0
	 */
	public fun setScale(value: Float) {
		DisplayExternal.setScale(this.handle, value.toDouble())
	}

	/**
	 * Assigns the display's window.
	 * @property setWindow
	 * @since 0.7.0
	 */	
	public fun setWindow(window: DisplayNode) {
		DisplayExternal.setWindow(this.handle, window.handle)
	}

	/**
	 * Requests a handler that will be executed when the global layout begins.
	 * @method requestLayoutBeganCallback
	 * @since 0.7.0
	 */
	public fun requestLayoutBeganCallback(callback: (() -> Unit)) {
		this.layoutBeganCallbacks.add(callback)
	}

	/**
	 * Requests a handler that will be executed when the global layout finishes.
	 * @method requestLayoutEndedCallback
	 * @since 0.7.0
	 */
	public fun requestLayoutEndedCallback(callback: (() -> Unit)) {
		this.layoutEndedCallbacks.add(callback)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method layoutBegan
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun layoutBegan() {
		this.dispatchLayoutBeganEvent()
	}

	/**
	 * @method layoutEnded
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	private fun layoutEnded() {
		this.dispatchLayoutEndedEvent()
	}

	/**
	 * @method dispatchLayoutBeganEvent
	 * @since 0.7.0
	 * @hidden
	 */
	private fun dispatchLayoutBeganEvent() {
		this.layoutBeganCallbacks.forEach { it() }
		this.layoutBeganCallbacks.clear()
	}

	/**
	 * @method dispatchLayoutEndedEvent
	 * @since 0.7.0
	 * @hidden
	 */
	private fun dispatchLayoutEndedEvent() {
		this.layoutEndedCallbacks.forEach { it() }
		this.layoutEndedCallbacks.clear()
	}
}