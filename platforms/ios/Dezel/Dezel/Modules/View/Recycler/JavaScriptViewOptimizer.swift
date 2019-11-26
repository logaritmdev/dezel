/**
 * @class JavaScriptViewOptimizer
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptViewOptimizer : JavaScriptClass, JavaScriptView.Delegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.7.0
	 */
	public weak var view: JavaScriptView!

	/**
	 * @property items
	 * @since 0.7.0
	 */
	internal(set) public var items: [Int: JavaScriptView] = [:]

	/**
	 * @property cache
	 * @since 0.7.0
	 */
	internal(set) public var cache: [String: [JavaScriptView]] = [:]

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method attach
	 * @since 0.7.0
	 */
	open func attach(_ view: JavaScriptView) {
		self.view = view
		self.view?.delegate = self
	}

	/**
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
	 * @method reload
	 * @since 0.7.0
	 */
	open func reload() {
		self.items = [:]
	}

	/**
	 * @method cacheItem
	 * @since 0.7.0
	 */
	open func cacheItem(_ item: JavaScriptView) {

		let type = item.className.string

		if (self.cache[type] == nil) {
			self.cache[type] = []
		}

		self.cache[type]?.append(item)
	}

	/**
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
	 * @method didPrepareLayout
	 * @since 0.7.0
	 */
	open func didPrepareLayout(view: JavaScriptView) {

	}

	/**
	 * @method didResolveLayout
	 * @since 0.7.0
	 */
	open func didResolveLayout(view: JavaScriptView) {

	}

	/**
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
