/**
 * Optimizes contents displayed as a list.
 * @class JavaScriptListOptimizer
 * @super JavaScriptViewOptimizer
 * @since 0.7.0
 */
open class JavaScriptListOptimizer : JavaScriptViewOptimizer {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The optimized content's orientation.
	 * @property orientation
	 * @since 0.2.0
	 */
	open var orientation: Orientation = .vertical

	/**
	 * The optimized content's minimum index.
	 * @property minimum
	 * @since 0.2.0
	 */
	open var minimum: Int {
		return 0
	}

	/**
	 * The optimized content's maximum index.
	 * @property maximum
	 * @since 0.2.0
	 */
	open var maximum: Int {
		return self.length - 1
	}

	/**
	 * The estimated item size.
	 * @property estimatedItemSize
	 * @since 0.7.0
	 */
	private(set) public var estimatedItemSize: Double = 0

	/**
	 * The optimized content's length.
	 * @property length
	 * @since 0.2.0
	 */
	private(set) public var length: Int = 0

	/**
	 * @property head
	 * @since 0.2.0
	 * @hidden
	 */
	private var headIndex: Int = -1

	/**
	 * @property tail
	 * @since 0.2.0
	 * @hidden
	 */
	private var tailIndex: Int = -1

	/**
	 * @property list
	 * @since 0.2.0
	 * @hidden
	 */
	private var list: [JavaScriptView] = []

	/**
	 * @property scrollTop
	 * @since 0.2.0
	 * @hidden
	 */
	private var scrollTop: Double = 0

	/**
	 * @property scrollLeft
	 * @since 0.2.0
	 * @hidden
	 */
	private var scrollLeft: Double = 0

	/**
	 * @property contentOffset
	 * @since 0.2.0
	 * @hidden
	 */
	private var contentOffset: Double = 0

	/**
	 * @property contentLength
	 * @since 0.2.0
	 * @hidden
	 */
	private var contentLength: Double = 0

	/**
	 * @property contentOffsetInvalid
	 * @since 0.7.0
	 * @hidden
	 */
	private var contentOffsetInvalid: Bool = false

	/**
	 * @property contentLengthInvalid
	 * @since 0.7.0
	 * @hidden
	 */
	private var contentLengthInvalid: Bool = false

	/**
	 * @property types
	 * @since 0.7.0
	 * @hidden
	 */
	private var types: [Int: String] = [:]

	/**
	 * @property sizes
	 * @since 0.7.0
	 * @hidden
	 */
	private var sizes: [Int: Double] = [:]

	/**
	 * @property insert
	 * @since 0.7.0
	 * @hidden
	 */
	private var insert: [InsertItemData] = []

	/**
	 * @property remove
	 * @since 0.7.0
	 * @hidden
	 */
	private var remove: [RemoveItemData] = []

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method reload
	 * @since 0.2.0
	 */
	override open func reload() {

		self.clear()

		self.tailIndex = -1
		self.headIndex = -1
		self.scrollTop = 0
		self.scrollLeft = 0
		self.contentOffset = 0
		self.contentLength = 0

		self.view.scrollTop.reset(0)
		self.view.scrollLeft.reset(0)
		self.view.scheduleLayout()
	}

	/**
	 * Updates the list content if needed.
	 * @method updateIfNeeded
	 * @since 0.2.0
	 */
	open func updateIfNeeded() {

		let head = self.headIndex
		let tail = self.tailIndex

		if (head == -1 &&
			tail == -1) {
			return
		}

		if self.hasVisibleItems() == false {

			/*
			 * The scroll changed so much that it went beyond the current
			 * tail and head. We need to estimate a new head index and
			 * start from there.
			 */

			self.items.forEach { index, _ in
				self.removeItem(index)
			}

			var offset = 0.0

			for index in 0 ..< self.length {

				let size = self.getItemSize(index)
				let head = self.getRelativeToStartOffset(offset)
				let tail = self.getRelativeToStartOffset(offset + size)

				if (head < 0 && tail >= 0) {
					self.headIndex = index
					self.tailIndex = index - 1
					break
				}

				offset += size
			}

			self.contentOffset = offset
			self.contentOffsetInvalid = true

			self.insertTailItems()
			return
		}

		guard
			let headOffset = self.getItemOffsetRelativeToScreenHead(head + 1),
			let tailOffset = self.getItemOffsetRelativeToScreenTail(tail - 1) else {
			return
		}

		let removeHead = headOffset.tail < 0
		let removeTail = tailOffset.head > 0
		let insertHead = headOffset.head > 0 && head > self.minimum
		let insertTail = tailOffset.tail < 0 && tail < self.maximum

		if (removeHead || removeTail ||
			insertHead || insertTail) {

			#if DEBUG
			//let t1 = CFAbsoluteTimeGetCurrent()
			#endif

			self.update()

			#if DEBUG
			//let t2 = CFAbsoluteTimeGetCurrent()
			//let tt = (t2 - t1) * 1000
			//print("List optimizer update time \(tt) ms")
			#endif
		}
	}

	/**
	 * Updates the list content based on the scroll position.
	 * @method update
	 * @since 0.2.0
	 */
	open func update() {

		/*
		 * We're managing one more view on both the head and tail of the list
		 * because otherwise the view might be flashing for a brief time while
		 * scrolling really fast.
		 */

		let length = self.length
		if (length == 0) {
			return
		}

		if (self.contentLength == 0) {
			self.contentLength = self.estimatedItemSize * Double(length)
		}

		if (self.headIndex > -1 &&
			self.tailIndex > -1) {
			self.removeHeadItems()
			self.removeTailItems()
			self.insertHeadItems()
			self.insertTailItems()
		}
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method didBeginLayout
	 * @since 0.7.0
	 */
	override open func didBeginLayout(view: JavaScriptView) {

		let length = self.length
		if (length == 0) {

			self.clear()
			self.contentLength = 0
			self.contentOffset = 0
			self.view.contentTop.reset(0)
			self.view.contentLeft.reset(0)
			self.view.contentWidth.reset("auto")
			self.view.contentHeight.reset("auto")

			self.updateContentOffset()
			self.updateContentLength()
			return
		}

		if (self.headIndex == -1 &&
			self.tailIndex == -1) {

			self.headIndex = 0
			self.tailIndex = 0

			self.contentLength = self.estimatedItemSize * Double(length)

			var offset = Offset(
				head: self.getRelativeToEndOffset(0),
				tail: self.getRelativeToEndOffset(0)
			)

			var before = Offset(
				head: offset.head,
				tail: offset.tail
			)

			for i in 0 ..< length {

				self.tailIndex = i

				self.insertTailItem(i)

				guard let item = self.items[i] else {
					break
				}

				switch (self.orientation) {

					case .vertical:
						offset.head = before.tail
						offset.tail = before.tail + item.resolvedHeight

					case .horizontal:
						offset.head = before.tail
						offset.tail = before.tail + item.resolvedWidth
				}

				before.head = offset.head
				before.tail = offset.tail

				if (offset.head > 0 &&
					offset.tail > 0) {
					break
				}
			}
		}

		self.updateContentOffset()
		self.updateContentLength()
	}

	/**
	 * @inherited
	 * @method didFinishLayout
	 * @since 0.7.0
	 */
	override open func didFinishLayout(view: JavaScriptView) {
		self.contentOffsetInvalid = false
		self.contentLengthInvalid = false
	}

	/**
	 * @inherited
	 * @method didScroll
	 * @since 0.7.0
	 */
	override open func didScroll(view: JavaScriptView) {

		let scrollT = self.view.scrollTop.number
		let scrollL = self.view.scrollLeft.number

		if (scrollL < 0 ||
			scrollT < 0 ||
			scrollT > self.view.resolvedContentHeight - self.view.resolvedInnerHeight ||
			scrollL > self.view.resolvedContentWidth - self.view.resolvedInnerWidth) {
			return
		}

		if (scrollT == self.scrollTop &&
			scrollL == self.scrollLeft) {
			return
		}

		self.scrollTop = scrollT
		self.scrollLeft = scrollL

		self.updateIfNeeded()
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method createItem
	 * @since 0.7.0
	 * @hidden
	 */
	private func createItem(_ index: Int) -> JavaScriptView? {

		if (index < self.minimum ||
			index > self.maximum) {
			return nil
		}

		let type = self.context.createReturnValue()
		let view = self.context.createReturnValue()

		self.callMethod("nativeDefineItem", arguments: [self.context.createNumber(index)], result: type)

		if (type.isNull) {
			return nil
		}

		let name = type.property("name").string

		if let reused = self.reuseItem(name) {
			return reused
		}

		type.construct(nil, result: view)

		guard let item = view.property("native").cast(JavaScriptView.self) else {
			return nil
		}

		item.protect()

		self.types[index] = item.className

		return item
	}

	/**
	 * @method reuseItem
	 * @since 0.7.0
	 * @hidden
	 */
	private func cacheItem(_ index: Int) {

		guard let item = self.items[index] else {
			return
		}

		self.cacheItem(item)
	}

	/**
	 * @method reuseItem
	 * @since 0.7.0
	 * @hidden
	 */
	private func reuseItem(_ index: Int) -> JavaScriptView? {

		guard let type = self.types[index] else {
			return nil
		}

		return self.reuseItem(type)
	}

	/**
	 * @method updateContentOffset
	 * @since 0.2.0
	 * @hidden
	 */
	private func updateContentOffset() {
		switch (self.orientation) {
			case .vertical:
				self.view.contentTop.reset(self.contentOffset)
			case .horizontal:
				self.view.contentLeft.reset(self.contentOffset)
		}
	}

	/**
	 * @method updateContentLength
	 * @since 0.2.0
	 * @hidden
	 */
	private func updateContentLength() {
		switch (self.orientation) {
			case .vertical:
				self.view.contentHeight.reset(self.contentLength + self.view.resolvedPaddingTop + self.view.resolvedPaddingBottom)
			case .horizontal:
				self.view.contentWidth.reset(self.contentLength + self.view.resolvedPaddingLeft + self.view.resolvedPaddingRight)
		}
	}

	/**
	 * @method removeHeadItems
	 * @since 0.2.0
	 * @hidden
	 */
	private func removeHeadItems() {

		var head = self.headIndex
		if (head == -1) {
			return
		}

		while (head != -1) {

			let offset = self.getItemOffsetRelativeToScreenHead(head + 1)
			if (offset == nil ||
				offset!.tail > 0) {
				break
			}

			self.removeHeadItem(head)

			head = self.getNextItemIndex(head)
		}

		self.headIndex = head
	}

	/**
	 * @method removeTailItems
	 * @since 0.2.0
	 * @hidden
	 */
	private func removeTailItems() {

		var tail = self.tailIndex
		if (tail == -1) {
			return
		}

		while (tail != -1) {

			let offset = self.getItemOffsetRelativeToScreenTail(tail - 1)
			if (offset == nil ||
				offset!.head < 0) {
				break
			}

			self.removeTailItem(tail)

			tail = self.getPrevItemIndex(tail)
		}

		self.tailIndex = tail
	}

	/**
	 * @method removeHeadItem
	 * @since 0.2.0
	 * @hidden
	 */
	private func removeHeadItem(_ head: Int) {

		guard let item = self.items[head] else {
			return
		}

		self.removeItem(head)

		switch (self.orientation) {
			case .vertical:
				self.contentOffset += item.resolvedHeight
			case .horizontal:
				self.contentOffset += item.resolvedWidth
		}
	}

	/**
	 * @method removeTailItem
	 * @since 0.2.0
	 * @hidden
	 */
	private func removeTailItem(_ tail: Int) {
		self.removeItem(tail)
	}

	/**
	 * @method insertHeadItems
	 * @since 0.2.0
	 * @hidden
	 */
	private func insertHeadItems() {

		var head = self.headIndex
		if (head == -1) {
			return
		}

		var offset = self.getItemOffsetRelativeToScreenHead(head) ?? (
			Offset(
				head: self.getRelativeToEndOffset(self.contentOffset),
				tail: self.getRelativeToEndOffset(self.contentOffset + self.getItemSize(head))
			)
		)

		if (offset.head < 0 &&
			offset.tail < 0) {
			return
		}

		while (true) {

			let prev = self.getPrevItemIndex(head)
			if (prev == -1) {
				break
			}

			head = prev

			self.insertHeadItem(head)

			guard let item = self.items[head] else {
				return
			}

			switch (self.orientation) {

				case .vertical:
					offset.head -= item.resolvedHeight
					offset.tail -= item.resolvedHeight

				case .horizontal:
					offset.head -= item.resolvedWidth
					offset.tail -= item.resolvedWidth
			}

			if (offset.head < 0 &&
				offset.tail < 0) {
				break
			}
		}

		self.headIndex = head
	}

	/**
	 * @method insertTailItems
	 * @since 0.2.0
	 * @hidden
	 */
	private func insertTailItems() {

		var tail = self.tailIndex
		if (tail == -1) {
			return
		}

		var offset = self.getItemOffsetRelativeToScreenTail(tail) ?? (
			Offset(
				head: self.getRelativeToEndOffset(self.contentOffset),
				tail: self.getRelativeToEndOffset(self.contentOffset + self.getItemSize(tail))
			)
		)

		if (offset.head > 0 &&
			offset.tail > 0) {
			return
		}

		while (true) {

			let next = self.getNextItemIndex(tail)
			if (next == -1) {
				break
			}

			tail = next

			self.insertTailItem(tail)

			guard let item = self.items[tail] else {
				break
			}

			switch (self.orientation) {

				case .vertical:
					offset.head += item.resolvedHeight
					offset.tail += item.resolvedHeight

				case .horizontal:
					offset.head += item.resolvedWidth
					offset.tail += item.resolvedWidth
			}

			if (offset.head > 0 &&
				offset.tail > 0) {
				break
			}
		}

		self.tailIndex = tail
	}

	/**
	 * @method insertHeadItem
	 * @since 0.2.0
	 * @hidden
	 */
	private func insertHeadItem(_ head: Int) {

		if (head < self.minimum ||
			head > self.maximum) {
			return
		}

		self.insertItem(head)
		self.expandSize(head)

		guard let item = self.items[head] else {
			return
		}

		switch (self.orientation) {
			case .vertical:
				self.contentOffset -= item.resolvedHeight
			case .horizontal:
				self.contentOffset -= item.resolvedWidth
		}
	}

	/**
	 * @method insertTailItem
	 * @since 0.2.0
	 * @hidden
	 */
	private func insertTailItem(_ tail: Int) {

		if (tail < self.minimum ||
			tail > self.maximum) {
			return
		}

		self.insertItem(tail)
		self.expandSize(tail)
	}

	/**
	 * @method insertItem
	 * @since 0.2.0
	 * @hidden
	 */
	private func insertItem(_ index: Int) {

		if (index < self.minimum ||
			index > self.maximum) {
			return
		}

		var call = false
		var view = self.reuseItem(index)
		if (view == nil) {
			view = self.createItem(index)
			call = true
		}

		guard let item = view else {
			return
		}

		self.items[index] = item

		self.insertView(index, notify: call)

		if (call) {

			/*
			 * This callback is mostly responsible of attaching touch events
			 * and such things. In a managed type of view, its only required
			 * on the first time the view is inserted.
			 */

			self.callMethod("nativeOnInsertItem", arguments: [self.context.createNumber(index), item])
		}

		/*
		 * This callback will force the item to update iself with data thus
		 * possibly invalidating the bounds and content of the item.
		 */

		self.callMethod("nativeOnReuseItem", arguments: [self.context.createNumber(index), item])
	}

	/**
	 * @method removeItem
	 * @since 0.2.0
	 * @hidden
	 */
	private func removeItem(_ index: Int) {

		if (index < self.headIndex &&
			index > self.tailIndex) {
			return
		}

		guard let item = self.items[index] else {
			return
		}

		/*
		 * This callback is responsible of dispatching the onCache event which
		 * the view might use to clear stuff like timers and events. Even though
		 * the view is cached, it still considered as being in the view.
		 */

		self.callMethod("nativeOnCacheItem", arguments: [self.context.createNumber(index), item])

		self.cacheItem(index)
		self.removeView(index, notify: false)

		self.items.removeValue(forKey: index)
	}

	/**
	 * @method insertView
	 * @since 0.7.0
	 * @hidden
	 */
	private func insertView(_ index: Int, notify: Bool) {

		guard let view = self.items[index] else {
			return
		}

		let index = self.getInsertIndex(index)
		self.view.inject(view, at: index, notify: notify)
		self.list.insert(view, at: index)
	}

	/**
	 * @method removeView
	 * @since 0.7.0
	 * @hidden
	 */
	private func removeView(_ index: Int, notify: Bool) {

		guard let view = self.items[index] else {
			return
		}

		self.view.remove(view, notify: notify)
		self.list.remove(view)
	}

	/**
	 * @method expandSize
	 * @since 0.7.0
	 * @hidden
	 */
	private func expandSize(_ index: Int) {

		guard let item = self.items[index] else {
			return
		}

		item.measure()

		let size: Double

		switch (self.orientation) {
			case .vertical:
				size = item.resolvedHeight
			case .horizontal:
				size = item.resolvedWidth
		}

		let current = self.getItemSize(index)
		if (current == size) {
			return
		}

		self.sizes[index] = size

		self.contentLength -= current
		self.contentLength += size
	}

	/**
	 * @method reduceSize
	 * @since 0.7.0
	 * @hidden
	 */
	private func reduceSize(_ index: Int) {

		guard let item = self.items[index] else {
			return
		}

		let size: Double

		switch (self.orientation) {
			case .vertical:
				size = item.resolvedHeight
			case .horizontal:
				size = item.resolvedWidth
		}

		self.contentLength -= size

		self.sizes.removeValue(forKey: index)
	}

	/**
	 * @method insertSpot
	 * @since 0.2.0
	 * @hidden
	 */
	private func insertSpot(_ index: Int) {

		if (index > self.tailIndex) {
			return
		}

		for i in (index ... self.tailIndex).reversed() {
			if (i >= self.headIndex) {
				self.items[i + 1] = self.items[i]
				self.types[i + 1] = self.types[i]
				self.sizes[i + 1] = self.sizes[i]
			}
		}

		self.items.removeValue(forKey: index)
		self.types.removeValue(forKey: index)
		self.sizes.removeValue(forKey: index)
	}

	/**
	 * @method removeSpot
	 * @since 0.2.0
	 * @hidden
	 */
	private func removeSpot(_ index: Int) {

		for i in index ..< self.tailIndex {
			if (index >= self.headIndex) {
				self.items[i] = self.items[i + 1]
				self.types[i] = self.types[i + 1]
				self.sizes[i] = self.sizes[i + 1]
			}
		}

		self.items.removeValue(forKey: self.tailIndex)
		self.types.removeValue(forKey: self.tailIndex)
		self.sizes.removeValue(forKey: self.tailIndex)
	}

	/**
	 * @method clear
	 * @since 0.2.0
	 * @hidden
	 */
	private func clear() {

		self.items.forEach { index, _ in
			self.removeItem(index)
		}

		self.items.removeAll()
		self.types.removeAll()
		self.sizes.removeAll()
	}

	/**
	 * @method getInsertIndex
	 * @since 0.2.0
	 * @hidden
	 */
	private func getInsertIndex(_ index: Int) -> Int {

		if (self.items[index + 1] == nil) { return self.list.count }
		if (self.items[index - 1] == nil) { return 0 }

		let item = self.items[index + 1]
		if (item == nil) {
			return 0
		}

		return self.list.firstIndex(of: item!)!
	}

	/**
	 * @method getNextItemIndex
	 * @since 0.2.0
	 * @hidden
	 */
	private func getNextItemIndex(_ index: Int) -> Int {

		let index = index + 1

		if (index < self.minimum ||
			index > self.maximum) {
			return -1
		}

		return index
	}

	/**
	 * @method getPrevItemIndex
	 * @since 0.2.0
	 * @hidden
	 */
	private func getPrevItemIndex(_ index: Int) -> Int {

		let index = index - 1

		if (index < self.minimum ||
			index > self.maximum) {
			return -1
		}

		return index
	}

	/**
	 * @method getRelativeHeadOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private func getRelativeHeadOffset() -> Offset {
		return self.getItemOffsetRelativeToScreenHead(self.headIndex) ?? .zero
	}

	/**
	 * @method getRelativeTailOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private func getRelativeTailOffset() -> Offset {
		return self.getItemOffsetRelativeToScreenTail(self.tailIndex) ?? .zero
	}

	/**
	 * @method getItemOffsetRelativeToScreenHead
	 * @since 0.7.0
	 * @hidden
	 */
	private func getItemOffsetRelativeToScreenHead(_ index: Int) -> Offset? {

		if (index < self.minimum ||
			index > self.maximum) {
			return nil
		}

		if (index < self.headIndex ||
			index > self.tailIndex) {
			return nil
		}

		guard let item = self.items[index] else {
			return nil
		}

		var offset = 0.0
		var length = 0.0

		switch (self.orientation) {

			case .vertical:
				offset = item.resolvedTop
				length = item.resolvedHeight

			case .horizontal:
				offset = item.resolvedLeft
				length = item.resolvedWidth
		}

		/*
		 * Sometime the item position will be calculated before a layout
		 * occurs. In this case we must manually add the content offset.
		 */

		if (self.contentOffsetInvalid) {

			let current: Double

			switch (self.orientation) {
				case .vertical:
					current = self.view.contentTop.number
				case .horizontal:
					current = self.view.contentLeft.number
			}

			offset += (self.contentOffset - current)
		}

		return Offset(
			head: self.getRelativeToStartOffset(offset),
			tail: self.getRelativeToStartOffset(offset + length)
		)
	}

	/**
	 * @method getItemOffsetRelativeToScreenTail
	 * @since 0.2.0
	 * @hidden
	 */
	private func getItemOffsetRelativeToScreenTail(_ index: Int) -> Offset? {

		if (index < self.minimum ||
			index > self.maximum) {
			return nil
		}

		if (index < self.headIndex ||
			index > self.tailIndex) {
			return nil
		}

		guard let item = self.items[index] else {
			return nil
		}

		var offset = 0.0
		var length = 0.0

		switch (self.orientation) {

			case .vertical:
				offset = item.resolvedTop
				length = item.resolvedHeight

			case .horizontal:
				offset = item.resolvedLeft
				length = item.resolvedWidth
		}

		/*
		 * Sometime the item position will be calculated before a layout
		 * occurs. In this case we must manually add the content offset.
		 */

		if (self.contentOffsetInvalid) {

			let current: Double

			switch (self.orientation) {
				case .vertical:
					current = self.view.contentTop.number
				case .horizontal:
					current = self.view.contentLeft.number
			}

			offset += (self.contentOffset - current)
		}

		return Offset(
			head: self.getRelativeToEndOffset(offset),
			tail: self.getRelativeToEndOffset(offset + length)
		)
	}

	/**
	 * @method getRelativeToStartOffset
	 * @since 0.2.0
	 * @hidden
	 */
	private func getRelativeToStartOffset(_ offset: Double) -> Double {
		switch (self.orientation) {
			case .vertical:
				return offset - self.scrollTop
			case .horizontal:
				return offset - self.scrollLeft
		}
	}

	/**
	 * @method getRelativeToEndOffset
	 * @since 0.2.0
	 * @hidden
	 */
	private func getRelativeToEndOffset(_ offset: Double) -> Double {
		switch (self.orientation) {
			case .vertical:
				return offset - self.scrollTop - self.view.resolvedInnerHeight
			case .horizontal:
				return offset - self.scrollLeft - self.view.resolvedInnerWidth
		}
	}

	/**
	 * @method getItemSize
	 * @since 0.7.0
	 * @hidden
	 */
	private func getItemSize(_ index: Int) -> Double {
		return self.sizes[index] ?? self.estimatedItemSize
	}

	/**
	 * @method hasVisibleItems
	 * @since 0.7.0
	 * @hidden
	 */
	private func hasVisibleItems() -> Bool {

		guard
			let headOffset = self.getItemOffsetRelativeToScreenHead(self.headIndex),
			let tailOffset = self.getItemOffsetRelativeToScreenHead(self.tailIndex) else {
			return false
		}

		return (headOffset.tail < 0 && tailOffset.tail < 0) == false
	}

	/**
	 * @method isFilled
	 * @since 0.7.0
	 * @hidden
	 */
	private func isFilled() -> Bool {

		if (self.headIndex == -1 &&
			self.tailIndex == -1) {
			return false
		}

		let offset = self.getItemOffsetRelativeToScreenTail(self.tailIndex)
		if (offset == nil ||
			offset!.head > 0) {
			return true
		}

		return false
	}

	//--------------------------------------------------------------------------
	// MARK: JavaScript Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_length
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsGet_length(callback: JavaScriptGetterCallback) {
		callback.returns(Double(self.length))
	}

	/**
	 * @method jsSet_length
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsSet_length(callback: JavaScriptSetterCallback) {
		self.length = callback.value.number.toInt()
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_orientation
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsGet_orientation(callback: JavaScriptGetterCallback) {
		callback.returns(Double(self.orientation.rawValue))
	}

	/**
	 * @method jsSet_orientation
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsSet_orientation(callback: JavaScriptSetterCallback) {
		self.orientation = Orientation.get(value: callback.value.number)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_estimatedItemSize
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_estimatedItemSize(callback: JavaScriptGetterCallback) {
		callback.returns(self.estimatedItemSize)
	}

	/**
	 * @method jsSet_estimatedItemSize
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_estimatedItemSize(callback: JavaScriptSetterCallback) {
		self.estimatedItemSize = callback.value.number
	}

	//--------------------------------------------------------------------------
	// MARK: JavaScript Function
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_reloadData
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsFunction_reloadData(callback: JavaScriptFunctionCallback) {
		self.reload()
	}

	/**
	 * @method jsFunction_insertData
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsFunction_insertData(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 3) {
			fatalError("Method JavaScriptListOptimizer.insertData() requires 3 arguments.")
		}

		let index   = callback.argument(0).number.toInt()
		let count   = callback.argument(1).number.toInt()
		let animate = callback.argument(2).boolean

		let min = index
		let max = index + count - 1

		for index in min ... max {

			if (self.headIndex == -1 &&
				self.tailIndex == -1) {

				/*
				 * Data is inserted in an empty list. Add items, set the new
				 * head and tail based on the amount of inserted items and
				 * adjust the content size
				 */

				self.headIndex = 0
				self.tailIndex = 0

				/*
				 * The expand size method add size difference between the
				 * item estimated size and its measured size. Since this is
				 * a new item we must manually add the estimated item size
				 * to the content size.
				 */

				switch (self.orientation) {
					case .vertical:
						self.contentLength += self.estimatedItemSize
					case .horizontal:
						self.contentLength += self.estimatedItemSize
				}

				self.insertItem(index)
				self.expandSize(index)

				if (animate) {
					self.insert.append(InsertItemData(view: self.items[index]!, index: index))
				}

			} else {

				let filled = self.isFilled()

				/*
				 * Data is inserted between the range of visible items. A new
				 * item must be created and inserted. The head index always
				 * remains the same but the tail needs to be incremented.
				 */

				if (index >= self.headIndex &&
					index <= self.tailIndex ||
					filled == false) {

					/*
					 * The expand size method add size difference between the
					 * item estimated size and its measured size. Since this is
					 * a new item we must manually add the estimated item size
					 * to the content size.
					 */

					switch (self.orientation) {
						case .vertical:
							self.contentLength += self.estimatedItemSize
						case .horizontal:
							self.contentLength += self.estimatedItemSize
					}

					if (index < self.tailIndex || filled == false) {

						self.insertSpot(index)
						self.insertItem(index)
						self.expandSize(index)

						self.tailIndex += 1

						if (animate) {
							self.insert.append(InsertItemData(view: self.items[index]!, index: index))
						}
					}

				} else if (index < self.headIndex) {

					/*
					 * Data has been inserted before the head index which means
					 * that the data being currently after that displayed is one
					 * index off. This is fixed by incrementing the head and tail
					 * index.
					 */

					self.headIndex += 1
					self.tailIndex += 1
					self.insertSpot(index)

					self.contentLength += self.getItemSize(index)

				} else if (index > self.tailIndex) {

					/*
					 * Data has been inserted after the tail index which means that
					 * it has no effect beside incrementing the content length.
					 */

					self.contentLength += self.getItemSize(index)
				}
			}
		}

		self.updateContentLength()
		self.updateContentOffset()
	}

	/**
	 * @method jsFunction_removeData
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsFunction_removeData(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 3) {
			fatalError("Method JavaScriptListOptimizer.removeData() requires 3 arguments.")
		}

		let index   = callback.argument(0).number.toInt()
		let count   = callback.argument(1).number.toInt()
		let animate = callback.argument(2).boolean

		let min = index
		let max = index + count - 1

		for i in min ... max {

			if (index >= self.headIndex &&
				index <= self.tailIndex) {

				if (animate) {
					self.remove.append(RemoveItemData(view: self.items[index]!, index: i))
				}

				/*
				 * Data is removed between the range of visible items. The item
				 * must be removed. The head index always remains the same but the
				 * tail needs to be decremented
				 */

				self.reduceSize(index)
				self.removeItem(index)
				self.removeSpot(index)

				self.tailIndex -= 1

			} else if (index < self.headIndex) {

				/*
				 * Data has been removed before the head index which means that
				 * the data being currently after that displayed is one index off.
				 * This is fixed by decrementing the head and tail index.
				 */

				self.headIndex -= 1
				self.tailIndex -= 1
				self.removeSpot(index)

				self.contentLength -= self.getItemSize(index)

			} else if (index > self.tailIndex) {

				/*
				 * Data has been removed after the tail index which means that it
				 * has no effect beside decrementing the content length.
				 */

				self.contentLength -= self.getItemSize(index)

			}
		}

		if (self.items.count == 0) {
			self.headIndex = -1
			self.tailIndex = -1
			self.contentOffset = 0
		}

		self.updateContentLength()
		self.updateContentOffset()
	}

	/**
	 * @method jsFunction_performTransition
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_performTransition(callback: JavaScriptFunctionCallback) {

		if (self.insert.count == 0 &&
			self.remove.count == 0) {
			return
		}

		self.view.resolve()

		let complete = self.context.createFunction { arguments in

			for item in self.remove {
				self.view.remove(item.view, notify: false)
			}

			self.insert.removeAll()
			self.remove.removeAll()
			self.updateIfNeeded()
		}

		let insert = self.insert.sorted(by: { $0.index < $1.index })
		let remove = self.remove.sorted(by: { $0.index < $1.index })
		let inserts = self.context.createEmptyArray()
		let removes = self.context.createEmptyArray()

		for (index, data) in insert.enumerated() {
			inserts.property(index, value: data.view)
		}

		for (index, data) in remove.enumerated() {
			removes.property(index, value: data.view)
		}

		for data in remove {
			self.view.insert(data.view, at: data.index)
		}

		callback.argument(0).call([inserts, removes, complete], target: nil)
	}

	//--------------------------------------------------------------------------
	// MARK: Classes
	//--------------------------------------------------------------------------

	/**
	 * @struct Orientation
	 * @since 0.2.0
	 * @hidden
	 */
	public enum Orientation: Int {

		case vertical = 1
		case horizontal = 2

		/**
		 * Parses the orientation type from a number.
		 * @method get
		 * @since 0.2.0
		 */
		public static func get(value: Double) -> Orientation {

			switch (value) {

				case 1:
					return .vertical
				case 2:
					return .horizontal

				default:
					return .vertical
			}
		}
	}

	/**
	* @struct Offset
	* @since 0.2.0
	* @hidden
	*/
	private struct Offset {

		/**
		 * @property zero
		 * @since 0.7.0
		 * @hidden
		 */
		public static let zero = Offset(head: 0, tail: 0)

		/**
		 * @property head
		 * @since 0.7.0
		 * @hidden
		 */
		public var head: Double = 0

		/**
		 * @property tail
		 * @since 0.7.0
		 * @hidden
		 */
		public var tail: Double = 0

		/**
		 * @constructor
		 * @since 0.7.0
		 * @hidden
		 */
		init(head: Double, tail: Double) {
			self.head = head
			self.tail = tail
		}
	}

	/**
	* @struct InsertItemData
	* @since 0.7.0
	* @hidden
	*/
	private struct InsertItemData {

		/**
		 * @property view
		 * @since 0.7.0
		 * @hidden
		 */
		public let view: JavaScriptView

		/**
		 * @property index
		 * @since 0.7.0
		 * @hidden
		 */
		public let index: Int

		/**
		 * @constructor
		 * @since 0.7.0
		 * @hidden
		 */
		public init(view: JavaScriptView, index: Int) {
			self.view = view
			self.index = index
		}
	}

	/**
	* @struct RemoveItemData
	* @since 0.7.0
	* @hidden
	*/
	private struct RemoveItemData {

		/**
		 * @property view
		 * @since 0.7.0
		 * @hidden
		 */
		public let view: JavaScriptView

		/**
		 * @property index
		 * @since 0.7.0
		 * @hidden
		 */
		public let index: Int

		/**
		 * @constructor
		 * @since 0.7.0
		 * @hidden
		 */
		public init(view: JavaScriptView, index: Int) {
			self.view = view
			self.index = index
		}
	}
}
