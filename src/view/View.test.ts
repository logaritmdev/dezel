import { Application } from '../application/Application'
import { Dezel } from '../core/Dezel'
import { Event } from '../event/Event'
import { Canvas } from '../graphic/Canvas'
import { TouchEvent } from '../touch/TouchEvent'
import { TouchList } from '../touch/TouchList'
import { View } from './View'

describe('View', () => {

	let view: View

	beforeAll(() => {
		Dezel.registerApplication(new Application)
	})

	beforeEach(() => {
		view = new View()
	})

	it('should have a valid initial id property value', () => {
		expect(view.id).toBe('')
	})

	it('should have a valid initial window property value', () => {
		expect(view.window).toBeNull()
	})

	it('should have a valid initial parent property value', () => {
		expect(view.parent).toBeNull()
	})

	it('should have a valid initial backgroundColor property value', () => {
		expect(view.backgroundColor).toBe('transparent')
	})

	it('should have a valid initial backgroundImage property value', () => {
		expect(view.backgroundImage).toBeNull()
	})

	it('should have a valid initial backgroundImageFit property value', () => {
		expect(view.backgroundImageFit).toBe('cover')
	})

	it('should have a valid initial backgroundImageAnchorTop property value', () => {
		expect(view.backgroundImageAnchorTop).toBe(0.5)
	})

	it('should have a valid initial backgroundImageAnchorLeft property value', () => {
		expect(view.backgroundImageAnchorLeft).toBe(0.5)
	})

	it('should have a valid initial backgroundImageTop property value', () => {
		expect(view.backgroundImageTop).toBe('50%')
	})

	it('should have a valid initial backgroundImageLeft property value', () => {
		expect(view.backgroundImageLeft).toBe('50%')
	})

	it('should have a valid initial backgroundImageWidth property value', () => {
		expect(view.backgroundImageWidth).toBe('auto')
	})

	it('should have a valid initial backgroundImageHeight property value', () => {
		expect(view.backgroundImageHeight).toBe('auto')
	})

	it('should have a valid initial border property value', () => {
		let border = view.border
		expect(border.width.top).toBe(0)
		expect(border.width.left).toBe(0)
		expect(border.width.right).toBe(0)
		expect(border.width.bottom).toBe(0)
		expect(border.color.top).toBe('#000')
		expect(border.color.left).toBe('#000')
		expect(border.color.right).toBe('#000')
		expect(border.color.bottom).toBe('#000')
	})

	it('should have a valid initial border width property value', () => {
		let borderWidth = view.borderWidth
		expect(borderWidth.top).toBe(0)
		expect(borderWidth.left).toBe(0)
		expect(borderWidth.right).toBe(0)
		expect(borderWidth.bottom).toBe(0)
	})

	it('should have a valid initial border color property value', () => {
		let borderColor = view.borderColor
		expect(borderColor.top).toBe('#000')
		expect(borderColor.left).toBe('#000')
		expect(borderColor.right).toBe('#000')
		expect(borderColor.bottom).toBe('#000')
	})

	it('should have a valid initial border top property value', () => {
		expect(view.borderTop).toBe('0 #000')
	})

	it('should have a valid initial border left property value', () => {
		expect(view.borderLeft).toBe('0 #000')
	})

	it('should have a valid initial border right property value', () => {
		expect(view.borderRight).toBe('0 #000')
	})

	it('should have a valid initial border bottom property value', () => {
		expect(view.borderBottom).toBe('0 #000')
	})

	it('should have a valid initial borderTopColor property value', () => {
		expect(view.borderTopColor).toBe('#000')
	})

	it('should have a valid initial borderTopColor property value', () => {
		expect(view.borderTopColor).toBe('#000')
	})

	it('should have a valid initial borderLeftColor property value', () => {
		expect(view.borderLeftColor).toBe('#000')
	})

	it('should have a valid initial borderRightColor property value', () => {
		expect(view.borderRightColor).toBe('#000')
	})

	it('should have a valid initial borderBottomColor property value', () => {
		expect(view.borderBottomColor).toBe('#000')
	})

	it('should have a valid initial borderTopWidth property value', () => {
		expect(view.borderTopWidth).toBe(0)
	})

	it('should have a valid initial borderLeftWidth property value', () => {
		expect(view.borderLeftWidth).toBe(0)
	})

	it('should have a valid initial borderRightWidth property value', () => {
		expect(view.borderRightWidth).toBe(0)
	})

	it('should have a valid initial borderBottomWidth property value', () => {
		expect(view.borderBottomWidth).toBe(0)
	})

	it('should have a valid initial minBorderTopWidth property value', () => {
		expect(view.minBorderTopWidth).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxBorderTopWidth property value', () => {
		expect(view.maxBorderTopWidth).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minBorderLeftWidth property value', () => {
		expect(view.minBorderLeftWidth).toBe(0)
	})

	it('should have a valid initial maxBorderLeftWidth property value', () => {
		expect(view.maxBorderLeftWidth).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minBorderRightWidth property value', () => {
		expect(view.minBorderRightWidth).toBe(0)
	})

	it('should have a valid initial maxBorderRightWidth property value', () => {
		expect(view.maxBorderRightWidth).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minBorderBottomWidth property value', () => {
		expect(view.minBorderBottomWidth).toBe(0)
	})

	it('should have a valid initial maxBorderBottomWidth property value', () => {
		expect(view.maxBorderBottomWidth).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial borderTopLeftRadius property value', () => {
		expect(view.borderTopLeftRadius).toBe(0)
	})

	it('should have a valid initial borderTopRightRadius property value', () => {
		expect(view.borderTopRightRadius).toBe(0)
	})

	it('should have a valid initial borderBottomLeftRadius property value', () => {
		expect(view.borderBottomLeftRadius).toBe(0)
	})

	it('should have a valid initial borderBottomRightRadius property value', () => {
		expect(view.borderBottomRightRadius).toBe(0)
	})

	it('should have a valid initial shadowBlur property value', () => {
		expect(view.shadowBlur).toBe(0)
	})

	it('should have a valid initial shadowColor property value', () => {
		expect(view.shadowColor).toBe('#000')
	})

	it('should have a valid initial shadowOffsetTop property value', () => {
		expect(view.shadowOffsetTop).toBe(0)
	})

	it('should have a valid initial shadowOffsetLeft property value', () => {
		expect(view.shadowOffsetLeft).toBe(0)
	})

	it('should have a valid initial top property value', () => {
		expect(view.top).toBe('auto')
	})

	it('should have a valid initial left property value', () => {
		expect(view.left).toBe('auto')
	})

	it('should have a valid initial right property value', () => {
		expect(view.right).toBe('auto')
	})

	it('should have a valid initial bottom property value', () => {
		expect(view.bottom).toBe('auto')
	})

	it('should have a valid initial minTop property value', () => {
		expect(view.minTop).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxTop property value', () => {
		expect(view.maxTop).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minLeft property value', () => {
		expect(view.minLeft).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxLeft property value', () => {
		expect(view.maxLeft).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minRight property value', () => {
		expect(view.minRight).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxRight property value', () => {
		expect(view.maxRight).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minBottom property value', () => {
		expect(view.minBottom).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxBottom property value', () => {
		expect(view.maxBottom).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial anchorTop property value', () => {
		expect(view.anchorTop).toBe(0)
	})

	it('should have a valid initial anchorLeft property value', () => {
		expect(view.anchorLeft).toBe(0)
	})

	it('should have a valid initial width property value', () => {
		expect(view.width).toBe('fill')
	})

	it('should have a valid initial height property value', () => {
		expect(view.height).toBe('fill')
	})

	it('should have a valid initial minWidth property value', () => {
		expect(view.minWidth).toBe(0)
	})

	it('should have a valid initial maxWidth property value', () => {
		expect(view.maxWidth).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minHeight property value', () => {
		expect(view.minHeight).toBe(0)
	})

	it('should have a valid initial maxHeight property value', () => {
		expect(view.maxHeight).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial expand property value', () => {
		expect(view.expand).toBe(0)
	})

	it('should have a valid initial shrink property value', () => {
		expect(view.shrink).toBe(0)
	})

	it('should have a valid initial contentTop property value', () => {
		expect(view.contentTop).toBe(0)
	})

	it('should have a valid initial contentLeft property value', () => {
		expect(view.contentLeft).toBe(0)
	})

	it('should have a valid initial contentWidth property value', () => {
		expect(view.contentWidth).toBe('auto')
	})

	it('should have a valid initial contentHeight property value', () => {
		expect(view.contentHeight).toBe('auto')
	})

	it('should have a valid initial contentInsetTop property value', () => {
		expect(view.contentInsetTop).toBe(0)
	})

	it('should have a valid initial contentInsetLeft property value', () => {
		expect(view.contentInsetLeft).toBe(0)
	})

	it('should have a valid initial contentInsetRight property value', () => {
		expect(view.contentInsetRight).toBe(0)
	})

	it('should have a valid initial contentInsetBottom property value', () => {
		expect(view.contentInsetBottom).toBe(0)
	})

	it('should have a valid initial contentOrientation property value', () => {
		expect(view.contentOrientation).toBe('vertical')
	})

	it('should have a valid initial contentDisposition property value', () => {
		expect(view.contentDisposition).toBe('start')
	})

	it('should have a valid initial contentArrangement property value', () => {
		expect(view.contentArrangement).toBe('start')
	})

	it('should have a valid initial scrollable property value', () => {
		expect(view.scrollable).toBe(false)
	})

	it('should have a valid initial scrollbars property value', () => {
		expect(view.scrollbars).toBe(false)
	})

	it('should have a valid initial overscroll property value', () => {
		expect(view.overscroll).toBe('auto')
	})

	it('should have a valid initial momentum property value', () => {
		expect(view.momentum).toBe(true)
	})

	it('should have a valid initial scrollTop property value', () => {
		expect(view.scrollTop).toBe(0)
	})

	it('should have a valid initial scrollLeft property value', () => {
		expect(view.scrollLeft).toBe(0)
	})

	it('should have a valid initial scrolling property value', () => {
		expect(view.scrolling).toBe(false)
	})

	it('should have a valid initial dragging property value', () => {
		expect(view.dragging).toBe(false)
	})

	it('should have a valid initial margin property value', () => {
		let margin = view.margin
		expect(margin.top).toBe(0)
		expect(margin.left).toBe(0)
		expect(margin.right).toBe(0)
		expect(margin.bottom).toBe(0)
	})

	it('should have a valid initial marginTop property value', () => {
		expect(view.marginTop).toBe(0)
	})

	it('should have a valid initial marginLeft property value', () => {
		expect(view.marginLeft).toBe(0)
	})

	it('should have a valid initial marginRight property value', () => {
		expect(view.marginRight).toBe(0)
	})

	it('should have a valid initial marginBottom property value', () => {
		expect(view.marginBottom).toBe(0)
	})

	it('should have a valid initial minMarginTop property value', () => {
		expect(view.minMarginTop).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxMarginTop property value', () => {
		expect(view.maxMarginTop).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minMarginLeft property value', () => {
		expect(view.minMarginLeft).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxMarginLeft property value', () => {
		expect(view.maxMarginLeft).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minMarginRight property value', () => {
		expect(view.minMarginRight).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxMarginRight property value', () => {
		expect(view.maxMarginRight).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minMarginBottom property value', () => {
		expect(view.minMarginBottom).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxMarginBottom property value', () => {
		expect(view.maxMarginBottom).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial paddingTop property value', () => {
		expect(view.paddingTop).toBe(0)
	})

	it('should have a valid initial paddingLeft property value', () => {
		expect(view.paddingLeft).toBe(0)
	})

	it('should have a valid initial paddingRight property value', () => {
		expect(view.paddingRight).toBe(0)
	})

	it('should have a valid initial paddingBottom property value', () => {
		expect(view.paddingBottom).toBe(0)
	})

	it('should have a valid initial padding property value', () => {
		let padding = view.padding
		expect(padding.top).toBe(0)
		expect(padding.left).toBe(0)
		expect(padding.right).toBe(0)
		expect(padding.bottom).toBe(0)
	})

	it('should have a valid initial paddingTop property value', () => {
		expect(view.paddingTop).toBe(0)
	})

	it('should have a valid initial paddingLeft property value', () => {
		expect(view.paddingLeft).toBe(0)
	})

	it('should have a valid initial paddingRight property value', () => {
		expect(view.paddingRight).toBe(0)
	})

	it('should have a valid initial paddingBottom property value', () => {
		expect(view.paddingBottom).toBe(0)
	})

	it('should have a valid initial minPaddingTop property value', () => {
		expect(view.minPaddingTop).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxPaddingTop property value', () => {
		expect(view.maxPaddingTop).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minPaddingLeft property value', () => {
		expect(view.minPaddingLeft).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxPaddingLeft property value', () => {
		expect(view.maxPaddingLeft).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minPaddingRight property value', () => {
		expect(view.minPaddingRight).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxPaddingRight property value', () => {
		expect(view.maxPaddingRight).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial minPaddingBottom property value', () => {
		expect(view.minPaddingBottom).toBeLessThanOrEqual(Number.MIN_VALUE)
	})

	it('should have a valid initial maxPaddingBottom property value', () => {
		expect(view.maxPaddingBottom).toBeGreaterThanOrEqual(Number.MAX_VALUE)
	})

	it('should have a valid initial visible property value', () => {
		expect(view.visible).toBe(true)
	})

	it('should have a valid initial opacity property value', () => {
		expect(view.opacity).toBe(1)
	})

	it('should have a valid initial originX property value', () => {
		expect(view.originX).toBe(0.5)
	})

	it('should have a valid initial originY property value', () => {
		expect(view.originY).toBe(0.5)
	})

	it('should have a valid initial originZ property value', () => {
		expect(view.originZ).toBe(0)
	})

	it('should have a valid initial translationX property value', () => {
		expect(view.translationX).toBe(0)
	})

	it('should have a valid initial translationY property value', () => {
		expect(view.translationY).toBe(0)
	})

	it('should have a valid initial translationZ property value', () => {
		expect(view.translationZ).toBe(0)
	})

	it('should have a valid initial rotationX property value', () => {
		expect(view.rotationX).toBe(0)
	})

	it('should have a valid initial rotationY property value', () => {
		expect(view.rotationY).toBe(0)
	})

	it('should have a valid initial rotationZ property value', () => {
		expect(view.rotationZ).toBe(0)
	})

	it('should have a valid initial scaleX property value', () => {
		expect(view.scaleX).toBe(1)
	})

	it('should have a valid initial scaleY property value', () => {
		expect(view.scaleY).toBe(1)
	})

	it('should have a valid initial scaleZ property value', () => {
		expect(view.scaleZ).toBe(1)
	})

	it('should have a valid initial zIndex property value', () => {
		expect(view.zIndex).toBe(0)
	})

	it('should have a valid initial clipped property value', () => {
		expect(view.clipped).toBe(true)
	})

	it('should have a valid initial zoomable property value', () => {
		expect(view.zoomable).toBe(false)
	})

	it('should have a valid initial minZoom property value', () => {
		expect(view.minZoom).toBe(1.0)
	})

	it('should have a valid initial maxZoon property value', () => {
		expect(view.maxZoom).toBe(1.0)
	})

	it('should have a valid initial zoomedView property value', () => {
		expect(view.zoomedView).toBeNull()
	})

	it('should have a valid initial touchable property value', () => {
		expect(view.touchable).toBe(true)
	})

	it('should have a valid initial touchOffsetTop property value', () => {
		expect(view.touchOffsetTop).toBe(0)
	})

	it('should have a valid initial touchOffsetLeft property value', () => {
		expect(view.touchOffsetLeft).toBe(0)
	})

	it('should have a valid initial touchOffsetRight property value', () => {
		expect(view.touchOffsetRight).toBe(0)
	})

	it('should have a valid initial touchOffsetBottom property value', () => {
		expect(view.touchOffsetBottom).toBe(0)
	})

	it('should have a valid initial paged property value', () => {
		expect(view.paged).toBe(false)
	})

	it('should have a valid initial measuredWidth property value', () => {
		expect(view.measuredWidth).toBe(0)
	})

	it('should have a valid initial measuredHeight property value', () => {
		expect(view.measuredHeight).toBe(0)
	})

	it('should have a valid initial measuredInnerWidth property value', () => {
		expect(view.measuredInnerWidth).toBe(0)
	})

	it('should have a valid initial measuredInnerHeight property value', () => {
		expect(view.measuredInnerHeight).toBe(0)
	})

	it('should have a valid initial measuredContentWidth property value', () => {
		expect(view.measuredContentWidth).toBe(0)
	})

	it('should have a valid initial measuredContentHeight property value', () => {
		expect(view.measuredContentHeight).toBe(0)
	})

	it('should have a valid initial measuredMarginTop property value', () => {
		expect(view.measuredMarginTop).toBe(0)
	})

	it('should have a valid initial measuredMarginLeft property value', () => {
		expect(view.measuredMarginLeft).toBe(0)
	})

	it('should have a valid initial measuredMarginRight property value', () => {
		expect(view.measuredMarginRight).toBe(0)
	})

	it('should have a valid initial measuredMarginBottom property value', () => {
		expect(view.measuredMarginBottom).toBe(0)
	})

	it('should have a valid initial measuredPaddingTop property value', () => {
		expect(view.measuredMarginBottom).toBe(0)
	})

	it('should have a valid initial measuredPaddingLeft property value', () => {
		expect(view.measuredMarginBottom).toBe(0)
	})

	it('should have a valid initial measuredPaddingRight property value', () => {
		expect(view.measuredMarginBottom).toBe(0)
	})

	it('should have a valid initial measuredPaddingBottom property value', () => {
		expect(view.measuredMarginBottom).toBe(0)
	})

	it('should have a native object', () => {
		expect(view.native).not.toBeUndefined()
	})

	it('should have a native object with an holder value', () => {
		expect(view.native.holder).toBe(view)
	})

	it('should append a child view', () => {

		let v1 = new View()
		let v2 = new View()

		view.append(v1)
		view.append(v2)

		expect(view.children[0]).toBe(v1)
		expect(view.children[1]).toBe(v2)

	})

	it('should insert a child view', () => {

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		view.append(v1)
		view.append(v2)
		view.insert(v3, 1)

		expect(view.children[0]).toBe(v1)
		expect(view.children[1]).toBe(v3)
		expect(view.children[2]).toBe(v2)

	})

	it('should insert a child view in a valid range', () => {

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()
		let v4 = new View()

		view.append(v1)
		view.append(v2)
		view.insert(v3, -10)
		view.insert(v4, +10)

		expect(view.children[0]).toBe(v3)
		expect(view.children[1]).toBe(v1)
		expect(view.children[2]).toBe(v2)
		expect(view.children[3]).toBe(v4)

	})

	it('should insert a child view after another', () => {

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		view.append(v1)
		view.append(v2)

		view.insertAfter(v3, v1)

		expect(view.children[0]).toBe(v1)
		expect(view.children[1]).toBe(v3)
		expect(view.children[2]).toBe(v2)

	})

	it('should insert a child view before another', () => {

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		view.append(v1)
		view.append(v2)

		view.insertBefore(v3, v1)

		expect(view.children[0]).toBe(v3)
		expect(view.children[1]).toBe(v1)
		expect(view.children[2]).toBe(v2)

	})

	it('should set the child view parent when inserting', () => {

		let root = new View()

		let v1 = new View()
		let v2 = new View()

		root.append(v1)
		root.append(v2)
		view.append(v1)

		expect(v1.parent).toBe(view)
		expect(v2.parent).toBe(root)

	})

	it('should set child view responder when inserting', () => {

		let root = new View()

		let v1 = new View()
		let v2 = new View()

		root.append(v1)
		root.append(v2)
		view.append(v1)

		expect(v1.responder).toBe(view)
		expect(v2.responder).toBe(root)

	})

	it('should emit an event when inserting', () => {

		let fn1 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.data.child).toBe(v1)
			expect(event.data.index).toBe(0)
		})

		let fn2 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.data.child).toBe(v2)
			expect(event.data.index).toBe(1)
		})

		let v1 = new View()
		let v2 = new View()

		view.one('insert', fn1)
		view.append(v1)
		view.one('insert', fn2)
		view.append(v2)

		expect(fn1).toHaveBeenCalled()
		expect(fn2).toHaveBeenCalled()

	})

	it('should remove a child view', () => {

		let v1 = new View()
		let v2 = new View()

		view.append(v1)
		view.append(v2)

		view.remove(v1)
		view.remove(v2)

		expect(view.children[0]).toBeUndefined()
		expect(view.children[1]).toBeUndefined()

	})

	it('should remove itself from a parent view', () => {

		let v1 = new View()
		let v2 = new View()

		view.append(v1)
		view.append(v2)

		v1.removeFromParent()
		v2.removeFromParent()

		expect(view.children[0]).toBeUndefined()
		expect(view.children[1]).toBeUndefined()

	})

	it('should clear the child view parent when removing', () => {

		let v1 = new View()

		view.append(v1)
		view.remove(v1)

		expect(v1.parent).toBeNull()

	})

	it('should clear the child view responder when removing', () => {

		let v1 = new View()

		view.append(v1)
		view.remove(v1)

		expect(v1.responder).toBeNull()

	})

	it('should emit an event when removing', () => {

		let fn1 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.data.child).toBe(v1)
			expect(event.data.index).toBe(0)
		})

		let fn2 = jasmine.createSpy().and.callFake((event: Event) => {
			expect(event.data.child).toBe(v2)
			expect(event.data.index).toBe(1)
		})

		let v1 = new View()
		let v2 = new View()

		view.append(v1)
		view.append(v2)

		view.one('remove', fn2)
		view.remove(v2)

		view.one('remove', fn1)
		view.remove(v1)

		expect(fn1).toHaveBeenCalled()
		expect(fn2).toHaveBeenCalled()

	})

	it('should remove all views', () => {

		let v1 = new View()
		let v2 = new View()

		view.append(v1)
		view.append(v2)

		view.empty()

		expect(view.children[0]).toBeUndefined()
		expect(view.children[1]).toBeUndefined()

	})

	it('should replace itself with another view', () => {

		let v1 = new View()
		let v2 = new View()

		view.append(v1)

		v1.replaceWith(v2)

		expect(view.children[0]).toBe(v2)
		expect(view.children[1]).toBeUndefined()

	})

	it('should check if a view is contained inside another', () => {

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()
		let v4 = new View()

		view.append(v1)
		view.append(v2)

		v2.append(v3)
		v3.append(v4)

		expect(view.contains(v1)).toBe(true)
		expect(view.contains(v2)).toBe(true)
		expect(view.contains(v3)).toBe(true)
		expect(view.contains(v4)).toBe(true)

	})

	it('should set a style', () => {

		view.setStyle('style1', true)
		view.setStyle('style1', false)
		view.setStyle('style2', true)

		expect(view.hasStyle('style1')).toBe(false)
		expect(view.hasStyle('style2')).toBe(true)
		expect(view.hasStyle('style3')).toBe(false)

	})

	it('should set a state', () => {

		view.setState('state1', true)
		view.setState('state1', false)
		view.setState('state2', true)

		expect(view.hasState('state1')).toBe(false)
		expect(view.hasState('state2')).toBe(true)
		expect(view.hasState('state3')).toBe(false)

	})

	it('should call the native view scheduleRedraw method', () => {

		view.native.scheduleRedraw = jasmine.createSpy()
		view.scheduleRedraw()

		expect(view.native.scheduleRedraw).toHaveBeenCalled()

	})

	it('should call the native view scheduleLayout method', () => {

		view.native.scheduleLayout = jasmine.createSpy()
		view.scheduleLayout()

		expect(view.native.scheduleLayout).toHaveBeenCalled()

	})

	it('should call the native view measure method', () => {

		view.native.measure = jasmine.createSpy()
		view.measure()

		expect(view.native.measure).toHaveBeenCalled()

	})

	it('should call the native view resolve method', () => {

		view.native.resolve = jasmine.createSpy()
		view.resolve()

		expect(view.native.resolve).toHaveBeenCalled()

	})

	it('should call the native view scrollTo method', () => {

		view.native.scrollTo = jasmine.createSpy()
		view.scrollTo(0, 0)

		expect(view.native.scrollTo).toHaveBeenCalled()

	})

	it('should invoke the internal listeners', () => {

		view.onTouchCancel = jasmine.createSpy()
		view.onTouchStart = jasmine.createSpy()
		view.onTouchMove = jasmine.createSpy()
		view.onTouchEnd = jasmine.createSpy()
		view.onDestroy = jasmine.createSpy()
		view.onBeforeLayout = jasmine.createSpy()
		view.onLayout = jasmine.createSpy()
		view.onRedraw = jasmine.createSpy()
		view.onInsert = jasmine.createSpy()
		view.onRemove = jasmine.createSpy()
		view.onMoveToParent = jasmine.createSpy()
		view.onMoveToWindow = jasmine.createSpy()
		view.onMount = jasmine.createSpy()
		view.onUnmount = jasmine.createSpy()
		view.onScrollStart = jasmine.createSpy()
		view.onScrollEnd = jasmine.createSpy()
		view.onScroll = jasmine.createSpy()
		view.onOverscroll = jasmine.createSpy()
		view.onDragStart = jasmine.createSpy()
		view.onDragEnd = jasmine.createSpy()
		view.onDrag = jasmine.createSpy()
		view.onZoomStart = jasmine.createSpy()
		view.onZoomEnd = jasmine.createSpy()
		view.onZoom = jasmine.createSpy()

		let touchCancel = new TouchEvent('touchcancel', {
			propagable: true,
			cancelable: false,
			dispatcher: view,
			touches: new TouchList([]),
			activeTouches: new TouchList([]),
			targetTouches: new TouchList([]),
		})

		let touchStart = new TouchEvent('touchstart', {
			propagable: true,
			cancelable: true,
			dispatcher: view,
			touches: new TouchList([]),
			activeTouches: new TouchList([]),
			targetTouches: new TouchList([]),
		})

		let touchMove = new TouchEvent('touchmove', {
			propagable: true,
			cancelable: true,
			dispatcher: view,
			touches: new TouchList([]),
			activeTouches: new TouchList([]),
			targetTouches: new TouchList([]),
		})

		let touchEnd = new TouchEvent('touchend', {
			propagable: true,
			cancelable: false,
			dispatcher: view,
			touches: new TouchList([]),
			activeTouches: new TouchList([]),
			targetTouches: new TouchList([]),
		})

		let canvas = new Canvas()

		view.emit(touchCancel)
		view.emit(touchStart)
		view.emit(touchMove)
		view.emit(touchEnd)

		view.emit('destroy')
		view.emit('beforelayout')
		view.emit('layout')
		view.emit(new Event('redraw', { data: { canvas } }))
		view.emit(new Event('insert', { data: { child: view, index: 1 } }))
		view.emit(new Event('remove', { data: { child: view, index: 1 } }))
		view.emit(new Event('movetoparent', { data: { parent: view } }))
		view.emit(new Event('movetowindow', { data: { window: view } }))
		view.emit('mount')
		view.emit('unmount')
		view.emit('scrollstart')
		view.emit('scrollend')
		view.emit('scroll')
		view.emit('overscroll')
		view.emit('dragstart')
		view.emit('dragend')
		view.emit('drag')
		view.emit('zoomstart')
		view.emit('zoomend')
		view.emit('zoom')

		expect(view.onDestroy).toHaveBeenCalled()
		expect(view.onBeforeLayout).toHaveBeenCalled()
		expect(view.onLayout).toHaveBeenCalled()
		expect(view.onRedraw).toHaveBeenCalledWith(canvas)
		expect(view.onInsert).toHaveBeenCalledWith(view, 1)
		expect(view.onRemove).toHaveBeenCalledWith(view, 1)
		expect(view.onMoveToParent).toHaveBeenCalledWith(view)
		expect(view.onMoveToWindow).toHaveBeenCalledWith(view)
		expect(view.onMount).toHaveBeenCalled()
		expect(view.onUnmount).toHaveBeenCalled()
		expect(view.onScrollStart).toHaveBeenCalled()
		expect(view.onScrollEnd).toHaveBeenCalled()
		expect(view.onScroll).toHaveBeenCalled()
		expect(view.onOverscroll).toHaveBeenCalled()
		expect(view.onDragStart).toHaveBeenCalled()
		expect(view.onDragEnd).toHaveBeenCalled()
		expect(view.onDrag).toHaveBeenCalled()
		expect(view.onZoomStart).toHaveBeenCalled()
		expect(view.onZoomEnd).toHaveBeenCalled()
		expect(view.onZoom).toHaveBeenCalled()

	})

})