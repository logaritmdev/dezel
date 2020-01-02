package ca.logaritm.dezel.modules.view

import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.core.JavaScriptSetterCallback
import ca.logaritm.dezel.extension.fatalError
import ca.logaritm.dezel.extension.type.insert
import ca.logaritm.dezel.extension.type.pop

/**
 * @class JavaScriptRecycler
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptRecycler(context: JavaScriptContext): JavaScriptClass(context), JavaScriptView.Listener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private lateinit var view: JavaScriptView

	/**
	 * @property list
	 * @since 0.7.0
	 * @hidden
	 */
	private var list: MutableList<JavaScriptView> = mutableListOf()

	/**
	 * @property size
	 * @since 0.7.0
	 * @hidden
	 */
	private var size: Int = 0

	/**
	 * @property views
	 * @since 0.7.0
	 * @hidden
	 */
	private var views: MutableMap<Int, JavaScriptView> = mutableMapOf()

	/**
	 * @property cache
	 * @since 0.7.0
	 * @hidden
	 */
	private var cache: MutableMap<String, MutableList<JavaScriptView>> = mutableMapOf()

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
	 * @property estimatedItemSize
	 * @since 0.7.0
	 * @hidden
	 */
	private var estimatedItemSize: Double = 50.0

	/**
	 * @property direction
	 * @since 0.7.0
	 * @hidden
	 */
	private var direction: Direction = Direction.VERTICAL

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
	private var scrollTop: Double = 0.0

	/**
	 * @property scrollLeft
	 * @since 0.7.0
	 * @hidden
	 */
	private var scrollLeft: Double = 0.0

	/**
	 * @property contentOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private var contentOffset: Double = 0.0

	/**
	 * @property contentLength
	 * @since 0.7.0
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
	 * @property insert
	 * @since 0.7.0
	 * @hidden
	 */
	private var insert: MutableList<InsertViewData> = mutableListOf()

	/**
	 * @property remove
	 * @since 0.7.0
	 * @hidden
	 */
	private var remove: MutableList<RemoveViewData> = mutableListOf()

	/**
	 * @property minimum
	 * @since 0.7.0
	 * @hidden
	 */
	private val minimum: Int
		get() = 0

	/**
	 * @property maximum
	 * @since 0.7.0
	 * @hidden
	 */
	private val maximum: Int
		get() = this.size - 1

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method attach
	 * @since 0.7.0
	 */
	open fun attach(view: JavaScriptView, size: Int) {

		this.size = size
		this.view = view
		this.view.listener = this
		this.view.scheduleLayout()

		this.protect()
	}

	/**
	 * @method detach
	 * @since 0.7.0
	 */
	open fun detach() {

		this.view.listener = null
		this.view.scheduleLayout()
		this.view.unprotect()

		this.unprotect()

		this.cache.values.forEach {
			it.forEach { view ->
				view.unprotect()
				view.dispose()
			}
		}

		this.views.clear()
		this.cache.clear()
		this.types.clear()
		this.sizes.clear()
		
		this.insert.clear()
		this.remove.clear()
	}

	//--------------------------------------------------------------------------
	// View Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method onPrepareLayout
	 * @since 0.7.0
	 */
	override fun onPrepareLayout(view: JavaScriptView) {

		when (view.contentDirection.string) {

			"horizontal" -> this.direction = Direction.HORIZONTAL
			"vertical"   -> this.direction = Direction.VERTICAL

			else -> {
				this.direction = Direction.VERTICAL
			}
		}

		val size = this.size
		if (size == 0) {

			this.clear()
			this.contentLength = 0.0
			this.contentOffset = 0.0
			this.view.contentTop.reset(0)
			this.view.contentLeft.reset(0)
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

			this.contentLength = this.estimatedItemSize * size.toDouble()

			var offset = Offset(
				head = this.getRelativeToEndOffset(0.0),
				tail = this.getRelativeToEndOffset(0.0)
			)

			var before = Offset(
				head = offset.head,
				tail = offset.tail
			)

			for (i in 0 until size) {

				this.tailIndex = i

				this.insertTailView(i)

				val item = this.views[i]
				if (item == null) {
					break
				}

				when (this.direction) {

					Direction.VERTICAL -> {
						offset.head = before.tail
						offset.tail = before.tail + item.resolvedHeight
					}

					Direction.HORIZONTAL -> {
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
	 * @method onResolveLayout
	 * @since 0.7.0
	 */
	override fun onResolveLayout(view: JavaScriptView) {
		this.contentOffsetInvalid = false
		this.contentLengthInvalid = false
	}

	/**
	 * @method onScroll
	 * @since 0.7.0
	 */
	override fun onScroll(view: JavaScriptView) {

		val scrollT = this.view.scrollTop.number
		val scrollL = this.view.scrollLeft.number

		if (scrollL < 0.0 ||
			scrollT < 0.0 ||
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
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method reload
	 * @since 0.7.0
	 * @hidden
	 */
	private fun reload() {

		this.clear()

		this.views = mutableMapOf()

		this.tailIndex = -1
		this.headIndex = -1
		this.scrollTop = 0.0
		this.scrollLeft = 0.0
		this.contentOffset = 0.0
		this.contentLength = 0.0

		this.view.scrollTop.reset(0)
		this.view.scrollLeft.reset(0)
		this.view.scheduleLayout()
	}

	/**
	 * @method updateIfNeeded
	 * @since 0.7.0
	 * @hidden
	 */
	private fun updateIfNeeded() {

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

			this.views.forEach {
				this.removeView(it.key)
			}

			var offset = 0.0

			for (index in 0 until this.size) {

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

			this.insertTailViews()
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
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update() {

		/*
		 * We're managing one more view on both the head and tail of the list
		 * because otherwise the view might be flashing for a brief time while
		 * scrolling really fast.
		 */

		val length = this.size
		if (length == 0) {
			return
		}

		if (this.contentLength == 0.0) {
			this.contentLength = this.estimatedItemSize * length.toDouble()
		}

		if (this.headIndex > -1 &&
			this.tailIndex > -1) {
			this.removeHeadViews()
			this.removeTailViews()
			this.insertHeadViews()
			this.insertTailViews()
		}
	}

	/**
	 * @method createView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun createView(index: Int): JavaScriptView? {

		if (index < this.minimum ||
			index > this.maximum) {
			return null
		}

		val type = this.context.createReturnValue()
		val view = this.context.createReturnValue()

		this.callMethod("nativeGetViewType", arrayOf(this.context.createNumber(index)), type)

		if (type.isNull) {
			return null
		}

		val name = type.property("name").string

		val reused = this.reuseView(name)
		if (reused != null) {
			return reused
		}

		type.construct(null, view)

		val item = view.cast(JavaScriptView::class.java)
		if (item == null) {
			return null
		}

		item.protect()

		this.types[index] = item.className.string

		return item
	}

	/**
	 * @method cacheView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun cacheView(item: JavaScriptView) {

		val type = item.className.string

			if (this.cache[type] == null) {
				this.cache[type] = mutableListOf()
			}

		this.cache[type]?.add(item)
	}

	/**
	 * @method reuseView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun reuseView(index: Int): JavaScriptView? {

		val type = this.types[index]
		if (type == null) {
			return null
		}

		return this.reuseView(type)
	}

	/**
	 * @method reuseView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun reuseView(type: String): JavaScriptView? {

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

	/**
	 * @method updateContentOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun updateContentOffset() {
		when (this.direction) {
			Direction.VERTICAL   -> this.view.contentTop.reset(this.contentOffset)
			Direction.HORIZONTAL -> this.view.contentLeft.reset(this.contentOffset)
		}
	}

	/**
	 * @method updateContentLength
	 * @since 0.7.0
	 * @hidden
	 */
	private fun updateContentLength() {
		when (this.direction) {
			Direction.VERTICAL   -> this.view.contentHeight.reset(this.contentLength + this.view.resolvedPaddingTop + this.view.resolvedPaddingBottom)
			Direction.HORIZONTAL -> this.view.contentWidth.reset(this.contentLength + this.view.resolvedPaddingLeft + this.view.resolvedPaddingRight)
		}
	}

	/**
	 * @method removeHeadViews
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeHeadViews() {

		var head = this.headIndex
		if (head == -1) {
			return
		}

		while (head != -1) {

			val offset = this.getItemOffsetRelativeToScreenHead(head + 1)
			if (offset == null ||
				offset.tail > 0) {
				break
			}

			this.removeHeadView(head)

			head = this.getNextItemIndex(head)
		}

		this.headIndex = head
	}

	/**
	 * @method removeHeadViews
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeTailViews() {

		var tail = this.tailIndex
		if (tail == -1) {
			return
		}

		while (tail != -1) {

			val offset = this.getItemOffsetRelativeToScreenTail(tail - 1)
			if (offset == null ||
				offset.head < 0) {
				break
			}

			this.removeTailView(tail)

			tail = this.getPrevItemIndex(tail)
		}

		this.tailIndex = tail
	}

	/**
	 * @method removeHeadView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeHeadView(head: Int) {

		val item = this.views[head]
		if (item == null) {
			return
		}

		this.removeView(head)

		when (this.direction) {
			Direction.VERTICAL   -> this.contentOffset += item.resolvedHeight
			Direction.HORIZONTAL -> this.contentOffset += item.resolvedWidth
		}
	}

	/**
	 * @method removeHeadView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeTailView(tail: Int) {
		this.removeView(tail)
	}

	/**
	 * @method insertHeadViews
	 * @since 0.7.0
	 * @hidden
	 */
	private fun insertHeadViews() {

		var head = this.headIndex
		if (head == -1) {
			return
		}

		val offset = this.getItemOffsetRelativeToScreenHead(head) ?: (
			Offset(
				head = this.getRelativeToEndOffset(this.contentOffset),
				tail = this.getRelativeToEndOffset(this.contentOffset + this.getItemSize(head))
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

			this.insertHeadView(head)

			val item = this.views[head]
			if (item == null) {
				return
			}

			when (this.direction) {

				Direction.VERTICAL -> {
					offset.head -= item.resolvedHeight
					offset.tail -= item.resolvedHeight
				}

				Direction.HORIZONTAL -> {
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
	 * @method insertTailViews
	 * @since 0.7.0
	 * @hidden
	 */
	private fun insertTailViews() {

		var tail = this.tailIndex
		if (tail == -1) {
			return
		}

		val offset = this.getItemOffsetRelativeToScreenTail(tail) ?: (
			Offset(
				head = this.getRelativeToEndOffset(this.contentOffset),
				tail = this.getRelativeToEndOffset(this.contentOffset + this.getItemSize(tail))
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

			this.insertTailView(tail)

			val item = this.views[tail]
			if (item == null) {
				break
			}

			when (this.direction) {

				Direction.VERTICAL -> {
					offset.head += item.resolvedHeight
					offset.tail += item.resolvedHeight
				}

				Direction.HORIZONTAL -> {
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
	 * @method insertHeadView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun insertHeadView(head: Int) {

		if (head < this.minimum ||
			head > this.maximum) {
			return
		}

		this.insertView(head)
		this.increaseSize(head)

		val item = this.views[head]
		if (item == null) {
			return
		}

		when (this.direction) {
			Direction.VERTICAL   -> this.contentOffset -= item.resolvedHeight
			Direction.HORIZONTAL -> this.contentOffset -= item.resolvedWidth
		}
	}

	/**
	 * @method insertTailView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun insertTailView(tail: Int) {

		if (tail < this.minimum ||
			tail > this.maximum) {
			return
		}

		this.insertView(tail)
		this.increaseSize(tail)
	}

	/**
	 * @method insertView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun insertView(index: Int) {

		if (index < this.minimum ||
			index > this.maximum) {
			return
		}

		var child = this.reuseView(index)
		if (child == null) {
			child = this.createView(index)
		}

		val view = child
		if (view == null) {
			return
		}

		this.views[index] = view

		val at = this.getInsertIndex(index)
		this.view.inject(view, at, notify = false)
		this.list.insert(view, at)

		/*
		 * Tells the managed view an item has been inserted so it is properly
		 * managed by the view and prepared for reuse.
		 */

		this.callMethod("nativeOnInsertView", arrayOf(this.context.createNumber(index), view))
	}

	/**
	 * @method removeItem
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeView(index: Int) {

		if (index < this.headIndex &&
			index > this.tailIndex) {
			return
		}

		val view = this.views[index]
		if (view == null) {
			return
		}

		/*
		 * Tells the managed view an item has been remove so it is properly
		 * managed by the view and prepared for cache.
		 */

		this.callMethod("nativeOnRemoveView", arrayOf(this.context.createNumber(index), view))

		this.cacheView(view)

		this.view.remove(view, notify = false)
		this.list.remove(view)

		this.views.remove(index)
	}

	/**
	 * @method increaseSize
	 * @since 0.7.0
	 * @hidden
	 */
	private fun increaseSize(index: Int) {

		val item = this.views[index]
		if (item == null) {
			return
		}

		item.measure()

		val size: Double

		when (this.direction) {
			Direction.VERTICAL   -> size = item.resolvedHeight
			Direction.HORIZONTAL -> size = item.resolvedWidth
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
	 * @method decreaseSize
	 * @since 0.7.0
	 * @hidden
	 */
	private fun decreaseSize(index: Int) {

		val item = this.views[index]
		if (item == null) {
			return
		}

		val size: Double

			when (this.direction) {
				Direction.VERTICAL   -> size = item.resolvedHeight
				Direction.HORIZONTAL -> size = item.resolvedWidth
			}

		this.contentLength -= size

		this.sizes.remove(index)
	}

	/**
	 * @method insertSpot
	 * @since 0.7.0
	 * @hidden
	 */
	private fun insertSpot(index: Int) {

		/*
		 * TOO Explain
		 */

		if (index > this.tailIndex) {
			return
		}

		for (i in (index..this.tailIndex).reversed()) {
			if (i >= this.headIndex) {
				this.views[i + 1] = this.views[i]!!
				this.types[i + 1] = this.types[i]!!
				this.sizes[i + 1] = this.sizes[i]!!
			}
		}

		this.views.remove(index)
		this.types.remove(index)
		this.sizes.remove(index)
	}

	/**
	 * @method removeSpot
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeSpot(index: Int) {

		/*
		 * TOO Explain
		 */

		for (i in index until this.tailIndex) {
			if (index >= this.headIndex) {
				this.views[i] = this.views[i + 1]!!
				this.types[i] = this.types[i + 1]!!
				this.sizes[i] = this.sizes[i + 1]!!
			}
		}

		this.views.remove(this.tailIndex)
		this.types.remove(this.tailIndex)
		this.sizes.remove(this.tailIndex)
	}

	/**
	 * @method clear
	 * @since 0.7.0
	 * @hidden
	 */
	private fun clear() {

		this.views.forEach {
			this.removeView(it.key)
		}

		this.views.clear()
		this.types.clear()
		this.sizes.clear()
	}

	/**
	 * @method getInsertIndex
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getInsertIndex(index: Int): Int {

		if (this.views[index + 1] == null) { return this.list.size }
		if (this.views[index - 1] == null) { return 0 }

		val item = this.views[index + 1]
		if (item == null) {
			return 0
		}

		return this.list.indexOf(item)
	}

	/**
	 * @method getNextItemIndex
	 * @since 0.7.0
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
	 * @since 0.7.0
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

		val item = this.views[index]
		if (item == null) {
			return null
		}

		var offset = 0.0
		var length = 0.0

		when (this.direction) {

			Direction.VERTICAL -> {
				offset = item.resolvedTop
				length = item.resolvedHeight
			}

			Direction.HORIZONTAL -> {
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

			when (this.direction) {
				Direction.VERTICAL   -> current = this.view.contentTop.number
				Direction.HORIZONTAL -> current = this.view.contentLeft.number
			}

			offset += (this.contentOffset - current)
		}

		return Offset(
			head = this.getRelativeToStartOffset(offset),
			tail = this.getRelativeToStartOffset(offset + length)
		)
	}

	/**
	 * @method getItemOffsetRelativeToScreenTail
	 * @since 0.7.0
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

		val item = this.views[index] 
		if (item == null) {
			return null
		}

		var offset = 0.0
		var length = 0.0

		when (this.direction) {

			Direction.VERTICAL -> {
				offset = item.resolvedTop
				length = item.resolvedHeight
			}

			Direction.HORIZONTAL -> {
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

			when (this.direction) {
				Direction.VERTICAL   -> current = this.view.contentTop.number
				Direction.HORIZONTAL -> current = this.view.contentLeft.number
			}

			offset += (this.contentOffset - current)
		}

		return Offset(
			head = this.getRelativeToEndOffset(offset),
			tail = this.getRelativeToEndOffset(offset + length)
		)
	}

	/**
	 * @method getRelativeToStartOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getRelativeToStartOffset(offset: Double): Double {
		when (this.direction) {
			Direction.VERTICAL   -> return offset - this.scrollTop
			Direction.HORIZONTAL -> return offset - this.scrollLeft
		}
	}

	/**
	 * @method getRelativeToEndOffset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getRelativeToEndOffset(offset: Double): Double {
		when (this.direction) {
			Direction.VERTICAL   ->	return offset - this.scrollTop - this.view.resolvedInnerHeight
			Direction.HORIZONTAL -> return offset - this.scrollLeft - this.view.resolvedInnerWidth
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
			offset.head > 0) {
			return true
		}

		return false
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

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptViewOptimizer.attach() requires 2 arguments.")
		}

		val view = callback.argument(0).cast(JavaScriptView::class.java)
		val size = callback.argument(1).number

		if (view == null) {
			return
		}

		this.attach(view, size.toInt())
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

	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_reloadData
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_reloadData(callback: JavaScriptFunctionCallback) {
		this.reload()
	}

	/**
	 * @method jsFunction_insertData
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_insertData(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 3) {
			fatalError("Method Recycler.insertData() requires 3 arguments.")
		}

		val index   = callback.argument(0).number.toInt()
		val count   = callback.argument(1).number.toInt()
		val animate = callback.argument(2).boolean

		this.size += count

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

				this.contentLength += this.estimatedItemSize

				this.insertView(index)
				this.increaseSize(index)

				if (animate) {
					this.insert.add(InsertViewData(view = this.views[index]!!, index = index))
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

					this.contentLength += this.estimatedItemSize

					if (index < this.tailIndex || filled == false) {

						this.insertSpot(index)
						this.insertView(index)
						this.increaseSize(index)

						this.tailIndex += 1

						if (animate) {
							this.insert.add(InsertViewData(view = this.views[index]!!, index = index))
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
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_removeData(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 3) {
			fatalError("Method Recycler.removeData() requires 3 arguments.")
		}

		val index   = callback.argument(0).number.toInt()
		val count   = callback.argument(1).number.toInt()
		val animate = callback.argument(2).boolean

		this.size -= count

		val min = index
		val max = index + count - 1

		for (i in min .. max) {

			if (index >= this.headIndex &&
				index <= this.tailIndex) {

				if (animate) {
					this.remove.add(RemoveViewData(view = this.views[index]!!, index = i))
				}

				/*
				 * Data is removed between the range of visible items. The item
				 * must be removed. The head index always remains the same but the
				 * tail needs to be decremented
				 */

				this.decreaseSize(index)
				this.removeView(index)
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

		if (this.views.size == 0) {
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
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @enum Direction
	 * @since 0.7.0
	 * @hidden
	 */
	private enum class Direction {
		VERTICAL,
		HORIZONTAL;
	}

	/**
	 * @struct Offset
	 * @since 0.7.0
	 * @hidden
	 */
	private class Offset(head: Double, tail: Double) {

		companion object {

			/**
			 * @property zero
			 * @since 0.7.0
			 */
			public val zero = Offset(head = 0.0, tail = 0.0)
		}

		/**
		 * @property head
		 * @since 0.7.0
		 */
		public var head: Double = 0.0

		/**
		 * @property tail
		 * @since 0.7.0
		 */
		public var tail: Double = 0.0

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		init {
			this.head = head
			this.tail = tail
		}
	}

	/**
	 * @struct InsertViewData
	 * @since 0.7.0
	 * @hidden
	 */
	private class InsertViewData(view: JavaScriptView, index: Int) {

		/**
		 * @property view
		 * @since 0.7.0
		 */
		public val view: JavaScriptView = view

		/**
		 * @property index
		 * @since 0.7.0
		 */
		public val index: Int = index
	}

	/**
	 * @struct RemoveViewData
	 * @since 0.7.0
	 * @hidden
	 */
	private class RemoveViewData(view: JavaScriptView, index: Int) {

		/**
		 * @property view
		 * @since 0.7.0
		 */
		public val view: JavaScriptView = view

		/**
		 * @property index
		 * @since 0.7.0
		 */
		public val index: Int = index
	}
}
