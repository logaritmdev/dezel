package ca.logaritm.dezel.view

import android.util.SizeF
import ca.logaritm.dezel.view.display.DisplayNode
import ca.logaritm.dezel.view.display.DisplayNodeListener

public class DisplayNodeListenerCounter : DisplayNodeListener {

	public var measured: Int = 0
	public var resolvedSize: Int = 0
	public var resolvedOrigin: Int = 0
	public var resolvedInnerSize: Int = 0
	public var resolvedContentSize: Int = 0
	public var resolvedMargin: Int = 0
	public var resolvedBorder: Int = 0
	public var resolvedPadding: Int = 0
	public var invalidate: Int = 0
	public var layoutBegan: Int = 0
	public var layoutEnded: Int = 0

	override fun measure(node: DisplayNode, bounds: SizeF, min: SizeF, max: SizeF): SizeF? {
		this.measured += 1
		return SizeF(-1f, -1f)
	}

	override fun onInvalidate(node: DisplayNode) {
		this.invalidate += 1
	}

	override fun onResolveSize(node: DisplayNode) {
		this.resolvedSize += 1
	}

	override fun onResolveOrigin(node: DisplayNode) {
		this.resolvedOrigin += 1
	}

	override fun onResolveInnerSize(node: DisplayNode) {
		this.resolvedInnerSize += 1
	}

	override fun onResolveContentSize(node: DisplayNode) {
		this.resolvedContentSize += 1
	}

	override fun onResolveMargin(node: DisplayNode) {
		this.resolvedMargin += 1
	}

	override fun onResolveBorder(node: DisplayNode) {
		this.resolvedBorder += 1
	}

	override fun onResolvePadding(node: DisplayNode) {
		this.resolvedPadding += 1
	}

	override fun layoutBegan(node: DisplayNode) {
		this.layoutBegan += 1
	}

	override fun layoutEnded(node: DisplayNode) {
		this.layoutEnded += 1
	}
}
