/**
 * The base class for content optimizers.
 * @class JavaScriptViewOptimizer
 * @since 0.7.0
 */
open class JavaScriptViewOptimizer : JavaScriptClass, JavaScriptView.Delegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The optimized view.
	 * @property view
	 * @since 0.7.0
	 */
	public weak var view: JavaScriptView!

	/**
	 * The items that are displayed.
	 * @property items
	 * @since 0.7.0
	 */
	internal(set) public var items: [Int: JavaScriptView] = [:]

	/**
	 * The items that are cached.
	 * @property cache
	 * @since 0.7.0
	 */
	internal(set) public var cache: [String: [JavaScriptView]] = [:]

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Attaches this optimizer to a specified view.
	 * @method attach
	 * @since 0.7.0
	 */
	open func attach(_ view: JavaScriptView) {
		self.view = view
		self.view?.delegate = self
	}

	/**
	 * Detaches this optimizer from a specified view.
	 * @method detach
	 * @since 0.7.0
	 */
	open func detach() {

		self.view?.delegate = nil
		self.view = nil

		self.cache.values.forEach {
			$0.forEach {
				$0.unprotect()
				$0.dispose()
			}
		}

		self.items.removeAll()
		self.cache.removeAll()
	}

	/**
	 * Reloads this optimizer.
	 * @method reload
	 * @since 0.7.0
	 */
	open func reload() {
		self.items = [:]
	}

	/**
	 * Caches a item for future reuse.
	 * @method cacheItem
	 * @since 0.7.0
	 */
	open func cacheItem(_ item: JavaScriptView) {

		let type = item.className

		if (self.cache[type] == nil) {
			self.cache[type] = []
		}

		self.cache[type]?.append(item)
	}

	/**
	 * Returns an item that was previously used and cached.
	 * @method reuseItem
	 * @since 0.7.0
	 */
	open func reuseItem(_ type: String) -> JavaScriptView? {

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
	 * @since 0.7.0
	 */
	open func didBeginLayout(view: JavaScriptView) {

	}

	/**
	 * @inherited
	 * @method didFinishLayout
	 * @since 0.7.0
	 */
	open func didFinishLayout(view: JavaScriptView) {

	}

	/**
	 * @inherited
	 * @method didScroll
	 * @since 0.7.0
	 */
	open func didScroll(view: JavaScriptView) {

	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_attach
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_attach(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptViewOptimizer.attach() requires 1 argument.")
		}

		if let view = callback.argument(0).cast(JavaScriptView.self) {
			self.attach(view)
		}
	}

	/**
	 * @method jsFunction_detach
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_detach(callback: JavaScriptSetterCallback) {
		self.detach()
	}

	/**
	 * @method jsFunction_cacheItem
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_cacheItem(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptViewOptimizer.cacheItem() requires 1 argument.")
		}

		if let item = callback.argument(0).cast(JavaScriptView.self) {
			self.cacheItem(item)
		}
	}

	/**
	 * @method jsFunction_getItem
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_getItem(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptViewOptimizer.getItem() requires 1 argument.")
		}

		let index = callback.argument(0).number.toInt()
		if (index < 0) {
			return
		}

		guard let view = self.items[index] else {
			return
		}

		callback.returns(view)
	}

	/**
	 * @method jsFunction_getItemIndex
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_getItemIndex(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptViewOptimizer.getItemIndex() requires 1 argument.")
		}

		guard let item = callback.argument(0).cast(JavaScriptView.self) else {
			callback.returns(-1)
			return
		}

		guard let key = self.items.keyOf(item) else {
			callback.returns(-1)
			return
		}

		callback.returns(key)
	}
}
