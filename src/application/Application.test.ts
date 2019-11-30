import { Dezel } from '../core/Dezel'
import { TouchEvent } from '../touch/TouchEvent'
import { View } from '../view/View'
import { Application } from './Application'

describe('Application', () => {

	let application: Application

	beforeEach(() => {
		application = new Application()
		Dezel.registerApplication(application)
	})

	it('should dispatch the touch start event', () => {

		let fn = jasmine.createSpy().and.callFake((event: TouchEvent) => {
			expect(event.type).toBe('touchstart')
			expect(event.touches.length).toBe(1)
			expect(event.touches.get(0).x).toBe(10)
			expect(event.touches.get(0).y).toBe(20)
			expect(event.touches.get(0).canceled).toBe(false)
			expect(event.touches.get(0).captured).toBe(false)
		})

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		v1.on('touchstart', fn)
		v2.on('touchstart', fn)
		v3.on('touchstart', fn)

		v2.append(v3)
		v1.append(v2)

		application.window.append(v1)
		application.window.resolve()

		application.dispatchTouchStart([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		expect(fn).toHaveBeenCalledTimes(3)
	})

	it('should dispatch the touch move event', () => {

		let fn = jasmine.createSpy().and.callFake((event: TouchEvent) => {
			expect(event.type).toBe('touchmove')
			expect(event.touches.length).toBe(1)
			expect(event.touches.get(0).x).toBe(10)
			expect(event.touches.get(0).y).toBe(20)
			expect(event.touches.get(0).canceled).toBe(false)
			expect(event.touches.get(0).captured).toBe(false)
		})

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		v1.on('touchmove', fn)
		v2.on('touchmove', fn)
		v3.on('touchmove', fn)

		v2.append(v3)
		v1.append(v2)

		application.window.append(v1)
		application.window.resolve()

		application.dispatchTouchStart([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		application.dispatchTouchMove([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		expect(fn).toHaveBeenCalledTimes(3)
	})

	it('should dispatch the touch end event', () => {

		let fn = jasmine.createSpy().and.callFake((event: TouchEvent) => {
			expect(event.type).toBe('touchend')
			expect(event.touches.length).toBe(1)
			expect(event.touches.get(0).x).toBe(10)
			expect(event.touches.get(0).y).toBe(20)
			expect(event.touches.get(0).canceled).toBe(false)
			expect(event.touches.get(0).captured).toBe(false)
		})

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		v1.on('touchend', fn)
		v2.on('touchend', fn)
		v3.on('touchend', fn)

		v2.append(v3)
		v1.append(v2)

		application.window.append(v1)
		application.window.resolve()

		application.dispatchTouchStart([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		application.dispatchTouchEnd([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		expect(fn).toHaveBeenCalledTimes(3)
	})

	it('should dispatch the touch cancel event', () => {

		let fn = jasmine.createSpy().and.callFake((event: TouchEvent) => {
			expect(event.type).toBe('touchcancel')
			expect(event.touches.length).toBe(1)
			expect(event.touches.get(0).x).toBe(10)
			expect(event.touches.get(0).y).toBe(20)
			expect(event.touches.get(0).canceled).toBe(false)
			expect(event.touches.get(0).captured).toBe(false)
		})

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		v1.on('touchcancel', fn)
		v2.on('touchcancel', fn)
		v3.on('touchcancel', fn)

		v2.append(v3)
		v1.append(v2)

		application.window.append(v1)
		application.window.resolve()

		application.dispatchTouchStart([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		application.dispatchTouchCancel([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		expect(fn).toHaveBeenCalledTimes(3)
	})

	it('should cancel the touch start event', () => {

		let fn1 = jasmine.createSpy().and.callFake((event: TouchEvent) => {

			if (event.sender == v1) {
				expect(event.canceled).toBe(true)
				expect(event.touches.get(0).canceled).toBe(true)
				expect(event.touches.get(0).captured).toBe(false)
			} else {
				expect(event.touches.get(0).canceled).toBe(false)
				expect(event.touches.get(0).captured).toBe(false)
			}

		})

		let fn2 = jasmine.createSpy().and.callFake((event: TouchEvent) => {
			expect(event.type).toBe('touchcancel')
		})

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		v1.on('touchstart', (e: TouchEvent) => {
			e.cancel()
		})

		v1.on('touchstart', fn1)
		v2.on('touchstart', fn1)
		v3.on('touchstart', fn1)

		v1.on('touchcancel', fn2)
		v2.on('touchcancel', fn2)
		v3.on('touchcancel', fn2)

		v2.append(v3)
		v1.append(v2)

		application.window.append(v1)
		application.window.resolve()

		application.dispatchTouchStart([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		expect(fn1).toHaveBeenCalledTimes(3)
		expect(fn2).toHaveBeenCalledTimes(3)
	})

	it('should cancel the touch move event', () => {

		let fn1 = jasmine.createSpy().and.callFake((event: TouchEvent) => {

			if (event.sender == v1) {
				expect(event.canceled).toBe(true)
				expect(event.touches.get(0).canceled).toBe(true)
				expect(event.touches.get(0).captured).toBe(false)
			} else {
				expect(event.touches.get(0).canceled).toBe(false)
				expect(event.touches.get(0).captured).toBe(false)
			}

		})

		let fn2 = jasmine.createSpy().and.callFake((event: TouchEvent) => {
			expect(event.type).toBe('touchcancel')
		})

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		v1.id = "v1"
		v2.id = "v2"
		v3.id = "v3"

		v1.on('touchmove', (e: TouchEvent) => {
			e.cancel()
		})

		v1.on('touchmove', fn1)
		v2.on('touchmove', fn1)
		v3.on('touchmove', fn1)

		v1.on('touchcancel', fn2)
		v2.on('touchcancel', fn2)
		v3.on('touchcancel', fn2)

		v2.append(v3)
		v1.append(v2)

		application.window.append(v1)
		application.window.resolve()

		application.dispatchTouchStart([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		application.dispatchTouchMove([{
			id: 1,
			x: 40,
			y: 50,
			canceled: false,
			captured: false
		}])

		expect(fn1).toHaveBeenCalledTimes(3)
		expect(fn2).toHaveBeenCalledTimes(3)
	})

	it('should capture the touch start event', () => {

		let fn1 = jasmine.createSpy().and.callFake((event: TouchEvent) => {

			if (event.sender == v1) {
				expect(event.captured).toBe(true)
				expect(event.touches.get(0).canceled).toBe(false)
				expect(event.touches.get(0).captured).toBe(true)
			} else {
				expect(event.touches.get(0).canceled).toBe(false)
				expect(event.touches.get(0).captured).toBe(false)
			}

		})

		let fn2 = jasmine.createSpy().and.callFake((event: TouchEvent) => {
			expect(event.type).toBe('touchcancel')
		})

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		v1.on('touchstart', (e: TouchEvent) => {
			e.capture()
		})

		v1.on('touchstart', fn1)
		v2.on('touchstart', fn1)
		v3.on('touchstart', fn1)

		v1.on('touchcancel', fn2)
		v2.on('touchcancel', fn2)
		v3.on('touchcancel', fn2)

		v2.append(v3)
		v1.append(v2)

		application.window.append(v1)
		application.window.resolve()

		application.dispatchTouchStart([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		expect(fn1).toHaveBeenCalledTimes(3)
		expect(fn2).toHaveBeenCalledTimes(2)
	})

	it('should capture the touch move event', () => {

		let fn1 = jasmine.createSpy().and.callFake((event: TouchEvent) => {

			if (event.sender == v1) {
				expect(event.captured).toBe(true)
				expect(event.touches.get(0).canceled).toBe(false)
				expect(event.touches.get(0).captured).toBe(true)
			} else {
				expect(event.touches.get(0).canceled).toBe(false)
				expect(event.touches.get(0).captured).toBe(false)
			}

		})

		let fn2 = jasmine.createSpy().and.callFake((event: TouchEvent) => {
			expect(event.type).toBe('touchcancel')
		})

		let v1 = new View()
		let v2 = new View()
		let v3 = new View()

		v1.id = "v1"
		v2.id = "v2"
		v3.id = "v3"

		v1.on('touchmove', (e: TouchEvent) => {
			e.capture()
		})

		v1.on('touchmove', fn1)
		v2.on('touchmove', fn1)
		v3.on('touchmove', fn1)

		v1.on('touchcancel', fn2)
		v2.on('touchcancel', fn2)
		v3.on('touchcancel', fn2)

		v2.append(v3)
		v1.append(v2)

		application.window.append(v1)
		application.window.resolve()

		application.dispatchTouchStart([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		application.dispatchTouchMove([{
			id: 1,
			x: 10,
			y: 20,
			canceled: false,
			captured: false
		}])

		expect(fn1).toHaveBeenCalledTimes(3)
		expect(fn2).toHaveBeenCalledTimes(2)
	})

})