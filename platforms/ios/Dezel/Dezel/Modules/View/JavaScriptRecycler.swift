/**
 * @class JavaScriptRecycler
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptRecycler : JavaScriptClass, JavaScriptView.Delegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.7.0
	 */
	private(set) public weak var view: JavaScriptView!

	/**
	 * @property list
	 * @since 0.7.0
	 * @hidden
	 */
	private var list: [JavaScriptView] = []

	/**
	 * @property length
	 * @since 0.7.0
	 * @hidden
	 */
	private var size: Int = 0

	/**
	 * @property views
	 * @since 0.7.0
	 * @hidden
	 */
	private var views: [Int: JavaScriptView] = [:]

	/**
	 * @property cache
	 * @since 0.7.0
	 * @hidden
	 */
	private var cache: [String: [JavaScriptView]] = [:]

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
	 * @property estimatedItemSize
	 * @since 0.7.0
	 * @hidden
	 */
	private var estimatedItemSize: Double = 0

	/**
	 * @property direction
	 * @since 0.7.0
	 * @hidden
	 */
	private var direction: Direction = .vertical

	/**
	 * @property headIndex
	 * @since 0.7.0
	 * @hidden
	 */
	private var headIndex: Int = -1

	/**
	 * @property tailIndex
	 * @since 0.7.0
	 * @hidden
	 */
	private var tailIndex: Int = -1

	/**
	 * @property scrollTop
	 * @since 0.7.0
	 * @hidden
	 */
	private var scrollTop: Double = 0

	/**
	 * @property scrollLeft
	 * @since 0.7.0
	 * @hidden
	 */
	private var scrollLeft: Double = 0

	/**
	 * @property contentOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private var contentOffset: Double = 0

	/**
	 * @property contentLength
	 * @since 0.7.0
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
	 * @property insert
	 * @since 0.7.0
	 * @hidden
	 */
	private var insert: [InsertViewData] = []

	/**
	 * @property remove
	 * @since 0.7.0
	 * @hidden
	 */
	private var remove: [RemoveViewData] = []

	/**
	 * @property minimum
	 * @since 0.7.0
	 * @hidden
	 */
	private var minimum: Int {
		return 0
	}

	/**
	 * @property maximum
	 * @since 0.7.0
	 * @hidden
	 */
	private var maximum: Int {
		return self.size - 1
	}

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
		self.view?.scheduleLayout()
	}

	/**
	 * @method detach
	 * @since 0.7.0
	 */
	open func detach() {

		self.view?.delegate = nil
		self.view?.scheduleLayout()
		self.view = nil

		self.cache.values.forEach {
			$0.forEach {
				$0.unprotect()
				$0.dispose()
			}
		}

		self.views.removeAll()
		self.cache.removeAll()
	}

	//--------------------------------------------------------------------------
	// MARK: View Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method didPrepareLayout
	 * @since 0.7.0
	 */
	open func didPrepareLayout(view: JavaScriptView) {

		switch (view.contentDirection.string) {

			case "horizontal":
				self.direction = .horizontal
			case "vertical":
				self.direction = .vertical

			default:
				self.direction = .vertical
		}

		let size = self.size
		if (size == 0) {

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

			self.contentLength = self.estimatedItemSize * Double(size)

			var offset = Offset(
				head: self.getRelativeToEndOffset(0),
				tail: self.getRelativeToEndOffset(0)
			)

			var before = Offset(
				head: offset.head,
				tail: offset.tail
			)

			for i in 0 ..< size {

				self.tailIndex = i

				self.insertTailView(i)

				guard let item = self.views[i] else {
					break
				}

				switch (self.direction) {

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
	 * @method didResolveLayout
	 * @since 0.7.0
	 */
	open func didResolveLayout(view: JavaScriptView) {
		self.contentOffsetInvalid = false
		self.contentLengthInvalid = false
	}

	/**
	 * @method didScroll
	 * @since 0.7.0
	 */
	open func didScroll(view: JavaScriptView) {

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
	 * @method reload
	 * @since 0.7.0
	 * @hidden
	 */
	private func reload() {

		self.clear()

		self.views = [:]

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
	 * @method updateIfNeeded
	 * @since 0.7.0
	 * @hidden
	 */
	private func updateIfNeeded() {

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

			self.views.forEach { index, _ in
				self.removeView(index)
			}

			var offset = 0.0

			for index in 0 ..< self.size {

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

			self.insertTailViews()
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
			self.update()
		}
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update() {

		/*
		 * We're managing one more view on both the head and tail of the list
		 * because otherwise the view might be flashing for a brief time while
		 * scrolling really fast.
		 */

		let length = self.size
		if (length == 0) {
			return
		}

		if (self.contentLength == 0) {
			self.contentLength = self.estimatedItemSize * Double(length)
		}

		if (self.headIndex > -1 &&
			self.tailIndex > -1) {
			self.removeHeadViews()
			self.removeTailViews()
			self.insertHeadViews()
			self.insertTailViews()
		}
	}

	/**
	 * @method createView
	 * @since 0.7.0
	 * @hidden
	 */
	private func createView(_ index: Int) -> JavaScriptView? {

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

		if let reused = self.reuseView(name) {
			return reused
		}

		type.construct(nil, result: view)

		guard let item = view.property("native").cast(JavaScriptView.self) else {
			return nil
		}

		item.protect()

		self.types[index] = item.className.string

		return item
	}


	/**
	 * @method cacheView
	 * @since 0.7.0
	 * @hidden
	 */
	private func cacheView(_ item: JavaScriptView) {

		let type = item.className.string

		if (self.cache[type] == nil) {
			self.cache[type] = []
		}

		self.cache[type]?.append(item)
	}

	/**
	 * @method reuseView
	 * @since 0.7.0
	 * @hidden
	 */
	private func reuseView(_ index: Int) -> JavaScriptView? {

		guard let type = self.types[index] else {
			return nil
		}

		return self.reuseView(type)
	}

	/**
	 * @method reuseView
	 * @since 0.7.0
	 * @hidden
	 */
	private func reuseView(_ type: String) -> JavaScriptView? {

		guard var cache = self.cache[type] else {
			return nil
		}

		guard let item = cache.pop() else {
			return nil
		}

		self.cache[type] = cache

		return item
	}

	/**
	 * @method updateContentOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private func updateContentOffset() {
		switch (self.direction) {
			case .vertical:
				self.view.contentTop.reset(self.contentOffset)
			case .horizontal:
				self.view.contentLeft.reset(self.contentOffset)
		}
	}

	/**
	 * @method updateContentLength
	 * @since 0.7.0
	 * @hidden
	 */
	private func updateContentLength() {
		switch (self.direction) {
			case .vertical:
				self.view.contentHeight.reset(self.contentLength + self.view.resolvedPaddingTop + self.view.resolvedPaddingBottom)
			case .horizontal:
				self.view.contentWidth.reset(self.contentLength + self.view.resolvedPaddingLeft + self.view.resolvedPaddingRight)
		}
	}

	/**
	 * @method removeHeadViews
	 * @since 0.7.0
	 * @hidden
	 */
	private func removeHeadViews() {

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

			self.removeHeadView(head)

			head = self.getNextItemIndex(head)
		}

		self.headIndex = head
	}

	/**
	 * @method removeHeadViews
	 * @since 0.7.0
	 * @hidden
	 */
	private func removeTailViews() {

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

			self.removeTailView(tail)

			tail = self.getPrevItemIndex(tail)
		}

		self.tailIndex = tail
	}

	/**
	 * @method removeHeadView
	 * @since 0.7.0
	 * @hidden
	 */
	private func removeHeadView(_ head: Int) {

		guard let item = self.views[head] else {
			return
		}

		self.removeView(head)

		switch (self.direction) {
			case .vertical:
				self.contentOffset += item.resolvedHeight
			case .horizontal:
				self.contentOffset += item.resolvedWidth
		}
	}

	/**
	 * @method removeHeadView
	 * @since 0.7.0
	 * @hidden
	 */
	private func removeTailView(_ tail: Int) {
		self.removeView(tail)
	}

	/**
	 * @method insertHeadViews
	 * @since 0.7.0
	 * @hidden
	 */
	private func insertHeadViews() {

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

			self.insertHeadView(head)

			guard let item = self.views[head] else {
				return
			}

			switch (self.direction) {

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
	 * @method insertTailViews
	 * @since 0.7.0
	 * @hidden
	 */
	private func insertTailViews() {

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

			self.insertTailView(tail)

			guard let item = self.views[tail] else {
				break
			}

			switch (self.direction) {

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
	 * @method insertHeadView
	 * @since 0.7.0
	 * @hidden
	 */
	private func insertHeadView(_ head: Int) {

		if (head < self.minimum ||
			head > self.maximum) {
			return
		}

		self.insertView(head)
		self.increaseSize(head)

		guard let item = self.views[head] else {
			return
		}

		switch (self.direction) {
			case .vertical:
				self.contentOffset -= item.resolvedHeight
			case .horizontal:
				self.contentOffset -= item.resolvedWidth
		}
	}

	/**
	 * @method insertTailView
	 * @since 0.7.0
	 * @hidden
	 */
	private func insertTailView(_ tail: Int) {

		if (tail < self.minimum ||
			tail > self.maximum) {
			return
		}

		self.insertView(tail)
		self.increaseSize(tail)
	}

	/**
	 * @method insertView
	 * @since 0.7.0
	 * @hidden
	 */
	private func insertView(_ index: Int) {

		if (index < self.minimum ||
			index > self.maximum) {
			return
		}

		var child = self.reuseView(index)
		if (child == nil) {
			child = self.createView(index)
		}

		guard let view = child else {
			return
		}

		self.views[index] = view

		let at = self.getInsertIndex(index)
		self.view.inject(view, at: at, notify: false)
		self.list.insert(view, at: at)

		/*
		 * Tells the managed view an item has been inserted so it is properly
		 * managed by the view and prepared for reuse.
		 */

		self.callMethod("nativeOnInsertView", arguments: [self.context.createNumber(index), view])
	}

	/**
	 * @method removeItem
	 * @since 0.7.0
	 * @hidden
	 */
	private func removeView(_ index: Int) {

		if (index < self.headIndex &&
			index > self.tailIndex) {
			return
		}

		guard let view = self.views[index] else {
			return
		}

		self.cacheView(view)

		self.view.remove(view, notify: false)
		self.list.remove(view)

		self.views.removeValue(forKey: index)

		/*
		 * Tells the managed view an item has been remove so it is properly
		 * managed by the view and prepared for cache.
		 */

		self.callMethod("nativeOnRemoveView", arguments: [self.context.createNumber(index), view])
	}

	/**
	 * @method increaseSize
	 * @since 0.7.0
	 * @hidden
	 */
	private func increaseSize(_ index: Int) {

		guard let item = self.views[index] else {
			return
		}

		item.measure()

		let size: Double

		switch (self.direction) {
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
	 * @method decreaseSize
	 * @since 0.7.0
	 * @hidden
	 */
	private func decreaseSize(_ index: Int) {

		guard let item = self.views[index] else {
			return
		}

		let size: Double

		switch (self.direction) {
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
	 * @since 0.7.0
	 * @hidden
	 */
	private func insertSpot(_ index: Int) {

		/*
		 * TOO Explain
		 */

		if (index > self.tailIndex) {
			return
		}

		for i in (index ... self.tailIndex).reversed() {
			if (i >= self.headIndex) {
				self.views[i + 1] = self.views[i]
				self.types[i + 1] = self.types[i]
				self.sizes[i + 1] = self.sizes[i]
			}
		}

		self.views.removeValue(forKey: index)
		self.types.removeValue(forKey: index)
		self.sizes.removeValue(forKey: index)
	}

	/**
	 * @method removeSpot
	 * @since 0.7.0
	 * @hidden
	 */
	private func removeSpot(_ index: Int) {

		/*
		 * TOO Explain
		 */

		for i in index ..< self.tailIndex {
			if (index >= self.headIndex) {
				self.views[i] = self.views[i + 1]
				self.types[i] = self.types[i + 1]
				self.sizes[i] = self.sizes[i + 1]
			}
		}

		self.views.removeValue(forKey: self.tailIndex)
		self.types.removeValue(forKey: self.tailIndex)
		self.sizes.removeValue(forKey: self.tailIndex)
	}

	/**
	 * @method clear
	 * @since 0.7.0
	 * @hidden
	 */
	private func clear() {

		self.views.forEach { index, _ in
			self.removeView(index)
		}

		self.views.removeAll()
		self.types.removeAll()
		self.sizes.removeAll()
	}

	/**
	 * @method getInsertIndex
	 * @since 0.7.0
	 * @hidden
	 */
	private func getInsertIndex(_ index: Int) -> Int {

		if (self.views[index + 1] == nil) { return self.list.count }
		if (self.views[index - 1] == nil) { return 0 }

		let item = self.views[index + 1]
		if (item == nil) {
			return 0
		}

		return self.list.firstIndex(of: item!)!
	}

	/**
	 * @method getNextItemIndex
	 * @since 0.7.0
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
	 * @since 0.7.0
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

		guard let item = self.views[index] else {
			return nil
		}

		var offset = 0.0
		var length = 0.0

		switch (self.direction) {

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

			switch (self.direction) {
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
	 * @since 0.7.0
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

		guard let item = self.views[index] else {
			return nil
		}

		var offset = 0.0
		var length = 0.0

		switch (self.direction) {

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

			switch (self.direction) {
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
	 * @since 0.7.0
	 * @hidden
	 */
	private func getRelativeToStartOffset(_ offset: Double) -> Double {
		switch (self.direction) {
			case .vertical:
				return offset - self.scrollTop
			case .horizontal:
				return offset - self.scrollLeft
		}
	}

	/**
	 * @method getRelativeToEndOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private func getRelativeToEndOffset(_ offset: Double) -> Double {
		switch (self.direction) {
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

	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_reloadData
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_reloadData(callback: JavaScriptFunctionCallback) {
		self.reload()
	}

	/**
	 * @method jsFunction_insertData
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_insertData(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 3) {
			fatalError("Method Recycler.insertData() requires 3 arguments.")
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

				self.contentLength += self.estimatedItemSize

				self.insertView(index)
				self.increaseSize(index)

				if (animate) {
					self.insert.append(InsertViewData(view: self.views[index]!, index: index))
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

					self.contentLength += self.estimatedItemSize

					if (index < self.tailIndex || filled == false) {

						self.insertSpot(index)
						self.insertView(index)
						self.increaseSize(index)

						self.tailIndex += 1

						if (animate) {
							self.insert.append(InsertViewData(view: self.views[index]!, index: index))
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
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_removeData(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 3) {
			fatalError("Method Recycler.removeData() requires 3 arguments.")
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
					self.remove.append(RemoveViewData(view: self.views[index]!, index: i))
				}

				/*
				 * Data is removed between the range of visible items. The item
				 * must be removed. The head index always remains the same but the
				 * tail needs to be decremented
				 */

				self.decreaseSize(index)
				self.removeView(index)
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

		if (self.views.count == 0) {
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

	private enum Direction {
		case vertical
		case horizontal
	}

	/**
	 * @struct Offset
	 * @since 0.7.0
	 * @hidden
	 */
	private struct Offset {

		/**
		 * @property zero
		 * @since 0.7.0
		 */
		public static let zero = Offset(head: 0, tail: 0)

		/**
		 * @property head
		 * @since 0.7.0
		 */
		public var head: Double = 0

		/**
		 * @property tail
		 * @since 0.7.0
		 */
		public var tail: Double = 0

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		init(head: Double, tail: Double) {
			self.head = head
			self.tail = tail
		}
	}

	/**
	 * @struct InsertViewData
	 * @since 0.7.0
	 * @hidden
	 */
	private struct InsertViewData {

		/**
		 * @property view
		 * @since 0.7.0
		 */
		public let view: JavaScriptView

		/**
		 * @property index
		 * @since 0.7.0
		 */
		public let index: Int

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		public init(view: JavaScriptView, index: Int) {
			self.view = view
			self.index = index
		}
	}

	/**
	 * @struct RemoveViewData
	 * @since 0.7.0
	 * @hidden
	 */
	private struct RemoveViewData {

		/**
		 * @property view
		 * @since 0.7.0
		 */
		public let view: JavaScriptView

		/**
		 * @property index
		 * @since 0.7.0
		 */
		public let index: Int

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		public init(view: JavaScriptView, index: Int) {
			self.view = view
			self.index = index
		}
	}
}
