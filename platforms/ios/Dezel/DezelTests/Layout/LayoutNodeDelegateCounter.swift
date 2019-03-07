import Dezel

public class LayoutNodeDelegateCounter : LayoutNodeDelegate {

	public var prepareLayoutCount: Int = 0
	public var measuredLayoutNodeCount: Int = 0
	public var didResolveSizeCount: Int = 0
	public var didResolvePositionCount: Int = 0
	public var didResolveInnerSizeCount: Int = 0
	public var didResolveContentSizeCount: Int = 0
	public var didResolveMarginCount: Int = 0
	public var didResolveBorderCount: Int = 0
	public var didResolvePaddingCount: Int = 0
	public var didInvalidateLayoutCount: Int = 0
	public var didBeginLayoutCount: Int = 0
	public var didFinishLayoutCount: Int = 0

	open func prepareLayoutNode(node: LayoutNode) {
		self.prepareLayoutCount += 1
	}

	open func measureLayoutNode(node: LayoutNode, in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize? {
		self.measuredLayoutNodeCount += 1
		return .zero
	}

	open func didResolveSize(node: LayoutNode) {
		self.didResolveSizeCount += 1
	}

	open func didResolvePosition(node: LayoutNode) {
		self.didResolvePositionCount += 1
	}

	open func didResolveInnerSize(node: LayoutNode) {
		self.didResolveInnerSizeCount += 1
	}

	open func didResolveContentSize(node: LayoutNode) {
		self.didResolveContentSizeCount += 1
	}

	open func didResolveMargin(node: LayoutNode) {
		self.didResolveMarginCount += 1
	}

	open func didResolveBorder(node: LayoutNode) {
		self.didResolveBorderCount += 1
	}

	open func didResolvePadding(node: LayoutNode) {
		self.didResolvePaddingCount += 1
	}

	open func didInvalidateLayout(node: LayoutNode) {
		self.didInvalidateLayoutCount += 1
	}

	open func didBeginLayout(node: LayoutNode) {
		self.didBeginLayoutCount += 1
	}

	open func didFinishLayout(node: LayoutNode) {
		self.didFinishLayoutCount += 1
	}
}
