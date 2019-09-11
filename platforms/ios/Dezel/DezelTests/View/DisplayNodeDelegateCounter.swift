import Dezel

public class DisplayNodeDelegateCounter : DisplayNodeDelegate {

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

	open func measure(node: DisplayNode, in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize? {
		self.measuredLayoutNodeCount += 1
		return .zero
	}

	open func didInvalidate(node: DisplayNode) {
		self.didInvalidateLayoutCount += 1
	}

	open func didResolveSize(node: DisplayNode) {
		self.didResolveSizeCount += 1
	}

	open func didResolveOrigin(node: DisplayNode) {
		self.didResolvePositionCount += 1
	}

	open func didResolveInnerSize(node: DisplayNode) {
		self.didResolveInnerSizeCount += 1
	}

	open func didResolveContentSize(node: DisplayNode) {
		self.didResolveContentSizeCount += 1
	}

	open func didResolveMargin(node: DisplayNode) {
		self.didResolveMarginCount += 1
	}

	open func didResolveBorder(node: DisplayNode) {
		self.didResolveBorderCount += 1
	}

	open func didResolvePadding(node: DisplayNode) {
		self.didResolvePaddingCount += 1
	}

	open func layoutBegan(node: DisplayNode) {
		self.didBeginLayoutCount += 1
	}

	open func layoutEnded(node: DisplayNode) {
		self.didFinishLayoutCount += 1
	}
}
