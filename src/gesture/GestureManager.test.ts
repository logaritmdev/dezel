import { Touch } from '../touch/Touch'
import { TouchList } from '../touch/TouchList'
import { Window } from '../view/Window'
import { GestureDetector } from './GestureDetector'
import { State } from './GestureDetector'
import { GestureManager } from './GestureManager'
import { TouchEvent } from '..'

describe('GestureManager', () => {

	let manager: GestureManager
	let window = new Window()

	beforeEach(() => {
		manager = new GestureManager(window)
	})

	it('should properly append a gesture', () => {

		let gesture = new TestGestureDetector((gesture: GestureDetector) => {

		})

		manager.append(gesture)

		expect(manager.gestures.includes(gesture)).toBe(true)
	})

	it('should properly remove a gesture', () => {

		let gesture = new TestGestureDetector((gesture: GestureDetector) => {

		})

		manager.append(gesture)
		manager.remove(gesture)

		expect(manager.gestures.includes(gesture)).toBe(false)
	})

	it('should properly set the view a when appending a gesture', () => {

		let gesture = new TestGestureDetector((gesture: GestureDetector) => {

		})

		manager.append(gesture)

		expect(gesture.view).toBe(window)
	})

	it('should properly set the view a when removing a gesture', () => {

		let gesture = new TestGestureDetector((gesture: GestureDetector) => {

		})

		manager.append(gesture)
		manager.remove(gesture)

		expect(gesture.view).toBe(null)
	})

	it('should properly reset the gesture when appending it', () => {

		let gesture = new TestGestureDetector((gesture: GestureDetector) => {

		})

		gesture.doDetect()

		manager.append(gesture)

		expect(gesture.state).toBe(State.Allowed)
		expect(gesture.captured).toBe(false)
		expect(gesture.resolved).toBe(false)
	})

	it('should properly reset the gesture when removing it', () => {

		let gesture = new TestGestureDetector((gesture: GestureDetector) => {

		})

		manager.append(gesture)
		gesture.doDetect()
		manager.remove(gesture)

		expect(gesture.state).toBe(State.Allowed)
		expect(gesture.captured).toBe(false)
		expect(gesture.resolved).toBe(false)
	})

	it('should route a touch properly', () => {

		let g1 = new TestGestureDetector(e => { });

		let s1 = g1 as any

		spyOn(s1, 'onTouchStart')
		spyOn(s1, 'onTouchMove')
		spyOn(s1, 'onTouchEnd')
		spyOn(s1, 'onTouchCancel')

		manager.append(g1)

		let touch = new Touch(window)

		manager.onTouchEvent(
			new TouchEvent('touchstart', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchmove', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchend', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchcancel', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		expect(s1.onTouchStart).toHaveBeenCalledTimes(1)
		expect(s1.onTouchMove).toHaveBeenCalledTimes(1)
		expect(s1.onTouchEnd).toHaveBeenCalledTimes(1)
		expect(s1.onTouchCancel).toHaveBeenCalledTimes(1)
	})

	it('should not route a touch to a disabled gesture', () => {

		let g1 = new TestGestureDetector(e => { });

		let s1 = g1 as any

		spyOn(s1, 'onTouchStart')
		spyOn(s1, 'onTouchMove')
		spyOn(s1, 'onTouchEnd')
		spyOn(s1, 'onTouchCancel')

		g1.enabled = false

		manager.append(g1)

		let touch = new Touch(window)

		manager.onTouchEvent(
			new TouchEvent('touchstart', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchmove', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchend', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		expect(s1.onTouchStart).not.toHaveBeenCalled()
		expect(s1.onTouchMove).not.toHaveBeenCalled()
		expect(s1.onTouchEnd).not.toHaveBeenCalled()
		expect(s1.onTouchCancel).not.toHaveBeenCalled()
	})

	it('should not route a touch to an ignored gesture', () => {

		let g1 = new TestGestureDetector(e => { });

		let s1 = g1 as any

		spyOn(s1, 'onTouchStart')
		spyOn(s1, 'onTouchMove')
		spyOn(s1, 'onTouchEnd')
		spyOn(s1, 'onTouchCancel')

		manager.append(g1)

		g1.doIgnore()

		let touch = new Touch(window)

		manager.onTouchEvent(
			new TouchEvent('touchstart', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchmove', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchend', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		expect(s1.onTouchStart).not.toHaveBeenCalled()
		expect(s1.onTouchMove).not.toHaveBeenCalled()
		expect(s1.onTouchEnd).not.toHaveBeenCalled()
		expect(s1.onTouchCancel).not.toHaveBeenCalled()
	})

	it('should not route a touch to an canceled gesture', () => {

		let g1 = new TestGestureDetector(e => { });

		let s1 = g1 as any

		spyOn(s1, 'onTouchStart')
		spyOn(s1, 'onTouchMove')
		spyOn(s1, 'onTouchEnd')
		spyOn(s1, 'onTouchCancel')

		manager.append(g1)

		g1.doCancel()

		let touch = new Touch(window)

		manager.onTouchEvent(
			new TouchEvent('touchstart', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchmove', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchend', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		expect(s1.onTouchStart).not.toHaveBeenCalled()
		expect(s1.onTouchMove).not.toHaveBeenCalled()
		expect(s1.onTouchEnd).not.toHaveBeenCalled()
		expect(s1.onTouchCancel).not.toHaveBeenCalled()
	})

	it('should not route a touch to an finished gesture', () => {

		let g1 = new TestGestureDetector(e => { });

		let s1 = g1 as any

		spyOn(s1, 'onTouchStart')
		spyOn(s1, 'onTouchMove')
		spyOn(s1, 'onTouchEnd')
		spyOn(s1, 'onTouchCancel')

		manager.append(g1)

		g1.doFinish()

		let touch = new Touch(window)

		manager.onTouchEvent(
			new TouchEvent('touchstart', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchmove', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchend', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		expect(s1.onTouchStart).not.toHaveBeenCalled()
		expect(s1.onTouchMove).not.toHaveBeenCalled()
		expect(s1.onTouchEnd).not.toHaveBeenCalled()
		expect(s1.onTouchCancel).not.toHaveBeenCalled()
	})

	it('should route a touch to the captured gesture', () => {

		let g1 = new TestGestureDetector(e => { }, { capture: true });
		let g2 = new TestGestureDetector(e => { })

		let s1 = g1 as any
		let s2 = g2 as any

		spyOn(s1, 'onTouchStart').and.callThrough()
		spyOn(s1, 'onTouchMove').and.callThrough()
		spyOn(s1, 'onTouchEnd').and.callThrough()
		spyOn(s1, 'onTouchCancel').and.callThrough()

		spyOn(s2, 'onTouchStart').and.callThrough()
		spyOn(s2, 'onTouchMove').and.callThrough()
		spyOn(s2, 'onTouchEnd').and.callThrough()
		spyOn(s2, 'onTouchCancel').and.callThrough()

		manager.append(g1)
		manager.append(g2)

		g1.detectOnTouchStart = true

		let touch = new Touch(window)

		manager.onTouchEvent(
			new TouchEvent('touchstart', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		expect(g1.state).toBe(State.Detected)

		manager.onTouchEvent(
			new TouchEvent('touchmove', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchend', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		expect(s1.onTouchStart).toHaveBeenCalledTimes(1)
		expect(s1.onTouchMove).toHaveBeenCalledTimes(1)
		expect(s1.onTouchEnd).toHaveBeenCalledTimes(1)

		expect(s2.onTouchStart).toHaveBeenCalledTimes(0)
		expect(s2.onTouchMove).toHaveBeenCalledTimes(0)
		expect(s2.onTouchEnd).toHaveBeenCalledTimes(0)
	})

	it('should route a touch to the captured gesture and respect the order', () => {

		let g1 = new TestGestureDetector(e => { }, { capture: true });
		let g2 = new TestGestureDetector(e => { })

		let s1 = g1 as any
		let s2 = g2 as any

		spyOn(s1, 'onTouchStart').and.callThrough()
		spyOn(s1, 'onTouchMove').and.callThrough()
		spyOn(s1, 'onTouchEnd').and.callThrough()
		spyOn(s1, 'onTouchCancel').and.callThrough()

		spyOn(s2, 'onTouchStart').and.callThrough()
		spyOn(s2, 'onTouchMove').and.callThrough()
		spyOn(s2, 'onTouchEnd').and.callThrough()
		spyOn(s2, 'onTouchCancel').and.callThrough()

		manager.append(g2)
		manager.append(g1)

		g1.detectOnTouchStart = true

		let touch = new Touch(window)

		manager.onTouchEvent(
			new TouchEvent('touchstart', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		expect(g1.state).toBe(State.Detected)

		manager.onTouchEvent(
			new TouchEvent('touchmove', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		manager.onTouchEvent(
			new TouchEvent('touchend', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: new TouchList([touch]),
				activeTouches: new TouchList([touch]),
				targetTouches: new TouchList([touch]),
			})
		)

		expect(s1.onTouchStart).toHaveBeenCalledTimes(1)
		expect(s1.onTouchMove).toHaveBeenCalledTimes(1)
		expect(s1.onTouchEnd).toHaveBeenCalledTimes(1)

		expect(s2.onTouchStart).toHaveBeenCalledTimes(1)
		expect(s2.onTouchMove).toHaveBeenCalledTimes(0)
		expect(s2.onTouchEnd).toHaveBeenCalledTimes(0)
	})

})

//------------------------------------------------------------------------------
// Classes
//------------------------------------------------------------------------------

class TestGestureDetector extends GestureDetector {

	public ignoreOnTouchStart: boolean = false
	public ignoreOnTouchMove: boolean = false
	public ignoreOnTouchEnd: boolean = false

	public detectOnTouchStart: boolean = false
	public detectOnTouchMove: boolean = false
	public detectOnTouchEnd: boolean = false

	public updateOnTouchStart: boolean = false
	public updateOnTouchMove: boolean = false
	public updateOnTouchEnd: boolean = false

	public finishOnTouchStart: boolean = false
	public finishOnTouchMove: boolean = false
	public finishOnTouchEnd: boolean = false

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

	protected onTouchStart(event: TouchEvent) {

		if (this.ignoreOnTouchStart) {
			this.ignore()
		}

		if (this.detectOnTouchStart) {
			this.detect()
		}

		if (this.updateOnTouchStart) {
			this.update()
		}

		if (this.finishOnTouchStart) {
			this.finish()
		}
	}

	protected onTouchMove(event: TouchEvent) {

		if (this.ignoreOnTouchMove) {
			this.ignore()
		}

		if (this.detectOnTouchMove) {
			this.detect()
		}

		if (this.updateOnTouchMove) {
			this.update()
		}

		if (this.finishOnTouchMove) {
			this.finish()
		}
	}

	protected onTouchEnd(event: TouchEvent) {

		if (this.ignoreOnTouchEnd) {
			this.ignore()
		}

		if (this.detectOnTouchEnd) {
			this.detect()
		}

		if (this.updateOnTouchEnd) {
			this.update()
		}

		if (this.finishOnTouchEnd) {
			this.finish()
		}
	}

	protected onTouchCancel(event: TouchEvent) {

	}

	protected onReset() {

	}
}
