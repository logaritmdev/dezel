/**
 * @function CTFrameCreateWithAttributedString
 * @since 0.5.0
 * @hidden
 */
internal func CTFrameCreateWithAttributedString(_ string: NSAttributedString, size: CGSize) -> CTFrame {

	let range = CFRangeMake(0, string.length)
	let framesetter = CTFramesetterCreateWithAttributedString(string)

	var size = size

	size.height = kTextLayoutFrameHeight

	if (size.width == CGFloat.max) {
		size.width = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, nil, size, nil).width
	}

	return CTFramesetterCreateFrame(framesetter, range, CGMutablePathCreateWithSize(size), nil)
}

/**
 * @function CTFrameGetLineOffsets
 * @since 0.5.0
 * @hidden
 */
internal func CTFrameGetLineOffsets(_ frame: CTFrame, _ count: Int) -> [CGPoint] {
	var offsets = Array<CGPoint>(repeating: .zero, count: count)
	CTFrameGetLineOrigins(frame, CFRangeMake(0, count), &offsets)
	return offsets
}
