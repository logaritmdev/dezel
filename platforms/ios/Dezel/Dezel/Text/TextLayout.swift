import CoreText

/**
 * Break up text into lines that fits into specified bounds.
 * @class TextLayout
 * @since 0.5.0
 */
open class TextLayout: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The text layout's text.
	 * @property text
	 * @since 0.5.0
	 */
	open var text: NSAttributedString = NSAttributedString(string: "") {
		willSet {
			self.invalidate()
		}
	}

	/**
	 * The text layout's ellipsis.
	 * @property ellipsis
	 * @since 0.5.0
	 */
	open var ellipsis: NSAttributedString = NSAttributedString(string: "…") {
		willSet {
			self.invalidate()
		}
	}

	/**
	 * The text layer's text kerning.
	 * @property textKerning
	 * @since 0.1.0
	 */
	open var textKerning: CGFloat = 0 {
		willSet {
			self.invalidate()
		}
	}

	/**
	 * The text layer's text leading.
	 * @property textLeading
	 * @since 0.1.0
	 */
	open var textLeading: CGFloat = 0 {
		willSet {
			self.invalidate()
		}
	}

	/**
	 * The text layer's text baseline.
	 * @property textBaseline
	 * @since 0.1.0
	 */
	open var textBaseline: CGFloat = 0 {
	 	willSet {
	 		self.invalidate()
		}
	}

	/**
	 * The text layer's text placement.
	 * @property textPlacement
	 * @since 0.1.0
	 */
	open var textPlacement: TextPlacement = .middle {
		willSet {
			self.invalidate()
		}
	}

	/**
	 * The text layout's text overflow.
	 * @property textOverflow
	 * @since 0.5.0
	 */
	open var textOverflow: TextOverflow = .ellipsis {
		willSet {
			self.invalidate()
		}
	}

	/**
	 * The text layout's line limit.
	 * @property lines
	 * @since 0.5.0
	 */
	open var lines: Int = 0 {
		willSet {
			self.invalidate()
		}
	}

	/**
	 * The text layout given size.
	 * @property bounds
	 * @since 0.5.0
	 */
	private(set) public var bounds: CGSize = .zero

	/**
	 * The text layout's computed limits.
	 * @property extent
	 * @since 0.5.0
	 */
	private(set) public var limits: CGSize = .zero

	/**
	 * The text layout's size that is taken.
	 * @property extent
	 * @since 0.5.0
	 */
	private(set) public var extent: CGSize = .zero

	/**
	 * The text layout's size measured by the frame setter.
	 * @property length
	 * @since 0.5.0
	 */
	private(set) public var length: CGSize = .zero

	/**
	 * The text layout's frame offset.
	 * @property offset
	 * @since 0.5.0
	 */
	private(set) public var offset: CGPoint = .zero

	/**
	 * Whether the text layout is invalid.
	 * @property invalid
	 * @since 0.5.0
	 */
	private(set) public var invalid: Bool = false

	/**
	 * @property setter
	 * @since 0.5.0
	 * @hidden
	 */
	private var setter: CTFramesetter!

	/**
	 * @property frame
	 * @since 0.5.0
	 * @hidden
	 */
	private var frame: CTFrame!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Returns the character at the specified location.
	 * @method find
	 * @since 0.5.0
	 */
	open func find(at point: CGPoint) -> NSAttributedString? {

		if (self.text.length == 0) {
			return nil
		}

		guard let lines = CTFrameGetLines(self.frame) as? [CTLine] else {
			return nil
		}

		let limit = self.getLineLimit()

		let bounds = self.bounds
		let extent = self.extent

		var offset = self.offset.y
		offset -= bounds.height
		offset += extent.height

		switch (self.textPlacement) {

			case .middle:
				offset += self.extent.alignMiddle(of: bounds).y
			case .bottom:
				offset += self.extent.alignBottom(of: bounds).y

			default: break
		}

		offset = offset + self.textBaseline
		offset = offset * -1

		var transform = CGAffineTransform.identity
		transform = transform.translatedBy(x: 0, y: bounds.height)
		transform = transform.scaledBy(x: 1, y: -1)
		transform = transform.translatedBy(x: 0, y: offset)
		let point = point.applying(transform)

		let offsets = CTFrameGetLineOffsets(frame, lines.count)

		for (index, line) in lines.enumerated() {

			var bounds = CTLineGetBoundsWithOptions(line, .useOpticalBounds)
			bounds.origin.x = offsets[index].x
			bounds.origin.y = offsets[index].y

			if (point.x < bounds.minX || point.x > bounds.maxX ||
				point.y < bounds.minY || point.y > bounds.maxY) {
				continue
			}

			let index = CTLineGetStringIndexForPosition(line, CGPoint(x: point.x - bounds.origin.x, y: point.y))
			if (index != kCFNotFound) {
				return self.text.substring(offset: index == self.text.length ? self.text.length - 1 : index, length: 1)
			}

			if (index == limit) {
				break
			}
		}

		return nil
	}

	/**
	 * Invalidates the layout.
	 * @method invalidate
	 * @since 0.5.0
	 */
	open func invalidate() {
		self.invalid = true
	}

	/**
	 * Builds the layout.
	 * @method build
	 * @since 0.5.0
	 */
	open func build(in bounds: CGSize) {

		if (self.text.length == 0) {
			return
		}

		if (self.invalid == false) {
			if (self.bounds.equalTo(bounds) == false &&
				self.extent.equalTo(bounds) == false) {
				self.invalid = true
			}
		}

		self.bounds = bounds

		if (self.invalid == false) {
			return
		}

		var w = bounds.width
		var h = bounds.height

		if (w == 0) { w = CGFloat.max }
		if (h == 0) { h = CGFloat.max }

		let limits = CGSize(width: w, height: h)

		self.limits = limits
		self.extent = .zero
		self.length = .zero
		self.offset = .zero

		self.frame = CTFrameCreateWithAttributedString(self.text, size: limits)

		guard let lines = CTFrameGetLines(self.frame) as? [CTLine] else {
			return
		}

		let limit = self.getLineLimit()

		for (index, line) in lines.enumerated() {

			let bounds = CTLineGetBoundsWithOptions(line, [])

			let w = bounds.width
			let h = bounds.height

			if (self.length.width < w) {
				self.length.width = w
			}

			if (index <= limit) {

				if (self.extent.width < w) {
					self.extent.width = w
				}

				self.extent.height += ceil(h)
				self.extent.height += self.textLeading
			}
		}

		self.length.height = kTextLayoutFrameHeight
		self.length.ceil()
		self.extent.ceil()

		self.offset.x = self.length.width - self.extent.width
		self.offset.y = self.length.height - self.extent.height

		if (self.extent.width < self.bounds.width) {
			self.extent.width = self.bounds.width
		}

		self.invalid = false
	}

	/**
	 * Draws the text layout.
	 * @method invalidate
	 * @since 0.5.0
	 */
	open func draw(in context: CGContext) {

		guard let lines = CTFrameGetLines(self.frame) as? [CTLine] else {
			return
		}

		let limit = self.getLineLimit()

		var height = CGFloat(0)
		let bounds = self.bounds
		let extent = self.extent

		var offset = self.offset.y
		offset -= bounds.height
		offset += extent.height

		switch (self.textPlacement) {

			case .middle:
				offset += extent.alignMiddle(of: bounds).y
			case .bottom:
				offset += extent.alignBottom(of: bounds).y

			default: break
		}

		offset = offset + self.textBaseline
		offset = offset * -1

		context.translateBy(x: 0, y: bounds.height)
		context.scaleBy(x: 1, y: -1)
		context.translateBy(x: 0, y: offset)

		let offsets = CTFrameGetLineOffsets(self.frame, lines.count)

		for (index, value) in lines.enumerated() {

			var line = value

			height += self.measureHeight(line)

			context.textPosition.x = offsets[index].x
			context.textPosition.y = offsets[index].y

			let finished = self.isLastVisibleLine(
				line,
				lines: lines,
				index: index,
				limit: limit,
				height: height
			)

			if (finished) {

				if (self.textOverflow == .ellipsis && index < lines.count - 1) {

					if let last = self.text.truncate(range: CTLineGetStringRange(line), bounds: self.bounds, character: self.ellipsis) {

						if (context.textPosition.x > 0) {

							/*
							 * Reposition the truncated line using the ratio of new empty
							 * space versus the old empty space
							 */

							let x = (
								(self.bounds.width - CTLineGetBoundsWithOptions(last, .useOpticalBounds).size.width) /
								(self.bounds.width - CTLineGetBoundsWithOptions(line, .useOpticalBounds).size.width)
							) * context.textPosition.x

							context.textPosition.x = CGFloat.sround(x)
						}

						line = last
					}
				}
			}

			CTLineDraw(line, context)

			if (finished) {
				break
			}
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method measureHeight
	 * @since 0.5.0
	 * @hidden
	 */
	private func measureHeight(_ line: CTLine) -> CGFloat {
		return CTLineGetBoundsWithOptions(line, .useOpticalBounds).height + self.textLeading
	}

	/**
	 * @method isLastVisibleLine
	 * @since 0.5.0
	 * @hidden
	 */
	private func isLastVisibleLine(_ line: CTLine, lines: [CTLine], index: Int, limit: Int, height: CGFloat) -> Bool {
		return index == limit || (index < lines.count - 1 && self.measureHeight(line) + height > self.bounds.height)
	}

	/**
	 * @method getLineLimit
	 * @since 0.5.0
	 * @hidden
	 */
	private func getLineLimit() -> Int {
		return self.lines > 0 ? self.lines - 1 : CFArrayGetCount(CTFrameGetLines(self.frame)) - 1
	}
}

/**
 * @const kTextLayoutFrameHeight
 * @since 0.5.0
 * @hidden
 */
internal let kTextLayoutFrameWidth = CGFloat(10000)
internal let kTextLayoutFrameHeight = CGFloat(10000)

