package ca.logaritm.dezel.modules.view.optimize

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.core.JavaScriptGetterCallback
import ca.logaritm.dezel.core.JavaScriptSetterCallback
import ca.logaritm.dezel.extension.fatalError
import ca.logaritm.dezel.extension.type.insert
import ca.logaritm.dezel.modules.view.JavaScriptView

/**
 * Optimizes contents displayed as a list.
 * @class JavaScriptListOptimizer
 * @super JavaScriptViewOptimizer
 * @since 0.7.0
 */
open class JavaScriptListOptimizer(context: JavaScriptContext) : JavaScriptViewOptimizer(context) {

	//--------------------------------------------------------------------------
	//  Properties
	//--------------------------------------------------------------------------

	/**
	 * The optimized content's orientation.
	 * @property orientation
	 * @since 0.2.0
	 */
	open var orientation: Orientation = Orientation.VERTICAL

	/**
	 * The optimized content's minimum index.
	 * @property minimum
	 * @since 0.2.0
	 */
	open val minimum: Int
		get() = 0

	/**
	 * The optimized content's maximum index.
	 * @property maximum
	 * @since 0.2.0
	 */
	open val maximum: Int
		get() = this.length - 1

	/**
	 * The estimated item size.
	 * @property estimatedItemSize
	 * @since 0.7.0
	 */
	public var estimatedItemSize: Double = 0.0
		private set

	/**
	 * The optimized content's length.
	 * @property length
	 * @since 0.2.0
	 */
	public var length: Int = 0
		private set

	/**
	 * @property headIndex
	 * @since 0.2.0
	 * @hidden
	 */
	private var headIndex: Int = -1

	/**
	 * @property tailIndex
	 * @since 0.2.0
	 * @hidden
	 */
	private var tailIndex: Int = -1

	/**
	 * @property list
	 * @since 0.2.0
	 * @hidden
	 */
	private var list: MutableList<JavaScriptView> = mutableListOf()

	/**
	 * @property scrollTop
	 * @since 0.2.0
	 * @hidden
	 */
	private var scrollTop: Double = 0.0

	/**
	 * @property scrollLeft
	 * @since 0.2.0
	 * @hidden
	 */
	private var scrollLeft: Double = 0.0

	/**
	 * @property contentOffset
	 * @since 0.2.0
	 * @hidden
	 */
	private var contentOffset: Double = 0.0

	/**
	 * @property contentLength
	 * @since 0.2.0
	 * @hidden
	 */
	private var contentLength: Double = 0.0

	/**
	 * @property contentOffsetInvalid
	 * @since 0.7.0
	 * @hidden
	 */
	private var contentOffsetInvalid: Boolean = false

	/**
	 * @property contentLengthInvalid
	 * @since 0.7.0
	 * @hidden
	 */
	private var contentLengthInvalid: Boolean = false
	/**
	 * @property types
	 * @since 0.7.0
	 * @hidden
	 */
	private var types: MutableMap<Int, String> = mutableMapOf()

	/**
	 * @property sizes
	 * @since 0.7.0
	 * @hidden
	 */
	private var sizes: MutableMap<Int, Double> = mutableMapOf()

	/**
	 * @property insert
	 * @since 0.7.0
	 * @hidden
	 */
	private var insert: MutableList<InsertItemData> = mutableListOf()

	/**
	 * @property remove
	 * @since 0.7.0
	 * @hidden
	 */
	private var remove: MutableList<RemoveItemData> = mutableListOf()

	//--------------------------------------------------------------------------
	//  Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method reload
	 * @since 0.2.0
	 */
	override fun reload() {

		this.clear()

		this.tailIndex = -1
		this.headIndex = -1
		this.scrollTop = 0.0
		this.scrollLeft = 0.0
		this.contentOffset = 0.0
		this.contentLength = 0.0

		this.view.scrollTop.reset(0.0)
		this.view.scrollLeft.reset(0.0)
		this.view.scheduleLayout()
	}

	/**
	 * Updates the list content if needed.
	 * @method updateIfNeeded
	 * @since 0.2.0
	 */
	open fun updateIfNeeded() {

		val head = this.headIndex
		val tail = this.tailIndex

		if (head == -1 &&
			tail == -1) {
			return
		}

		if (this.hasVisibleItems() == false) {

			/*
			 * The scroll changed so much that it went beyond the current
			 * tail and head. We need to estimate a new head index and
			 * start from there.
			 */

			this.items.toMutableMap().forEach { (index, _) ->
				this.removeItem(index)
			}

			var offset = 0.0

			for (index in 0 until this.length) {

				val size = this.getItemSize(index)
				val head = this.getRelativeToStartOffset(offset)
				val tail = this.getRelativeToStartOffset(offset + size)

				if (head < 0 && tail >= 0) {
					this.headIndex = index
					this.tailIndex = index - 1
					break
				}

				offset += size
			}

			this.contentOffset = offset
			this.contentOffsetInvalid = true

			this.insertTailItems()
			return
		}

		val headOffset = this.getItemOffsetRelativeToScreenHead(head + 1)
		val tailOffset = this.getItemOffsetRelativeToScreenTail(tail - 1)

		if (headOffset == null ||
			tailOffset == null) {
			return
		}

		val removeHead = headOffset.tail < 0
		val removeTail = tailOffset.head > 0
		val insertHead = headOffset.head > 0 && head > this.minimum
		val insertTail = tailOffset.tail < 0 && tail < this.maximum

		if (removeHead || removeTail ||
			insertHead || insertTail) {
			this.update()
		}
	}

	/**
	 * Updates the list content based on the scroll position.
	 * @method update
	 * @since 0.2.0
	 */
	open fun update() {

		/*
		 * We're managing one more view on both the head and tail of the list
		 * because otherwise the view might be flashing for a brief time while
		 * scrolling really fast.
		 */

		val length = this.length
		if (length == 0) {
			return
		}

		if (this.contentLength == 0.0) {
			this.contentLength = this.estimatedItemSize * length.toDouble()
		}

		if (this.headIndex > -1 &&
			this.tailIndex > -1) {
			this.removeHeadItems()
			this.removeTailItems()
			this.insertHeadItems()
			this.insertTailItems()
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
	override fun onBeginLayout(view: JavaScriptView) {

		val length = this.length
		if (length == 0) {

			this.clear()
			this.contentLength = 0.0
			this.contentOffset = 0.0
			this.view.contentTop.reset(0.0)
			this.view.contentLeft.reset(0.0)
			this.view.contentWidth.reset("auto")
			this.view.contentHeight.reset("auto")

			this.updateContentOffset()
			this.updateContentLength()
			return
		}

		if (this.headIndex == -1 &&
			this.tailIndex == -1) {

			this.headIndex = 0
			this.tailIndex = 0

			this.contentLength = this.estimatedItemSize * length.toDouble()

			var offset = Offset(
				this.getRelativeToEndOffset(0.0),
			 	this.getRelativeToEndOffset(0.0)
			)

			var before = Offset(
				offset.head,
			 	offset.tail
			)

			for (i in 0 until length) {

				this.tailIndex = i

				this.insertTailItem(i)

				val item = this.items[i]
				if (item == null) {
					break
				}

				when (this.orientation) {

					Orientation.VERTICAL   -> {
						offset.head = before.tail
						offset.tail = before.tail + item.resolvedHeight
					}

					Orientation.HORIZONTAL -> {
						offset.head = before.tail
						offset.tail = before.tail + item.resolvedWidth
					}
				}

				before.head = offset.head
				before.tail = offset.tail

				if (offset.head > 0 &&
					offset.tail > 0) {
					break
				}
			}
		}

		this.updateContentOffset()
		this.updateContentLength()
	}

	/**
	 * @inherited
	 * @method didFinishLayout
	 * @since 0.7.0
	 */
	override fun onFinishLayout(view: JavaScriptView) {
		this.contentOffsetInvalid = false
		this.contentLengthInvalid = false
	}

	/**
	 * @inherited
	 * @method didScroll
	 * @since 0.7.0
	 */
	override fun onScroll(view: JavaScriptView) {

		val scrollT = this.view.scrollTop.number
		val scrollL = this.view.scrollLeft.number

		if (scrollL < 0 ||
			scrollT < 0 ||
			scrollT > this.view.resolvedContentHeight - this.view.resolvedInnerHeight ||
			scrollL > this.view.resolvedContentWidth - this.view.resolvedInnerWidth) {
			return
		}

		if (scrollT == this.scrollTop &&
			scrollL == this.scrollLeft) {
			return
		}

		this.scrollTop = scrollT
		this.scrollLeft = scrollL

		this.updateIfNeeded()
	}

	//--------------------------------------------------------------------------
	//  Private API
	//--------------------------------------------------------------------------

	/**
	 * @method createItem
	 * @since 0.7.0
	 * @hidden
	 */
	private fun createItem(index: Int): JavaScriptView? {

		if (index < this.minimum ||
			index > this.maximum) {
			return null
		}

		val type = this.context.createReturnValue()
		val view = this.context.createReturnValue()

		this.callMethod("nativeDefineItem", arrayOf(this.context.createNumber(index)), type)

		if (type.isNull) {
			return null
		}

		val name = type.property("name").string

		val reused = this.reuseItem(name)
		if (reused != null) {
			return reused
		}

		type.construct(null, view)

		val item = view.property("native").cast(JavaScriptView::class.java)
		if (item == null) {
			return null
		}

		item.protect()

		this.types[index] = item.className

		return item
	}

	/**
	 * @method reuseItem
	 * @since 0.7.0
	 * @hidden
	 */
	private fun cacheItem(index: Int) {

		val item = this.items[index]
		if (item == null) {
			return
		}

		this.cacheItem(item)
	}

	/**
	 * @method reuseItem
	 * @since 0.7.0
	 * @hidden
	 */
	private fun reuseItem(index: Int): JavaScriptView? {

		val type = this.types[index]
		if (type == null) {
			return null
		}

		return this.reuseItem(type)
	}

	/**
	 * @method updateContentOffset
	 * @since 0.2.0
	 * @hidden
	 */
	private fun updateContentOffset() {
		when (this.orientation) {
			Orientation.VERTICAL   -> this.view.contentTop.reset(this.contentOffset)
			Orientation.HORIZONTAL -> this.view.contentLeft.reset(this.contentOffset)
		}
	}

	/**
	 * @method updateContentLength
	 * @since 0.2.0
	 * @hidden
	 */
	private fun updateContentLength() {
		when (this.orientation) {
			Orientation.VERTICAL   -> this.view.contentHeight.reset(this.contentLength + this.view.resolvedPaddingTop + this.view.resolvedPaddingBottom)
			Orientation.HORIZONTAL -> this.view.contentWidth.reset(this.contentLength + this.view.resolvedPaddingLeft + this.view.resolvedPaddingRight)
		}
	}

	/**
	 * @method removeHeadItems
	 * @since 0.2.0
	 * @hidden
	 */
	private fun removeHeadItems() {

		var head = this.headIndex
		if (head == -1) {
			return
		}

		while (head != -1) {

			val offset = this.getItemOffsetRelativeToScreenHead(head + 1)
			if (offset == null ||
				offset.tail > 0.0) {
				break
			}

			this.removeHeadItem(head)

			head = this.getNextItemIndex(head)
		}

		this.headIndex = head
	}

	/**
	 * @method removeTailItems
	 * @since 0.2.0
	 * @hidden
	 */
	private fun removeTailItems() {

		var tail = this.tailIndex
		if (tail == -1) {
			return
		}

		while (tail != -1) {

			val offset = this.getItemOffsetRelativeToScreenTail(tail - 1)
			if (offset == null ||
				offset.head < 0.0) {
				break
			}

			this.removeTailItem(tail)

			tail = this.getPrevItemIndex(tail)
		}

		this.tailIndex = tail
	}

	/**
	 * @method removeHeadItem
	 * @since 0.2.0
	 * @hidden
	 */
	private fun removeHeadItem(head: Int) {

		val item = this.items[head]
		if (item == null) {
			return
		}

		this.removeItem(head)

		when (this.orientation) {
			Orientation.VERTICAL   -> this.contentOffset += item.resolvedHeight
			Orientation.HORIZONTAL -> this.contentOffset += item.resolvedWidth
		}
	}

	/**
	 * @method removeTailItem
	 * @since 0.2.0
	 * @hidden
	 */
	private fun removeTailItem(tail: Int) {
		this.removeItem(tail)
	}

	/**
	 * @method insertHeadItems
	 * @since 0.2.0
	 * @hidden
	 */
	private fun insertHeadItems() {

		var head = this.headIndex
		if (head == -1) {
			return
		}

		val offset = this.getItemOffsetRelativeToScreenHead(head) ?: (
			Offset(
				this.getRelativeToEndOffset(this.contentOffset),
				this.getRelativeToEndOffset(this.contentOffset + this.getItemSize(head))
			)
		)

		if (offset.head < 0 &&
			offset.tail < 0) {
			return
		}

		while (true) {

			val prev = this.getPrevItemIndex(head)
			if (prev == -1) {
				break
			}

			head = prev

			this.insertHeadItem(head)

			val item = this.items[head]
			if (item == null) {
				return
			}

			when (this.orientation) {

				Orientation.VERTICAL   -> {
					offset.head -= item.resolvedHeight
					offset.tail -= item.resolvedHeight
				}

				Orientation.HORIZONTAL -> {
					offset.head -= item.resolvedWidth
					offset.tail -= item.resolvedWidth
				}
			}

			if (offset.head < 0 &&
				offset.tail < 0) {
				break
			}
		}

		this.headIndex = head
	}

	/**
	 * @method insertTailItems
	 * @since 0.2.0
	 * @hidden
	 */
	private fun insertTailItems() {

		var tail = this.tailIndex
		if (tail == -1) {
			return
		}

		val offset = this.getItemOffsetRelativeToScreenTail(tail) ?: (
			Offset(
				this.getRelativeToEndOffset(this.contentOffset),
				this.getRelativeToEndOffset(this.contentOffset + this.getItemSize(tail))
			)
		)

		if (offset.head > 0 &&
			offset.tail > 0) {
			return
		}

		while (true) {

			val next = this.getNextItemIndex(tail)
			if (next == -1) {
				break
			}

			tail = next

			this.insertTailItem(tail)

			val item = this.items[tail]
			if (item == null) {
				break
			}

			when (this.orientation) {

				Orientation.VERTICAL  -> {
					offset.head += item.resolvedHeight
					offset.tail += item.resolvedHeight
				}

				Orientation.HORIZONTAL -> {
					offset.head += item.resolvedWidth
					offset.tail += item.resolvedWidth
				}
			}

			if (offset.head > 0 &&
				offset.tail > 0) {
				break
			}
		}

		this.tailIndex = tail
	}

	/**
	 * @method insertHeadItem
	 * @since 0.2.0
	 * @hidden
	 */
	private fun insertHeadItem(head: Int) {

		if (head < this.minimum ||
			head > this.maximum) {
			return
		}

		this.insertItem(head)
		this.expandSize(head)

		val item = this.items[head]
		if (item == null) {
			return
		}

		when (this.orientation) {
			Orientation.VERTICAL   -> this.contentOffset -= item.resolvedHeight
			Orientation.HORIZONTAL -> this.contentOffset -= item.resolvedWidth
		}
	}

	/**
	 * @method insertTailItem
	 * @since 0.2.0
	 * @hidden
	 */
	private fun insertTailItem(tail: Int) {

		if (tail < this.minimum ||
			tail > this.maximum) {
			return
		}

		this.insertItem(tail)
		this.expandSize(tail)
	}

	/**
	 * @method insertItem
	 * @since 0.2.0
	 * @hidden
	 */
	private fun insertItem(index: Int) {

		if (index < this.minimum ||
			index > this.maximum) {
			return
		}

		var call = false
		var view = this.reuseItem(index)
		if (view == null) {
			view = this.createItem(index)
			call = true
		}

		val item = view
		if (item == null) {
			return
		}

		this.items[index] = item

		this.insertView(index, notify = call)

		if (call) {

			/*
			 * This handler is mostly responsible of attaching touch events
			 * and such things. In a managed type of view, its only required
			 * on the first time the view is inserted.
			 */

			this.callMethod("nativeOnInsertItem", arrayOf(this.context.createNumber(index), item))
		}

		/*
		 * This handler will force the item to update iself with data thus
		 * possibly invalidating the bounds and content of the item.
		 */

		this.callMethod("nativeOnReuseItem", arrayOf(this.context.createNumber(index), item))
	}

	/**
	 * @method removeItem
	 * @since 0.2.0
	 * @hidden
	 */
	private fun removeItem(index: Int) {

		if (index < this.headIndex &&
			index > this.tailIndex) {
			return
		}

		val item = this.items[index]
		if (item == null) {
			return
		}

		/*
		 * This handler is responsible of dispatching the onCache event which
		 * the view might use to clear stuff like timers and events. Even though
		 * the view is cached, it still considered as being in the view.
		 */

		this.callMethod("nativeOnCacheItem", arrayOf(this.context.createNumber(index), item))

		this.cacheItem(index)
		this.removeView(index, notify = false)

		this.items.remove(index)
	}

	/**
	 * @method insertView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun insertView(index: Int, notify: Boolean) {

		val view = this.items[index]
		if (view == null) {
			return
		}

		val index = this.getInsertIndex(index)
		this.view.inject(view, index, notify = notify)
		this.list.insert(view, index)
	}

	/**
	 * @method removeView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeView(index: Int, notify: Boolean) {

		val view = this.items[index]
		if (view == null) {
			return
		}

		this.view.remove(view, notify = notify)
		this.list.remove(view)
	}

	/**
	 * @method expandSize
	 * @since 0.7.0
	 * @hidden
	 */
	private fun expandSize(index: Int) {

		val item = this.items[index]
		if (item == null) {
			return
		}

		item.measure()

		val size: Double

			when (this.orientation) {
				Orientation.VERTICAL   -> size = item.resolvedHeight
				Orientation.HORIZONTAL -> size = item.resolvedWidth
			}

		val current = this.getItemSize(index)
		if (current == size) {
			return
		}

		this.sizes[index] = size

		this.contentLength -= current
		this.contentLength += size
	}

	/**
	 * @method reduceSize
	 * @since 0.7.0
	 * @hidden
	 */
	private fun reduceSize(index: Int) {

		val item = this.items[index]
		if (item == null) {
			return
		}

		val size: Double

			when (this.orientation) {
				Orientation.VERTICAL   -> size = item.resolvedHeight
				Orientation.HORIZONTAL -> size = item.resolvedWidth
			}

		this.contentLength -= size

		this.sizes.remove(index)
	}

	/**
	 * @method insertSpot
	 * @since 0.2.0
	 * @hidden
	 */
	private fun insertSpot(index: Int) {

		if (index > this.tailIndex) {
			return
		}

		for (i in (index..this.tailIndex).reversed()) {
			if (i >= this.headIndex) {
				this.items[i + 1] = this.items[i]!!
				this.types[i + 1] = this.types[i]!!
				this.sizes[i + 1] = this.sizes[i]!!
			}
		}

		this.items.remove(index)
		this.types.remove(index)
		this.sizes.remove(index)
	}

	/**
	 * @method removeSpot
	 * @since 0.2.0
	 * @hidden
	 */
	private fun removeSpot(index: Int) {

		for (i in index until this.tailIndex) {
			if (index >= this.headIndex) {
				this.items[i] = this.items[i + 1]!!
				this.types[i] = this.types[i + 1]!!
				this.sizes[i] = this.sizes[i + 1]!!
			}
		}

		this.items.remove(this.tailIndex)
		this.types.remove(this.tailIndex)
		this.sizes.remove(this.tailIndex)
	}

	/**
	 * @method clear
	 * @since 0.2.0
	 * @hidden
	 */
	private fun clear() {

		this.items.toMutableMap().forEach { (index, _) ->
			this.removeItem(index)
		}

		this.items.clear()
		this.types.clear()
		this.sizes.clear()
	}

	/**
	 * @method getInsertIndex
	 * @since 0.2.0
	 * @hidden
	 */
	private fun getInsertIndex(index: Int): Int {

		if (this.items[index + 1] == null) { return this.list.size }
		if (this.items[index - 1] == null) { return 0 }

		val item = this.items[index + 1]
		if (item == null) {
			return 0
		}

		return this.list.indexOf(item)
	}

	/**
	 * @method getNextItemIndex
	 * @since 0.2.0
	 * @hidden
	 */
	private fun getNextItemIndex(index: Int): Int {

		val index = index + 1

		if (index < this.minimum ||
			index > this.maximum) {
			return -1
		}

		return index
	}

	/**
	 * @method getPrevItemIndex
	 * @since 0.2.0
	 * @hidden
	 */
	private fun getPrevItemIndex(index: Int): Int {

		val index = index - 1

		if (index < this.minimum ||
			index > this.maximum) {
			return -1
		}

		return index
	}

	/**
	 * @method getRelativeHeadOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getRelativeHeadOffset(): Offset {
		return this.getItemOffsetRelativeToScreenHead(this.headIndex) ?: Offset.zero
	}

	/**
	 * @method getRelativeTailOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getRelativeTailOffset(): Offset {
		return this.getItemOffsetRelativeToScreenTail(this.tailIndex) ?: Offset.zero
	}

	/**
	 * @method getItemOffsetRelativeToScreenHead
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getItemOffsetRelativeToScreenHead(index: Int): Offset? {

		if (index < this.minimum ||
			index > this.maximum) {
			return null
		}

		if (index < this.headIndex ||
			index > this.tailIndex) {
			return null
		}

		val item = this.items[index]
		if (item == null) {
			return null
		}

		var offset = 0.0
		var length = 0.0

		when (this.orientation) {

			Orientation.VERTICAL   -> {
				offset = item.resolvedTop
				length = item.resolvedHeight
			}

			Orientation.HORIZONTAL -> {
				offset = item.resolvedLeft
				length = item.resolvedWidth
			}
		}

		/*
		 * Sometime the item position will be calculated before a layout
		 * occurs. In this case we must manually add the content offset.
		 */

		if (this.contentOffsetInvalid) {

			val current: Double

				when (this.orientation) {
					Orientation.VERTICAL   -> current = this.view.contentTop.number
					Orientation.HORIZONTAL -> current = this.view.contentLeft.number
				}

			offset += (this.contentOffset - current)
		}

		return Offset(
			this.getRelativeToStartOffset(offset),
		 	this.getRelativeToStartOffset(offset + length)
		)
	}

	/**
	 * @method getItemOffsetRelativeToScreenTail
	 * @since 0.2.0
	 * @hidden
	 */
	private fun getItemOffsetRelativeToScreenTail(index: Int): Offset? {

		if (index < this.minimum ||
			index > this.maximum) {
			return null
		}

		if (index < this.headIndex ||
			index > this.tailIndex) {
			return null
		}

		val item = this.items[index]
		if (item == null) {
			return null
		}

		var offset = 0.0
		var length = 0.0

		when (this.orientation) {

			Orientation.VERTICAL  -> {
				offset = item.resolvedTop
				length = item.resolvedHeight
			}

			Orientation.HORIZONTAL -> {
				offset = item.resolvedLeft
				length = item.resolvedWidth
			}
		}

		/*
		 * Sometime the item position will be calculated before a layout
		 * occurs. In this case we must manually add the content offset.
		 */

		if (this.contentOffsetInvalid) {

			val current: Double

			when (this.orientation) {
				Orientation.VERTICAL   -> current = this.view.contentTop.number
				Orientation.HORIZONTAL -> current = this.view.contentLeft.number
			}

			offset += (this.contentOffset - current)
		}

		return Offset(
			this.getRelativeToEndOffset(offset),
			this.getRelativeToEndOffset(offset + length)
		)
	}

	/**
	 * @method getRelativeToStartOffset
	 * @since 0.2.0
	 * @hidden
	 */
	private fun getRelativeToStartOffset(offset: Double): Double {
		when (this.orientation) {
			Orientation.VERTICAL   -> return offset - this.scrollTop
			Orientation.HORIZONTAL -> return offset - this.scrollLeft
		}
	}

	/**
	 * @method getRelativeToEndOffset
	 * @since 0.2.0
	 * @hidden
	 */
	private fun getRelativeToEndOffset(offset: Double): Double {
		when (this.orientation) {
			Orientation.VERTICAL   -> return offset - this.scrollTop - this.view.resolvedInnerHeight
			Orientation.HORIZONTAL -> return offset - this.scrollLeft - this.view.resolvedInnerWidth
		}
	}

	/**
	 * @method getItemSize
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getItemSize(index: Int): Double {
		return this.sizes[index] ?: this.estimatedItemSize
	}

	/**
	 * @method hasVisibleItems
	 * @since 0.7.0
	 * @hidden
	 */
	private fun hasVisibleItems(): Boolean {

		val headOffset = this.getItemOffsetRelativeToScreenHead(this.headIndex)
		val tailOffset = this.getItemOffsetRelativeToScreenHead(this.tailIndex)

		if (headOffset == null ||
			tailOffset == null) {
			return false
		}

		return (headOffset.tail < 0 && tailOffset.tail < 0) == false
	}

	/**
	 * @method isFilled
	 * @since 0.7.0
	 * @hidden
	 */
	private fun isFilled(): Boolean {

		if (this.headIndex == -1 &&
			this.tailIndex == -1) {
			return false
		}

		val offset = this.getItemOffsetRelativeToScreenTail(this.tailIndex)
		if (offset == null ||
			offset.head > 0.0) {
			return true
		}

		return false
	}

	//--------------------------------------------------------------------------
	//  JavaScript Properties
	//--------------------------------------------------------------------------


	/**
	 * @method jsGet_length
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_length(callback: JavaScriptGetterCallback) {
		callback.returns(this.length.toDouble())
	}

	/**
	 * @method jsSet_length
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_length(callback: JavaScriptSetterCallback) {
		this.length = callback.value.number.toInt()
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_orientation
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_orientation(callback: JavaScriptGetterCallback) {
		when (this.orientation) {
			Orientation.VERTICAL   -> callback.returns(1.0)
			Orientation.HORIZONTAL -> callback.returns(2.0)
		}
	}

	/**
	 * @method jsSet_orientation
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_orientation(callback: JavaScriptSetterCallback) {
		this.orientation = Orientation.get(callback.value.number)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_estimatedItemSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_estimatedItemSize(callback: JavaScriptGetterCallback) {
		callback.returns(this.estimatedItemSize)
	}

	/**
	 * @method jsSet_estimatedItemSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_estimatedItemSize(callback: JavaScriptSetterCallback) {
		this.estimatedItemSize = callback.value.number
	}

	//--------------------------------------------------------------------------
	//  JavaScript Function
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_reloadData
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_reloadData(callback: JavaScriptFunctionCallback) {
		this.reload()
	}

	/**
	 * @method jsFunction_insertData
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_insertData(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 3) {
			fatalError("Method JavaScriptListOptimizer.insertData() requires 3 arguments.")
		}

		val index   = callback.argument(0).number.toInt()
		val count   = callback.argument(1).number.toInt()
		val animate = callback.argument(2).boolean

		val min = index
		val max = index + count - 1

		for (index in min .. max) {

			if (this.headIndex == -1 &&
				this.tailIndex == -1) {

				/*
				 * Data is inserted in an empty list. Add items, set the new
				 * head and tail based on the amount of inserted items and
				 * adjust the content size
				 */

				this.headIndex = 0
				this.tailIndex = 0

				/*
				 * The expand size method add size difference between the
				 * item estimated size and its measured size. Since this is
				 * a new item we must manually add the estimated item size
				 * to the content size.
				 */

				when (this.orientation) {
					Orientation.VERTICAL   -> this.contentLength += this.estimatedItemSize
					Orientation.HORIZONTAL -> this.contentLength += this.estimatedItemSize
				}

				this.insertItem(index)
				this.expandSize(index)

				if (animate) {
					this.insert.add(InsertItemData(this.items[index]!!, index))
				}

			} else {

				val filled = this.isFilled()

				/*
				 * Data is inserted between the range of visible items. A new
				 * item must be created and inserted. The head index always
				 * remains the same but the tail needs to be incremented.
				 */

				if (index >= this.headIndex &&
					index <= this.tailIndex ||
					filled == false) {

					/*
					 * The expand size method add size difference between the
					 * item estimated size and its measured size. Since this is
					 * a new item we must manually add the estimated item size
					 * to the content size.
					 */

					when (this.orientation) {
						Orientation.VERTICAL   -> this.contentLength += this.estimatedItemSize
						Orientation.HORIZONTAL -> this.contentLength += this.estimatedItemSize
					}

					if (index < this.tailIndex || filled == false) {

						this.insertSpot(index)
						this.insertItem(index)
						this.expandSize(index)

						this.tailIndex += 1

						if (animate) {
							this.insert.add(InsertItemData(this.items[index]!!, index))
						}
					}

				} else if (index < this.headIndex) {

					/*
					 * Data has been inserted before the head index which means
					 * that the data being currently after that displayed is one
					 * index off. This is fixed by incrementing the head and tail
					 * index.
					 */

					this.headIndex += 1
					this.tailIndex += 1
					this.insertSpot(index)

					this.contentLength += this.getItemSize(index)

				} else if (index > this.tailIndex) {

					/*
					 * Data has been inserted after the tail index which means that
					 * it has no effect beside incrementing the content length.
					 */

					this.contentLength += this.getItemSize(index)
				}
			}
		}

		this.updateContentLength()
		this.updateContentOffset()
	}

	/**
	 * @method jsFunction_removeData
	 * @since 0.2.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_removeData(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 3) {
			fatalError("Method JavaScriptListOptimizer.removeData() requires 3 arguments.")
		}

		val index   = callback.argument(0).number.toInt()
		val count   = callback.argument(1).number.toInt()
		val animate = callback.argument(2).boolean

		val min = index
		val max = index + count - 1

		for (i in min .. max) {

			if (index >= this.headIndex &&
				index <= this.tailIndex) {

				if (animate) {
					this.remove.add(RemoveItemData(this.items[index]!!, i))
				}

				/*
				 * Data is removed between the range of visible items. The item
				 * must be removed. The head index always remains the same but the
				 * tail needs to be decremented
				 */

				this.reduceSize(index)
				this.removeItem(index)
				this.removeSpot(index)

				this.tailIndex -= 1

			} else if (index < this.headIndex) {

				/*
				 * Data has been removed before the head index which means that
				 * the data being currently after that displayed is one index off.
				 * This is fixed by decrementing the head and tail index.
				 */

				this.headIndex -= 1
				this.tailIndex -= 1
				this.removeSpot(index)

				this.contentLength -= this.getItemSize(index)

			} else if (index > this.tailIndex) {

				/*
				 * Data has been removed after the tail index which means that it
				 * has no effect beside decrementing the content length.
				 */

				this.contentLength -= this.getItemSize(index)

			}
		}

		if (this.items.size == 0) {
			this.headIndex = -1
			this.tailIndex = -1
			this.contentOffset = 0.0
		}

		this.updateContentLength()
		this.updateContentOffset()
	}

	/**
	 * @method jsFunction_performTransition
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_performTransition(callback: JavaScriptFunctionCallback) {

		if (this.insert.size == 0 &&
			this.remove.size == 0) {
			return
		}

		this.view.resolve()

		val complete = this.context.createFunction {

			for (item in this.remove) {
				this.view.remove(item.view, notify = false)
			}

			this.insert.clear()
			this.remove.clear()
			this.updateIfNeeded()
		}

		val insert = this.insert.sortedBy { it.index }
		val remove = this.remove.sortedBy { it.index }
		val inserts = this.context.createEmptyArray()
		val removes = this.context.createEmptyArray()

		for ((index, data) in insert.withIndex()) {
			inserts.property(index, data.view)
		}

		for ((index, data) in remove.withIndex()) {
			removes.property(index, data.view)
		}

		for (data in remove) {
			this.view.insert(data.view, data.index)
		}

		callback.argument(0).call(arrayOf(inserts, removes, complete), null)
	}

	//--------------------------------------------------------------------------
	//  Classes
	//--------------------------------------------------------------------------

	/**
	 * @enum Orientation
	 * @since 0.7.0
	 * @hidden
	 */
	public enum class Orientation {

		VERTICAL,
		HORIZONTAL;

		companion object {

			/**
			 * Returns the proper scrollbars from a toString.
			 * @method get
			 * @since 0.7.0
			 */
			public fun get(value: Double): Orientation {
				return when (value) {
					1.0  -> Orientation.VERTICAL
					2.0  -> Orientation.HORIZONTAL
					else -> Orientation.VERTICAL
				}
			}
		}
	}

	/**
	 * @class Offset
	 * @since 0.7.0
	 * @hidden
	 */
	private data class Offset(var head: Double = 0.0, var tail: Double = 0.0) {
		companion object {
			public val zero = Offset(0.0, 0.0)
		}
	}

	/**
	 * @class InsertItemData
	 * @since 0.7.0
	 * @hidden
	 */
	private data class InsertItemData(val view: JavaScriptView, val index: Int)

	/**
	 * @class RemoveItemData
	 * @since 0.7.0
	 * @hidden
	 */
	private data class RemoveItemData(val view: JavaScriptView, val index: Int)
}
