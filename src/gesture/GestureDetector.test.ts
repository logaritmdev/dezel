import { TouchEvent } from '../event/TouchEvent'
import { GestureDetector } from './GestureDetector'
import { State } from './GestureDetector'

describe('GestureDetector', () => {

	let gesture: TestGestureDetector

	beforeEach(() => {
		gesture = new TestGestureDetector(e => { })
	})

	it('should start with the allowed state', () => {
		expect(gesture.state).toBe(State.Allowed)
	})

	it('should change the state to ignored', () => {
		gesture.doIgnore()
		expect(gesture.state).toBe(State.Ignored)
	})

	it('should change the state to detected', () => {
		gesture.doDetect()
		expect(gesture.state).toBe(State.Detected)
	})

	it('should change the state to updated', () => {
		gesture.doUpdate()
		expect(gesture.state).toBe(State.Updated)
	})

	it('should change the state to finished', () => {
		gesture.doFinish()
		expect(gesture.state).toBe(State.Finished)
	})

	it('should change the state to canceled', () => {
		gesture.doCancel()
		expect(gesture.state).toBe(State.Canceled)
	})

	it('should mark the gesture as resolved when changing the state to ignored', () => {
		gesture.doIgnore()
		expect(gesture.resolved).toBe(true)
	})

	it('should mark the gesture as resolved when changing the state to finished', () => {
		gesture.doFinish()
		expect(gesture.resolved).toBe(true)
	})

	it('should mark the gesture as resolved when changing the state to canceled', () => {
		gesture.doCancel()
		expect(gesture.resolved).toBe(true)
	})

	it('should not mark the gesture as resolved when changing the state to detected', () => {
		gesture.doDetect()
		expect(gesture.resolved).toBe(false)
	})

	it('should not mark the gesture as resolved when changing the state to updated', () => {
		gesture.doUpdate()
		expect(gesture.resolved).toBe(false)
	})

	it('should prevent state change once the gesture resolves', () => {
		gesture.doIgnore()
		expect(() => gesture.doDetect()).toThrowError()
		expect(() => gesture.doUpdate()).toThrowError()
		expect(() => gesture.doFinish()).toThrowError()
		expect(() => gesture.doCancel()).toThrowError()
	})

	it('should prevent state change to a lower value', () => {

		gesture.doDetect()
		expect(() => gesture.doIgnore()).toThrowError()

		gesture.doUpdate()
		expect(() => gesture.doDetect()).toThrowError()

		gesture.doFinish()
		expect(() => gesture.doUpdate()).toThrowError()

	})

	it('should allow the state to be set to updated multiple time', () => {

		gesture.doDetect()
		expect(() => gesture.doIgnore()).toThrowError()

		expect(() => gesture.doUpdate()).not.toThrowError()
		expect(() => gesture.doUpdate()).not.toThrowError()
		expect(() => gesture.doUpdate()).not.toThrowError()
	})

	it('should properly invoke the gesture callback', () => {

		let fn1 = jasmine.createSpy()

		let gesture = new TestGestureDetector(fn1)
		gesture.doDetect()
		gesture.doUpdate()
		gesture.doUpdate()
		gesture.doFinish()

		expect(fn1).toHaveBeenCalledTimes(3)
	})

	it('should not invoke the gesture callback when changing the state to ignored', () => {

		let fn1 = jasmine.createSpy()

		let gesture = new TestGestureDetector(fn1)
		gesture.doIgnore()

		expect(fn1).not.toHaveBeenCalled()
	})

	it('should not invoke the gesture callback when changing the state to canceled', () => {

		let fn1 = jasmine.createSpy()

		let gesture = new TestGestureDetector(fn1)
		gesture.doCancel()

		expect(fn1).not.toHaveBeenCalled()
	})
})

//------------------------------------------------------------------------------
// Classes
//------------------------------------------------------------------------------

class TestGestureDetector extends GestureDetector {

	public doIgnore() {
		return this.ignore()
	}

	public doDetect() {
		return this.detect()
	}

	public doUpdate() {
		return this.update()
	}

	public doFinish() {
		return this.finish()
	}

	public doCancel() {
		return this.cancel()
	}
}
