import Dezel

public class DisplayNodeDelegateCounter : DisplayNodeDelegate {

	public var measured: Int = 0
	public var invalidate: Int = 0
	public var resolvedSize: Int = 0
	public var resolvedOrigin: Int = 0
	public var resolvedInnerSize: Int = 0
	public var resolvedContentSize: Int = 0
	public var resolvedMargin: Int = 0
	public var resolvedBorder: Int = 0
	public var resolvedPadding: Int = 0
	public var preparedLayout: Int = 0
	public var resolvedLayout: Int = 0

	public func didInvalidate(node: DisplayNode) {
		self.invalidate += 1
	}

	open func didResolveSize(node: DisplayNode) {
		self.resolvedSize += 1
	}

	open func didResolveOrigin(node: DisplayNode) {
		self.resolvedOrigin += 1
	}

	open func didResolveInnerSize(node: DisplayNode) {
		self.resolvedInnerSize += 1
	}

	open func didResolveContentSize(node: DisplayNode) {
		self.resolvedContentSize += 1
	}

	open func didResolveMargin(node: DisplayNode) {
		self.resolvedMargin += 1
	}

	open func didResolveBorder(node: DisplayNode) {
		self.resolvedBorder += 1
	}

	open func didResolvePadding(node: DisplayNode) {
		self.resolvedPadding += 1
	}

	public func didPrepareLayout(node: DisplayNode) {
		self.preparedLayout += 1
	}

	open func didResolveLayout(node: DisplayNode) {
		self.resolvedLayout += 1
	}

	open func measure(node: DisplayNode, in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize? {
		self.measured += 1
		return CGSize(width: -1, height: -1)
	}

	public func getProperty(_ name: String) -> JavaScriptProperty? {
		return nil;
	}

	public func setProperty(_ name: String, value: JavaScriptProperty) {

	}


}
