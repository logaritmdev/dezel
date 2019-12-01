package ca.logaritm.dezel.modules.view.optimize

import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.extension.fatalError
import ca.logaritm.dezel.extension.type.keyOf
import ca.logaritm.dezel.extension.type.let
import ca.logaritm.dezel.extension.type.pop
import ca.logaritm.dezel.modules.view.JavaScriptView

/**
 * The base class for items optimizers.
 * @class JavaScriptViewOptimizer
 * @since 0.7.0
 */
open class JavaScriptViewOptimizer(context: JavaScriptContext) : JavaScriptClass(context), JavaScriptView.JavaScriptViewListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The optimized view.
	 * @property view
	 * @since 0.7.0
	 */
	public lateinit var view: JavaScriptView

	/**
	 * The items that are displayed.
	 * @property items
	 * @since 0.7.0
	 */
	public var items: MutableMap<Int, JavaScriptView> = mutableMapOf()
		private set

	/**
	 * The items that are cached.
	 * @property cache
	 * @since 0.7.0
	 */
	public var cache: MutableMap<String, MutableList<JavaScriptView>> = mutableMapOf()
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Attaches this optimizer to a specified view.
	 * @method attach
	 * @since 0.7.0
	 */
	open fun attach(view: JavaScriptView) {
		this.view = view
		this.view.listener = this
	}

	/**
	 * Detaches this optimizer from a specified view.
	 * @method detach
	 * @since 0.7.0
	 */
	open fun detach() {

		this.view.listener = null

		this.cache.values.forEach {
			it.forEach {
				it.unprotect()
				it.dispose()
			}
		}

		this.items.clear()
		this.cache.clear()
	}

	/**
	 * Reloads this optimizer.
	 * @method reload
	 * @since 0.7.0
	 */
	open fun reload() {
		this.items = mutableMapOf()
	}

	/**
	 * Caches an item for future use.
	 * @method cacheItem
	 * @since 0.7.0
	 */
	open fun cacheItem(item: JavaScriptView) {

		val type = item.className

		if (this.cache[type] == null) {
			this.cache[type] = mutableListOf()
		}

		this.cache[type]?.add(item)
	}

	/**
	 * Returns an item that was previously used and cached.
	 * @method reuseItem
	 * @since 0.7.0
	 */
	open fun reuseItem(type: String): JavaScriptView? {

		val cache = this.cache[type]
		if (cache == null) {
			return null
		}

		val item = cache.pop()
		if (item == null) {
			return null
		}

		this.cache[type] = cache

		return item
	}

	//--------------------------------------------------------------------------
	//  JavaScriptView Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method onBeginLayout
	 * @since 0.7.0
	 */
	override fun onBeginLayout(view: JavaScriptView) {

	}

	/**
	 * @method onFinishLayout
	 * @since 0.7.0
	 */
	override fun onFinishLayout(view: JavaScriptView) {

	}

	/**
	 * @method onScroll
	 * @since 0.7.0
	 */
	override fun onScroll(view: JavaScriptView) {

	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_attach
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_attach(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptViewOptimizer.attach() requires 1 argument.")
		}

		val view = callback.argument(0)

		view.cast(JavaScriptView::class.java).let {
			this.attach(it)
		}
	}

	/**
	 * @method jsFunction_detach
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_detach(callback: JavaScriptFunctionCallback) {
		this.detach()
	}

	/**
	 * @method jsFunction_cacheItem
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_cacheItem(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptViewOptimizer.cacheItem() requires 1 argument.")
		}

		val view = callback.argument(0)

		view.cast(JavaScriptView::class.java).let {
			this.cacheItem(it)
		}
	}

	/**
	 * @method jsFunction_getItem
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_getItem(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptViewOptimizer.getItem() requires 1 argument.")
		}

		val index = callback.argument(0).number.toInt()
		if (index < 0) {
			return
		}

		val view = this.items[index]
		if (view == null) {
			return
		}

		callback.returns(view)
	}

	/**
	 * @method jsFunction_getItemIndex
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_getItemIndex(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptViewOptimizer.getItemIndex() requires 1 argument.")
		}

		val item = callback.argument(0).cast(JavaScriptView::class.java)
		if (item == null) {
			callback.returns(-1)
			return
		}

		val key = this.items.keyOf(item)
		if (key == null) {
			callback.returns(-1.0)
			return
		}

		callback.returns(key)
	}
}
