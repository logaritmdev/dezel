import { Event } from '../../event/Event'
import { Canvas } from '../../graphic/Canvas'
import { TouchEvent } from '../../touch/TouchEvent'
import { TouchList } from '../../touch/TouchList'
import { View } from '../View'

jest.mock('../../core/Dezel')

describe('View', () => {

	let view: View

	beforeEach(() => {
		view = new View()
	})

	it('should have a native object', () => {
		expect(view.native).not.toBeUndefined()
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

		let fn1 = jest.fn(event => {
			expect(event.data.child).toBe(v1)
			expect(event.data.index).toBe(0)
		})

		let fn2 = jest.fn(event => {
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

		expect(view.children[0]).toBe(undefined)
		expect(view.children[1]).toBe(undefined)

	})

	it('should remove itself from a parent view', () => {

		let v1 = new View()
		let v2 = new View()

		view.append(v1)
		view.append(v2)

		v1.removeFromParent()
		v2.removeFromParent()

		expect(view.children[0]).toBe(undefined)
		expect(view.children[1]).toBe(undefined)

	})

	it('should clear the child view parent when removing', () => {

		let v1 = new View()

		view.append(v1)
		view.remove(v1)

		expect(v1.parent).toBe(null)

	})

	it('should clear the child view responder when removing', () => {

		let v1 = new View()

		view.append(v1)
		view.remove(v1)

		expect(v1.responder).toBe(null)

	})

	it('should emit an event when removing', () => {

		let fn1 = jest.fn(event => {
			expect(event.data.child).toBe(v1)
			expect(event.data.index).toBe(0)
		})

		let fn2 = jest.fn(event => {
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

		expect(view.children[0]).toBe(undefined)
		expect(view.children[1]).toBe(undefined)

	})

	it('should replace itself with another view', () => {

		let v1 = new View()
		let v2 = new View()

		view.append(v1)

		v1.replaceWith(v2)

		expect(view.children[0]).toBe(v2)
		expect(view.children[1]).toBe(undefined)

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

		view.native.scheduleRedraw = jest.fn()
		view.scheduleRedraw()

		expect(view.native.scheduleRedraw).toHaveBeenCalled()

	})

	it('should call the native view scheduleLayout method', () => {

		view.native.scheduleLayout = jest.fn()
		view.scheduleLayout()

		expect(view.native.scheduleLayout).toHaveBeenCalled()

	})

	it('should call the native view measure method', () => {

		view.native.measure = jest.fn()
		view.measure()

		expect(view.native.measure).toHaveBeenCalled()

	})

	it('should call the native view resolve method', () => {

		view.native.resolve = jest.fn()
		view.resolve()

		expect(view.native.resolve).toHaveBeenCalled()

	})

	it('should call the native view scrollTo method', () => {

		view.native.scrollTo = jest.fn()
		view.scrollTo(0, 0)

		expect(view.native.scrollTo).toHaveBeenCalled()

	})

	it('should invoke the internal listeners', () => {

		view.onTouchCancel = jest.fn()
		view.onTouchStart = jest.fn()
		view.onTouchMove = jest.fn()
		view.onTouchEnd = jest.fn()
		view.onDestroy = jest.fn()
		view.onBeforeLayout = jest.fn()
		view.onLayout = jest.fn()
		view.onRedraw = jest.fn()
		view.onInsert = jest.fn()
		view.onRemove = jest.fn()
		view.onMoveToParent = jest.fn()
		view.onMoveToWindow = jest.fn()
		view.onMount = jest.fn()
		view.onUnmount = jest.fn()
		view.onScrollStart = jest.fn()
		view.onScrollEnd = jest.fn()
		view.onScroll = jest.fn()
		view.onOverscroll = jest.fn()
		view.onDragStart = jest.fn()
		view.onDragEnd = jest.fn()
		view.onDrag = jest.fn()
		view.onZoomStart = jest.fn()
		view.onZoomEnd = jest.fn()
		view.onZoom = jest.fn()

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