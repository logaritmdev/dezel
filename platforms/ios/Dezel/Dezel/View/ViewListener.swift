/**
 * @protocol ViewDelegate
 * @since 0.1.0
 */
public protocol ViewDelegate : class {
	func willRedraw(view:View, context:CGContext)
	func willLayout(view:View)
	func didLayout(view:View)
	func didMeasureTop(view:View, value:CGFloat)
	func didMeasureLeft(view:View, value:CGFloat)
	func didMeasureWidth(view:View, value:CGFloat)
	func didMeasureHeight(view:View, value:CGFloat)
	func didMeasureInnerWidth(view:View, value:CGFloat)
	func didMeasureInnerHeight(view:View, value:CGFloat)
	func didMeasureContentWidth(view:View, value:CGFloat)
	func didMeasureContentHeight(view:View, value:CGFloat)
	func didMeasureMarginTop(view:View, value:CGFloat)
	func didMeasureMarginLeft(view:View, value:CGFloat)
	func didMeasureMarginRight(view:View, value:CGFloat)
	func didMeasureMarginBottom(view:View, value:CGFloat)
	func didMeasurePaddingTop(view:View, value:CGFloat)
	func didMeasurePaddingLeft(view:View, value:CGFloat)
	func didMeasurePaddingRight(view:View, value:CGFloat)
	func didMeasurePaddingBottom(view:View, value:CGFloat)
	func didBeginDragging(view:View)
	func didEndDragging(view:View)
	func didDrag(view:View)
	func didBeginScrolling(view:View)
	func didEndScrolling(view:View)
	func didBeginDecelerating(view:View)
	func didEndDecelerating(view:View)
	func didScroll(view:View, l:CGFloat, t:CGFloat)
	func didApply(view:View, property: String, value:Raw, updated: Bool)
}
