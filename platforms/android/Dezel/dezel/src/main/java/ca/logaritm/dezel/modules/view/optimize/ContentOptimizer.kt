package ca.logaritm.dezel.modules.view.optimize

import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.extension.keyOf
import ca.logaritm.dezel.extension.pop
import ca.logaritm.dezel.modules.view.View

/**
 * The base class for items optimizers.
 * @class ContentOptimizer
 * @since 0.2.0
 */
open class ContentOptimizer(context: JavaScriptContext) : JavaScriptClass(context), View.Listener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The optimized view.
	 * @property view
	 * @since 0.2.0
	 */
	public lateinit var view: View

	/**
	 * The items that are displayed.
	 * @property items
	 * @since 0.2.0
	 */
	public var items: MutableMap<Int, View> = mutableMapOf()
		private set

	/**
	 * The items that are cached.
	 * @property cache
	 * @since 0.2.0
	 */
	public var cache: MutableMap<String, MutableList<View>> = mutableMapOf()
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Attaches this optimizer to a specified view.
	 * @method attach
	 * @since 0.2.0
	 */
	open fun attach(view: View) {
		this.view = view
		this.view.listener = this
	}

	/**
	 * Detaches this optimizer from a specified view.
	 * @method detach
	 * @since 0.2.0
	 */
	open fun detach() {

		this.view.listener = null

		this.cache.values.forEach {
			it.forEach {
				it.unprotect()
				it.destroy()
			}
		}

		this.items.clear()
		this.cache.clear()
	}

	/**
	 * Reloads this optimizer.
	 * @method reload
	 * @since 0.2.0
	 */
	open fun reload() {
		this.items = mutableMapOf()
	}

	/**
	 * Caches an item for future use.
	 * @method cacheItem
	 * @since 0.2.0
	 */
	open fun cacheItem(item: View) {

		val type = item.className

		if (this.cache[type] == null) {
			this.cache[type] = mutableListOf()
		}

		this.cache[type]?.add(item)
	}

	/**
	 * Returns an item that was previously used and cached.
	 * @method reuseItem
	 * @since 0.2.0
	 */
	open fun reuseItem(type: String): View? {

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
	//  View Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onBeginLayout
	 * @since 0.5.0
	 */
	override fun onBeginLayout(view: View) {

	}

	/**
	 * @inherited
	 * @method onFinishLayout
	 * @since 0.5.0
	 */
	override fun onFinishLayout(view: View) {

	}

	/**
	 * @inherited
	 * @method onScroll
	 * @since 0.5.0
	 */
	override fun onScroll(view: View) {

	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_attach
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_attach(callback: JavaScriptFunctionCallback) {
		val view = callback.argument(0).cast(View::class.java)
		if (view != null) {
			this.attach(view)
		}
	}

	/**
	 * @method jsFunction_detach
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_detach(callback: JavaScriptFunctionCallback) {
		this.detach()
	}

	/**
	 * @method jsFunction_cacheItem
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_cacheItem(callback: JavaScriptFunctionCallback) {
		val view = callback.argument(0).cast(View::class.java)
		if (view != null) {
			this.cacheItem(view)
		}
	}

	/**
	 * @method jsFunction_getItem
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_getItem(callback: JavaScriptFunctionCallback) {

		val index = callback.argument(0).number.toInt()
		if (index < 0) {
			return
		}

		val view = this.items[index]
		if (view == null) {
			return
		}

		callback.returns(view.holder)
	}

	/**
	 * @method jsFunction_getItemIndex
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_getItemIndex(callback: JavaScriptFunctionCallback) {

		val item = callback.argument(0).cast(View::class.java)
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
