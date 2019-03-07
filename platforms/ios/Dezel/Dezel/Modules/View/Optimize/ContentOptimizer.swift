/**
 * The base class for content optimizers.
 * @class ContentOptimizer
 * @since 0.2.0
 */
open class ContentOptimizer : JavaScriptClass, View.Delegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The optimized view.
	 * @property view
	 * @since 0.2.0
	 */
	public weak var view: View!

	/**
	 * The items that are displayed.
	 * @property items
	 * @since 0.2.0
	 */
	internal(set) public var items: [Int: View] = [:]

	/**
	 * The items that are cached.
	 * @property cache
	 * @since 0.2.0
	 */
	internal(set) public var cache: [String: [View]] = [:]

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Attaches this optimizer to a specified view.
	 * @method attach
	 * @since 0.2.0
	 */
	open func attach(_ view: View) {
		self.view = view
		self.view?.delegate = self
	}

	/**
	 * Detaches this optimizer from a specified view.
	 * @method detach
	 * @since 0.2.0
	 */
	open func detach() {

		self.view?.delegate = nil
		self.view = nil

		self.cache.values.forEach {
			$0.forEach {
				$0.unprotect()
				$0.destroy()
			}
		}

		self.items.removeAll()
		self.cache.removeAll()
	}

	/**
	 * Reloads this optimizer.
	 * @method reload
	 * @since 0.2.0
	 */
	open func reload() {
		self.items = [:]
	}

	/**
	 * Caches a item for future reuse.
	 * @method cacheItem
	 * @since 0.2.0
	 */
	open func cacheItem(_ item: View) {

		let type = item.className

		if (self.cache[type] == nil) {
			self.cache[type] = []
		}

		self.cache[type]?.append(item)
	}

	/**
	 * Returns an item that was previously used and cached.
	 * @method reuseItem
	 * @since 0.2.0
	 */
	open func reuseItem(_ type: String) -> View? {

		guard var cache = self.cache[type] else {
			return nil
		}

		guard let item = cache.pop() else {
			return nil
		}

		self.cache[type] = cache

		return item
	}

	//--------------------------------------------------------------------------
	// MARK: View Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method didBeginLayout
	 * @since 0.5.0
	 */
	open func didBeginLayout(view: View) {

	}

	/**
	 * @inherited
	 * @method didFinishLayout
	 * @since 0.5.0
	 */
	open func didFinishLayout(view: View) {

	}

	/**
	 * @inherited
	 * @method didScroll
	 * @since 0.5.0
	 */
	open func didScroll(view: View) {

	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_attach
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsFunction_attach(callback: JavaScriptFunctionCallback) {
		if let view = callback.argument(0).cast(View.self) {
			self.attach(view)
		}
	}

	/**
	 * @method jsFunction_detach
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsFunction_detach(callback: JavaScriptSetterCallback) {
		self.detach()
	}

	/**
	 * @method jsFunction_cacheItem
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsFunction_cacheItem(callback: JavaScriptFunctionCallback) {
		if let item = callback.argument(0).cast(View.self) {
			self.cacheItem(item)
		}
	}

	/**
	 * @method jsFunction_getItem
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsFunction_getItem(callback: JavaScriptFunctionCallback) {

		let index = callback.argument(0).number.int()
		if (index < 0) {
			return
		}

		guard let view = self.items[index] else {
			return
		}

		callback.returns(view.holder)
	}

	/**
	 * @method jsFunction_getItemIndex
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsFunction_getItemIndex(callback: JavaScriptFunctionCallback) {

		guard let item = callback.argument(0).cast(View.self) else {
			callback.returns(number: -1)
			return
		}

		guard let key = self.items.keyOf(item) else {
			callback.returns(number: -1)
			return
		}

		callback.returns(number: key)
	}
}
